#!/bin/bash

# ==================================================
# Start script for PharmaGuard development
# Runs all services concurrently
# ==================================================

set -e

echo "🚀 Starting PharmaGuard services..."
echo ""
echo "Frontend:  http://localhost:5173"
echo "Backend:   http://localhost:5000"
echo "ML:        http://localhost:8000"
echo ""
echo "Press Ctrl+C to stop all services"
echo ""

npx concurrently \
  --names "BACKEND,FRONTEND,ML-SERVICE" \
  --prefix "[{name}]" \
  --prefix-colors "blue,cyan,magenta" \
  "cd backend && npm run dev" \
  "cd frontend && npm run dev" \
  "cd pharma_ml && source venv/bin/activate && uvicorn main:app --reload --host 0.0.0.0 --port 8000"
