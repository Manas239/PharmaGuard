#!/bin/bash

# ==================================================
# Setup script for PharmaGuard local development
# Supports macOS and Linux
# ==================================================

set -e  # Exit on error

echo "🚀 Setting up PharmaGuard development environment..."
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ============= Backend Setup =============
echo -e "${BLUE}📦 Backend Setup${NC}"
cd backend
echo "Installing backend dependencies..."
npm install
echo -e "${GREEN}✓ Backend dependencies installed${NC}"
cd ..
echo ""

# ============= Frontend Setup =============
echo -e "${BLUE}📦 Frontend Setup${NC}"
cd frontend
echo "Installing frontend dependencies..."
npm install
echo -e "${GREEN}✓ Frontend dependencies installed${NC}"
cd ..
echo ""

# ============= ML Service Setup =============
echo -e "${BLUE}🐍 ML Service Setup${NC}"
cd pharma_ml

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
  echo "Creating Python virtual environment..."
  python3 -m venv venv
  echo -e "${GREEN}✓ Virtual environment created${NC}"
else
  echo "Virtual environment already exists"
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip

# Install requirements
echo "Installing Python dependencies..."
pip install -r requirements.dev.txt || pip install -r requirements.txt
echo -e "${GREEN}✓ Python dependencies installed${NC}"

# Deactivate venv
deactivate
cd ..
echo ""

# ============= Environment Files =============
echo -e "${BLUE}📄 Creating environment files${NC}"

# Backend .env
if [ ! -f "backend/.env" ]; then
  cp backend/.env.example backend/.env 2>/dev/null || echo "PORT=5000
ML_SERVICE_URL=http://localhost:8000" > backend/.env
  echo -e "${GREEN}✓ Created backend/.env${NC}"
else
  echo "backend/.env already exists"
fi

# Frontend .env
if [ ! -f "frontend/.env" ]; then
  cp frontend/.env.example frontend/.env 2>/dev/null || echo "VITE_API_URL=http://localhost:5000" > frontend/.env
  echo -e "${GREEN}✓ Created frontend/.env${NC}"
else
  echo "frontend/.env already exists"
fi

# ML Service .env
if [ ! -f "pharma_ml/.env" ]; then
  cp pharma_ml/.env.example pharma_ml/.env 2>/dev/null || echo "PORT=8000" > pharma_ml/.env
  echo -e "${GREEN}✓ Created pharma_ml/.env${NC}"
else
  echo "pharma_ml/.env already exists"
fi

echo ""

# ============= Root Dependencies =============
echo -e "${BLUE}📦 Installing root dependencies${NC}"
npm install
echo -e "${GREEN}✓ Root dependencies installed${NC}"
echo ""

# ============= Success Message =============
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Setup Complete!${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo ""
echo "Next steps:"
echo -e "  1. Run ${YELLOW}npm run dev${NC} to start all services"
echo -e "  2. Frontend: http://localhost:5173"
echo -e "  3. Backend:  http://localhost:5000/health"
echo -e "  4. ML:       http://localhost:8000/health"
echo ""
echo "Services will run concurrently."
echo ""
