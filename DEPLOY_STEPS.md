# 📚 Complete Deployment Steps for PharmaGuard

## Phase 1: Prepare Repository

### Step 1: Push All Changes to GitHub

```bash
git add .
git commit -m "feat: add deployment configs, setup scripts, and .env examples"
git push origin main
```

Verify everything is pushed:
```bash
git status  # Should show "nothing to commit"
```

---

## Phase 2: Deploy Backend to Render

### Step 1: Log In to Render
1. Go to **https://render.com**
2. Sign up or log in (GitHub recommended for easier integration)

### Step 2: Create Backend Service
1. Click **"New +"** → Select **"Web Service"**
2. Select **"Deploy an existing repository"**
3. Connect your GitHub account if prompted
4. Find and select your `PharmaGuard` repository
5. Click **"Connect"**

### Step 3: Configure Backend Service
Fill in these fields:

| Field | Value |
|-------|-------|
| **Name** | `pharmaguard-backend` |
| **Environment** | `Node` |
| **Build Command** | `cd backend && npm install` |
| **Start Command** | `cd backend && npm start` |
| **Branch** | `main` |

### Step 4: Add Environment Variables for Backend
Scroll down to **"Environment"** section:

Click **"Add Environment Variable"** for each:

```
PORT = 5000
NODE_ENV = production
PYTHON_BACKEND_URL = [LEAVE EMPTY - set after ML deploys]
CORS_ORIGIN = [LEAVE EMPTY - set after Frontend deploys]
```

⚠️ **Note:** You'll update `PYTHON_BACKEND_URL` and `CORS_ORIGIN` after deploying ML and Frontend.

### Step 5: Deploy Backend
1. Click **"Create Web Service"**
2. Render will start building (takes 1-2 minutes)
3. Wait for green checkmark ✓
4. Copy the service URL: `https://pharmaguard-backend.onrender.com`

### Step 6: Verify Backend
Test the health endpoint:
```
https://pharmaguard-backend.onrender.com/health
```
Should return: `{"status":"ok"}`

---

## Phase 3: Deploy ML Service to Render

### Step 1: Create ML Service
1. In Render dashboard, click **"New +"** → **"Web Service"**
2. Connect your `PharmaGuard` repository again
3. Click **"Connect"**

### Step 2: Configure ML Service
Fill in these fields:

| Field | Value |
|-------|-------|
| **Name** | `pharmaguard-ml` |
| **Environment** | `Python 3.11` |
| **Build Command** | `cd pharma_ml && pip install -r requirements.txt` |
| **Start Command** | `cd pharma_ml && uvicorn main:app --host 0.0.0.0 --port 8000` |
| **Branch** | `main` |

### Step 3: Add Environment Variables for ML
Click **"Add Environment Variable"** for each:

```
PORT = 8000
CORS_ORIGINS = [LEAVE EMPTY - set after Frontend deploys]
ENABLE_LLM = true
GROQ_API_KEY = [your-groq-api-key] (optional)
MAX_CONTENT_LENGTH = 5242880
```

### Step 4: Deploy ML Service
1. Click **"Create Web Service"**
2. Wait for build to complete (2-3 minutes, takes longer for Python)
3. Copy the service URL: `https://pharmaguard-ml.onrender.com`

### Step 5: Verify ML Service
Test the health endpoint:
```
https://pharmaguard-ml.onrender.com/health
```
Should return: `{"status":"ok"}`

### Step 6: Update Backend with ML URL
1. Go back to **Backend service** in Render
2. Click **"Environment"**
3. Update `PYTHON_BACKEND_URL`:
   ```
   https://pharmaguard-ml.onrender.com/predict
   ```
4. Click **"Save"** → Render will auto-redeploy backend

---

## Phase 4: Deploy Frontend to Vercel

### Step 1: Log In to Vercel
1. Go to **https://vercel.com**
2. Sign up or log in with GitHub

### Step 2: Create Frontend Project
1. Click **"Add New..."** → **"Project"**
2. Click **"Import Git Repository"**
3. Find your `PharmaGuard` repository
4. Click **"Import"**

### Step 3: Configure Project Settings
In the import dialog:

| Field | Value |
|-------|-------|
| **Project Name** | `pharmaguard` |
| **Framework Preset** | `Vite` |
| **Root Directory** | `./` |

Click **"Edit"** and go to **"Configure Build Settings"**:

| Field | Value |
|-------|-------|
| **Build Command** | `cd frontend && npm run build` |
| **Output Directory** | `frontend/dist` |
| **Install Command** | `cd frontend && npm install` |

### Step 4: Add Environment Variables
In the environment variables section, add:

```
VITE_API_URL = https://pharmaguard-backend.onrender.com
```

### Step 5: Deploy Frontend
1. Click **"Deploy"**
2. Vercel will build and deploy (takes 1-2 minutes)
3. Wait for deployment to complete
4. Copy your app URL: `https://pharmaguard-xxxxx.vercel.app`

### Step 6: Update CORS Origins
Now update both services with your Vercel frontend URL:

**Backend (Render):**
1. Go to Backend service
2. Click **"Environment"**
3. Update `CORS_ORIGIN`:
   ```
   https://pharmaguard-xxxxx.vercel.app
   ```
4. Click **"Save"**

**ML Service (Render):**
1. Go to ML service
2. Click **"Environment"**
3. Update `CORS_ORIGINS`:
   ```
   https://pharmaguard-xxxxx.vercel.app
   ```
