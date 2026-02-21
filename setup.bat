@echo off
REM ==================================================
REM Setup script for PharmaGuard local development
REM Windows
REM ==================================================

setlocal enabledelayedexpansion

echo.
echo ========================================
echo 🚀 Setting up PharmaGuard development
echo ========================================
echo.

REM ============= Backend Setup =============
echo [1/5] Installing backend dependencies...
cd backend
call npm install
if errorlevel 1 (
    echo ❌ Backend setup failed
    exit /b 1
)
cd ..
echo ✓ Backend ready
echo.

REM ============= Frontend Setup =============
echo [2/5] Installing frontend dependencies...
cd frontend
call npm install
if errorlevel 1 (
    echo ❌ Frontend setup failed
    exit /b 1
)
cd ..
echo ✓ Frontend ready
echo.

REM ============= ML Service Setup =============
echo [3/5] Setting up ML service...
cd pharma_ml

REM Create virtual environment if it doesn't exist
if not exist "venv" (
    echo Creating Python virtual environment...
    python -m venv venv
    if errorlevel 1 (
        echo ❌ Failed to create venv
        exit /b 1
    )
)

REM Activate virtual environment
call venv\Scripts\activate.bat

REM Upgrade pip
python -m pip install --upgrade pip

REM Install requirements
echo Installing Python dependencies...
pip install -r requirements.dev.txt
if errorlevel 1 (
    echo Trying requirements.txt instead...
    pip install -r requirements.txt
    if errorlevel 1 (
        echo ❌ ML setup failed
        exit /b 1
    )
)

REM Deactivate for now
call venv\Scripts\deactivate.bat
cd ..
echo ✓ ML service ready
echo.

REM ============= Environment Files =============
echo [4/5] Creating environment files...

if not exist "backend\.env" (
    (
        echo PORT=5000
        echo ML_SERVICE_URL=http://localhost:8000
    ) > backend\.env
    echo ✓ Created backend\.env
) else (
    echo backend\.env already exists
)

if not exist "frontend\.env" (
    (
        echo VITE_API_URL=http://localhost:5000
    ) > frontend\.env
    echo ✓ Created frontend\.env
) else (
    echo frontend\.env already exists
)

if not exist "pharma_ml\.env" (
    (
        echo PORT=8000
    ) > pharma_ml\.env
    echo ✓ Created pharma_ml\.env
) else (
    echo pharma_ml\.env already exists
)

echo.

REM ============= Root Dependencies =============
echo [5/5] Installing root dependencies...
call npm install
if errorlevel 1 (
    echo ❌ Root setup failed
    exit /b 1
)
echo ✓ Root dependencies installed
echo.

REM ============= Success Message =============
echo ========================================
echo ✅ Setup Complete!
echo ========================================
echo.
echo Next steps:
echo   1. Run: npm run dev
echo   2. Frontend: http://localhost:5173
echo   3. Backend:  http://localhost:5000/health
echo   4. ML:       http://localhost:8000/health
echo.
echo All services will run concurrently.
echo.
endlocal
