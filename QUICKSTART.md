# 🚀 Quick Start Guide

## Local Development

### First Time Setup
**macOS/Linux:**
```bash
bash setup.sh
npm run dev
```

**Windows:**
```bash
setup.bat
npm run dev
```

That's it! All three services (backend, frontend, ML) will start automatically.

### Individual Services
Run any service separately:
```bash
npm run backend     # Backend only (port 5000)
npm run frontend    # Frontend only (port 5173)
npm run ml          # ML service only (port 8000)
```

## Service URLs
- **Frontend**: http://localhost:5173
- **Backend**: http://localhost:5000/health
- **ML Service**: http://localhost:8000/health

## Deployment
See [DEPLOYMENT.md](./DEPLOYMENT.md) for detailed deployment instructions to:
- **Vercel** (Frontend)
- **Render** (Backend & ML Service)

## Environment Variables
Copy from `.env.example` files:
- `backend/.env.example` → `backend/.env`
- `frontend/.env.example` → `frontend/.env`
- `pharma_ml/.env.example` → `pharma_ml/.env`

(Auto-created by setup.sh/setup.bat)

## Troubleshooting

**Port already in use?**
- Change PORT in respective `.env` file

**Python venv issues?**
```bash
cd pharma_ml
python3 -m venv venv
source venv/bin/activate  # or venv\Scripts\activate.bat
pip install -r requirements.dev.txt
```

**Frontend can't reach backend?**
- Check `VITE_API_URL` in `frontend/.env`
- Ensure backend is running on port 5000

See DEPLOYMENT.md for production troubleshooting.
