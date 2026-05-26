# 🚀 One-Click Deployment

## ⚡ Browser-ல் Direct Deploy செய்யுங்கள்!

---

## 🎯 Method 1: Vercel Dashboard (Easiest)

### Step 1: Vercel-ல் Login

இந்த link-ஐ click செய்யவும்:

**👉 https://vercel.com/new**

### Step 2: Import Repository

```
1. "Import Git Repository" click செய்யவும்
2. Search: "role-based-workflow-system"
3. "Import" click செய்யவும்
```

### Step 3: Configure Project

```
Framework Preset: Vite
Root Directory: frontend
Build Command: npm run build
Output Directory: dist
Install Command: npm install
```

### Step 4: Environment Variables

```
Key: VITE_API_URL
Value: https://your-backend-url.up.railway.app

(முதலில் backend deploy செய்து, அந்த URL-ஐ இங்கே paste செய்யவும்)
```

### Step 5: Deploy

```
"Deploy" button click செய்யவும்
2-3 நிமிடம் wait செய்யவும்
Done! 🎉
```

---

## 🎯 Method 2: Deploy Button (Super Easy!)

### Frontend Deploy:

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/Akila1806/role-based-workflow-system&root-directory=frontend&env=VITE_API_URL&envDescription=Backend%20API%20URL&envLink=https://github.com/Akila1806/role-based-workflow-system&project-name=workflow-frontend&repository-name=workflow-frontend)

**Click this button:**
```
https://vercel.com/new/clone?repository-url=https://github.com/Akila1806/role-based-workflow-system&root-directory=frontend
```

---

## 🎯 Method 3: Railway Backend Deploy

### Backend Deploy Button:

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/Akila1806/role-based-workflow-system&plugins=postgresql&envs=JWT_SECRET,PORT,NODE_ENV&JWTSecretDesc=Secret+key+for+JWT&PORTDefault=5000&NODE_ENVDefault=production)

**Click this button:**
```
https://railway.app/new/template?template=https://github.com/Akila1806/role-based-workflow-system
```

---

## 📋 Complete Deployment Order:

### 1️⃣ Database (Neon - 3 mins)

```
1. https://neon.tech/ → Sign up
2. Create project: workflow-db
3. SQL Editor → Run COMPLETE_DATABASE_SETUP.sql
4. Copy connection string
```

### 2️⃣ Backend (Railway - 5 mins)

**Option A: Railway Button**
```
Click: https://railway.app/new
Select: Deploy from GitHub repo
Repo: Akila1806/role-based-workflow-system
Root Directory: backend
```

**Environment Variables:**
```
DB_HOST=your-neon-host.neon.tech
DB_PORT=5432
DB_NAME=neondb
DB_USER=your-neon-username
DB_PASSWORD=your-neon-password
JWT_SECRET=my-super-secret-jwt-key-2024
PORT=5000
NODE_ENV=production
```

**Copy Backend URL:**
```
Example: https://your-app.up.railway.app
```

### 3️⃣ Frontend (Vercel - 5 mins)

**Option A: Vercel Button**
```
Click: https://vercel.com/new
Import: Akila1806/role-based-workflow-system
Root Directory: frontend
```

**Environment Variable:**
```
VITE_API_URL=https://your-backend-url.up.railway.app
```

**Deploy!**

---

## ✅ Testing:

### Backend:
```
https://your-backend.up.railway.app/api/health
```

### Frontend:
```
https://your-app.vercel.app
```

### Login:
```
Email: user@example.com
Password: password123
```

---

## 🎊 Success!

Your app is now LIVE! 🚀

**Share your links:**
- Frontend: https://your-app.vercel.app
- Backend: https://your-backend.up.railway.app

---

## 📞 Help:

Email: akilar1829@gmail.com
GitHub: https://github.com/Akila1806

---

**Total Time: 13 நிமிடம் | Cost: FREE** ✨
