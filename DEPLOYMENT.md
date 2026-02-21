# Deployment Guide for PharmaGuard

## 📋 Overview

This project uses three main services that can be deployed to different platforms:

- **Frontend**: Vercel (recommended)
- **Backend**: Render
- **ML Service**: Render

## 🚀 Local Development Setup

### Quick Start (One Command)

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

### Manual Setup

1. **Install Backend Dependencies**
   ```bash
   cd backend && npm install && cd ..
   ```

2. **Install Frontend Dependencies**
   ```bash
   cd frontend && npm install && cd ..
   ```

3. **Setup ML Service**
   ```bash
   cd pharma_ml
   python3 -m venv venv
   source venv/bin/activate  # or on Windows: venv\Scripts\activate.bat
   pip install -r requirements.dev.txt
   ```

4. **Install Root Dependencies**
   ```bash
   npm install
   ```

5. **Start All Services**
   ```bash
   npm run dev
   ```

---

## 🌐 Production Deployment

### Prerequisites

- **Vercel Account** (for frontend)
- **Render Account** (for backend and ML service)
- **GitHub Repository** (connected to Render/Vercel)

---

## 📦 Deploying to Render

### Option 1: Using render.yaml (Recommended)

1. **Push Code to GitHub**
   ```bash
   git add .
   git commit -m "Add deployment configs"
   git push origin main
   ```

2. **Connect to Render**
   - Go to [render.com](https://render.com)
   - Click "New +"
   - Select "YAML"
   - Connect your GitHub repository
   - Select branch: `main`
   - Render will automatically read `render.yaml`

3. **Set Environment Variables**
   - In Render dashboard for **backend** service:
     - `PYTHON_BACKEND_URL` → `https://pharmaguard-ml.onrender.com/predict`
     - `CORS_ORIGIN` → (your frontend URL from Vercel)
     - `GROQ_API_KEY` → (your API key)
   
   - In Render dashboard for **ml** service:
     - `CORS_ORIGINS` → (your frontend URL from Vercel)
     - `GROQ_API_KEY` → (your API key)

4. **Verify Services**
   - Backend health: `https://pharmaguard-backend.onrender.com/health`
   - ML health: `https://pharmaguard-ml.onrender.com/health`

### Option 2: Manual Render Setup

**For Backend Service:**
1. Create Web Service
2. Connect GitHub repo
3. Set:
   - **Build Command**: `cd backend && npm install`
   - **Start Command**: `cd backend && npm start`
   - **Environment**: Node.js
   - **Region**: Your preferred region

**For ML Service:**
1. Create Web Service
2. Connect GitHub repo
3. Set:
   - **Build Command**: `cd pharma_ml && pip install -r requirements.txt`
   - **Start Command**: `cd pharma_ml && uvicorn main:app --host 0.0.0.0 --port 8000`
   - **Environment**: Python 3.11
   - **Region**: Your preferred region

---

## 🌍 Deploying to Vercel (Frontend)

### Option 1: Using Git Integration (Recommended)

1. **Push to GitHub** (as above)

2. **Connect to Vercel**
   - Go to [vercel.com](https://vercel.com)
   - Click "Add New Project"
   - Select your GitHub repository
   - Select root directory: `./`
   - Framework: **Vite**

3. **Configure Build Settings**
   - **Build Command**: `cd frontend && npm run build`
   - **Output Directory**: `frontend/dist`
   - **Install Command**: `cd frontend && npm install`

4. **Add Environment Variables**
   - In Vercel project settings, add:
     - `VITE_API_URL` → `https://pharmaguard-backend.onrender.com`

5. **Deploy**
   - Vercel auto-deploys on every push to `main`

### Option 2: Vercel CLI

```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
cd frontend
vercel
```

---

## 🔗 Environment Variables Checklist

### Backend (.env)
```env
PORT=5000
NODE_ENV=production
PYTHON_BACKEND_URL=https://pharmaguard-ml.onrender.com/predict
CORS_ORIGIN=https://your-vercel-frontend-url.vercel.app
GROQ_API_KEY=your-groq-api-key
```

### ML Service (.env)
```env
PORT=8000
CORS_ORIGINS=https://your-vercel-frontend-url.vercel.app
ENABLE_LLM=true
GROQ_API_KEY=your-groq-api-key
```

### Frontend (.env)
```env
VITE_API_URL=https://pharmaguard-backend.onrender.com
```

---

## 🐛 Troubleshooting

### "Backend service not found"
- Ensure `PYTHON_BACKEND_URL` in backend .env points to correct Render ML service URL
- Check Render dashboard to verify ML service is running

### "CORS errors in browser"
- Verify `CORS_ORIGIN` in backend matches your frontend URL
- Verify `CORS_ORIGINS` in ML service includes your frontend domain

### "Frontend can't reach backend"
- Check `VITE_API_URL` in frontend .env
- Ensure backend service is running (`/health` endpoint should respond)

### "Python dependencies failing on Render"
- Render may not have all native dependencies
- For Windows development, use `requirements.dev.txt` (excludes cyvcf2)
- For production on Render (Linux), install full `requirements.txt`

---

## 📊 Status Monitoring

### Health Endpoints

**Backend:**
- `GET /health` → Returns `{ status: "ok" }`

**ML Service:**
- `GET /health` → Returns `{ status: "ok" }`

**Frontend:**
- Deployed at Vercel, accessible at your app URL

---

## 🔄 CI/CD Pipeline

Both Render and Vercel support automatic deployments:

1. Push code to `main` branch
2. GitHub webhook triggers builds on both platforms
3. Tests run (if configured in package.json)
4. Services auto-deploy if tests pass

---

## 📝 Notes

- All `.env` files should be added to `.gitignore` (already configured)
- Use `.env.example` as template for new developers
- Never commit actual API keys or secrets
- Production builds are optimized; local dev uses hot reload

---

## 🆘 Need Help?

- Render docs: https://render.com/docs
- Vercel docs: https://vercel.com/docs
- FastAPI docs: https://fastapi.tiangolo.com
- Express docs: https://expressjs.com
