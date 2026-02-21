from fastapi import FastAPI, UploadFile, File, Form, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from typing import List, Optional
import os
import tempfile
import shutil
import json

# Attempt to reuse existing pipeline implementation
# Import pipeline lazily inside the handler so the API can start even if
# heavy native dependencies (like cyvcf2/htslib) are not installed.
_pipeline_imported = False

def _import_pipeline():
    global _pipeline_imported
    if _pipeline_imported:
        from pipeline import run_pipeline_multi
        return run_pipeline_multi
    try:
        from pipeline import run_pipeline_multi
        _pipeline_imported = True
        return run_pipeline_multi
    except Exception as e:
        raise

app = FastAPI()

origins = os.getenv("CORS_ORIGINS", "*")
if origins:
    origins_list = [o.strip() for o in origins.split(",") if o.strip()]
else:
    origins_list = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins_list,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/health")
def health():
    return {"status": "ok"}


@app.post("/predict")
async def predict(
    vcf_file: UploadFile = File(...),
    drugs: Optional[str] = Form(None),
    patient_id: Optional[str] = Form(None),
    enable_llm: Optional[str] = Form(None),
):
    if not vcf_file.filename.lower().endswith('.vcf'):
        raise HTTPException(status_code=400, detail="Only .vcf files are supported")

    tmp_path = None
    try:
        suffix = ".vcf"
        with tempfile.NamedTemporaryFile(prefix="pharmaguard_", suffix=suffix, delete=False) as tmp:
            tmp_path = tmp.name
            shutil.copyfileobj(vcf_file.file, tmp)

        # parse drugs field
        drugs_list = []
        if drugs:
            try:
                if drugs.strip().startswith('['):
                    val = json.loads(drugs)
                    if isinstance(val, list):
                        drugs_list = [str(x).strip() for x in val if str(x).strip()]
                else:
                    drugs_list = [s.strip() for s in drugs.split(',') if s.strip()]
            except Exception:
                drugs_list = [s.strip() for s in drugs.split(',') if s.strip()]

        if not drugs_list:
            raise HTTPException(status_code=400, detail='Drugs field is required')

        enable_llm_flag = True
        if enable_llm is not None:
            enable_llm_flag = str(enable_llm).strip().lower() in {"1", "true", "yes", "on"}

        try:
            run_pipeline = _import_pipeline()
        except Exception as e:
            raise HTTPException(status_code=503, detail=f"Pipeline import failed: {e}. Install native dependencies (cyvcf2/htslib) or run in WSL/Linux.")

        reports = run_pipeline(tmp_path, drugs_list, patient_id=patient_id, enable_llm=enable_llm_flag)
        return {"status": "success", "results": reports}
    finally:
        if tmp_path and os.path.exists(tmp_path):
            try:
                os.remove(tmp_path)
            except Exception:
                pass