4. Click **"Save"**

---

## Phase 5: Verify Complete Deployment

### Test Frontend
```
https://pharmaguard-xxxxx.vercel.app
```
Should load the application

### Test Backend Health
```
https://pharmaguard-backend.onrender.com/health
```
Response: `{"status":"ok"}`

### Test ML Health
```
https://pharmaguard-ml.onrender.com/health
```
Response: `{"status":"ok"}`

### Test Frontend-Backend Connection
1. Open DevTools (F12) → Console
2. Go to your Vercel app
3. Check Network tab for `/api/*` requests
4. Should connect to `https://pharmaguard-backend.onrender.com`

---

## Phase 6: Set Up Auto-Deployments

### Render Auto-Deploy
✅ **Already configured** in `render.yaml`:
- Both services auto-deploy when you push to `main`

### Vercel Auto-Deploy
✅ **Already configured**:
- Frontend auto-deploys when you push to `main`

Future deployments:
```bash
git push origin main
# Both Render services update automatically
# Vercel frontend updates automatically
```

---

## 🔄 Continuous Deployment Workflow

After initial setup, deployments are automatic:

```bash
# Make code changes
git add .
git commit -m "your message"
git push origin main

# Services auto-deploy:
# ✓ Backend (Render) - ~2 min
# ✓ ML Service (Render) - ~3 min  
# ✓ Frontend (Vercel) - ~1 min
```

---

## ⚠️ Troubleshooting Deployments

### Backend returns 502 error

**Check 1: Verify environment variables**
```bash
# On your local backend, test:
curl http://localhost:5000/health
```

**Check 2: Check Render logs**
1. Go to Backend service on Render
2. Click **"Logs"**
3. Look for error messages

**Check 3: Restart service**
1. Go to Backend service
2. Click **"Environment"** → **"View"** → Scroll down
3. Find and click **"Manual Deploy"** → Deploy again

### Frontend can't reach backend

**Check 1: Verify VITE_API_URL**
1. In Vercel dashboard, go to Settings → Environment Variables
2. Ensure `VITE_API_URL` is set to backend Render URL
3. Redeploy frontend (push a commit or click Redeploy)

**Check 2: Check CORS settings**
- Verify backend `CORS_ORIGIN` matches your Vercel URL exactly
- Include full domain: `https://pharmaguard-xxxxx.vercel.app`

**Check 3: Test in browser console**
```javascript
fetch('https://pharmaguard-backend.onrender.com/health')
  .then(r => r.json())
  .then(d => console.log(d))
```
Should log: `{status: "ok"}`

### ML Service returns 503

**Check 1: Verify Python dependencies**
1. Go to ML service on Render
2. Click **"Logs"**
3. Check for "ModuleNotFoundError"

**Check 2: Dependencies issue**
- Render uses `requirements.txt` (production)
- Local dev uses `requirements.dev.txt`
- Ensure all core packages are in `requirements.txt`

### Services keep cycling (restarting repeatedly)

**Likely cause:** Build failing silently

**Solution:**
1. Go to service on Render
2. Click **"Logs"** → **"Build Logs"**
3. Read error message
4. Fix locally, push to GitHub
5. Click **"Manual Deploy"** on Render

---

## 📊 Monitoring & Logs

### View Logs

**Render Backend:**
Dashboard → Backend Service → Logs

**Render ML:**
Dashboard → ML Service → Logs

**Vercel Frontend:**
Dashboard → Deployments → Select deployment → View logs

### Set Up Alerts (Optional)

Both Render and Vercel offer email notifications for:
- Failed deployments
- Service downtime
- Critical errors

---

## 💰 Pricing Notes

### Render (Free Tier)
- Spins down after 15 min inactivity (cold start ~30s)
- Free SSL/HTTPS
- Supports 0.5 CPU, 0.5 GB RAM
- Sufficient for dev/testing

### Vercel (Free Tier)
- Unlimited deployments
- Unlimited bandwidth
- Free SSL/HTTPS
- Good for production frontend

### Upgrade if needed:
- **Render**: $7/month per service (to keep always-on)
- **Vercel**: $20/month (Pro plan, optional)

---

## ✅ Deployment Checklist

- [ ] All code pushed to GitHub (`main` branch)
- [ ] Backend deployed to Render
- [ ] ML service deployed to Render
- [ ] Frontend deployed to Vercel
- [ ] Backend environment variables set (including ML URL)
- [ ] ML environment variables set (including Frontend URL)
- [ ] Frontend environment variables set (including Backend URL)
- [ ] All services redeployed after updating URLs
- [ ] Health endpoints return `{"status":"ok"}`
- [ ] Frontend can reach backend (test in browser console)
- [ ] Auto-deployments enabled for future pushes

---

## 🚀 You're Live!

Your production app is now running on:

- **Frontend**: `https://pharmaguard-xxxxx.vercel.app`
- **Backend**: `https://pharmaguard-backend.onrender.com`
- **ML Service**: `https://pharmaguard-ml.onrender.com`

Share your Vercel URL with users!

---

## 📞 Quick Support Links

- **Render Docs**: https://render.com/docs
- **Vercel Docs**: https://vercel.com/docs
- **FastAPI Docs**: https://fastapi.tiangolo.com
- **Express Docs**: https://expressjs.com
