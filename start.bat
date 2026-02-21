@echo off
REM ==================================================
REM Start script for PharmaGuard development
REM Runs all services concurrently (Windows)
REM ==================================================

echo.
echo 🚀 Starting PharmaGuard services...
echo.
echo Frontend:  http://localhost:5173
echo Backend:   http://localhost:5000
echo ML:        http://localhost:8000
echo.
echo Press Ctrl+C to stop all services
echo.

REM Run concurrently using the helper script
cd pharma_ml
call venv\Scripts\activate.bat
cd ..

npx concurrently ^
  --names "BACKEND,FRONTEND,ML-SERVICE" ^
  --prefix "[{name}]" ^
  --prefix-colors "blue,cyan,magenta" ^
  "cd backend && npm run dev" ^
  "cd frontend && npm run dev" ^
  "cd pharma_ml && venv\Scripts\activate.bat && uvicorn main:app --reload --host 0.0.0.0 --port 8000"
