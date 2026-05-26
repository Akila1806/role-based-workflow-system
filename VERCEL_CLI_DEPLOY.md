# 🚀 Vercel CLI-ல் Deploy செய்வது எப்படி?

## ✅ Vercel CLI Install ஆகிவிட்டது!

இப்போது command line-ல் இருந்தே deploy செய்யலாம்.

---

## 📋 Step-by-Step Instructions:

### 1️⃣ Vercel Login

Terminal-ல் இந்த command run செய்யவும்:

```bash
vercel login
```

**என்ன நடக்கும்:**
- Browser window open ஆகும்
- Vercel login page வரும்
- GitHub-ல் login செய்யவும்
- "Confirm" click செய்யவும்
- Terminal-ல் "Success!" message வரும்

---

### 2️⃣ Frontend Deploy

```bash
cd frontend
vercel --prod
```

**Questions வரும், இப்படி answer செய்யவும்:**

```
? Set up and deploy "D:\role-based-workflow-system\frontend"? 
→ Y (Yes)

? Which scope do you want to deploy to? 
→ Select your account (Akila1806)

? Link to existing project? 
→ N (No)

? What's your project's name? 
→ workflow-frontend (or any name you want)

? In which directory is your code located? 
→ ./ (press Enter)

? Want to override the settings? 
→ Y (Yes)

? Which settings do you want to override?
→ Select "Build Command" and "Output Directory"

? What's your Build Command? 
→ npm run build

? What's your Output Directory? 
→ dist

? What's your Development Command?
→ npm run dev (press Enter)
```

**Environment Variable add செய்தல்:**

Deployment முடிந்ததும்:

```bash
vercel env add VITE_API_URL production
```

**Value enter செய்யவும்:**
```
https://your-backend-url.up.railway.app
```

**மீண்டும் deploy செய்யவும்:**
```bash
vercel --prod
```

---

### 3️⃣ Success! 🎉

Terminal-ல் உங்கள் live URL வரும்:

```
✅ Production: https://workflow-frontend.vercel.app
```

---

## 🔄 Updates செய்வது எப்படி?

Code changes செய்தபின்:

```bash
cd frontend
vercel --prod
```

அவ்வளவுதான்! Automatic-ஆக redeploy ஆகும்.

---

## 📱 Vercel Dashboard:

Browser-ல் உங்கள் deployments பார்க்க:

```
https://vercel.com/dashboard
```

---

## 🆘 Common Issues:

### Issue 1: "Command not found: vercel"

**Solution:**
```bash
npm install -g vercel
```

### Issue 2: Environment variable not working

**Solution:**
```bash
# List all env variables
vercel env ls

# Add missing variable
vercel env add VITE_API_URL production

# Redeploy
vercel --prod
```

### Issue 3: Build failed

**Solution:**
```bash
# Check logs
vercel logs

# Or check in dashboard
https://vercel.com/dashboard → Your Project → Deployments → View Logs
```

---

## 💡 Useful Commands:

```bash
# Login
vercel login

# Deploy to production
vercel --prod

# Deploy to preview
vercel

# View logs
vercel logs

# List projects
vercel ls

# Remove project
vercel remove workflow-frontend

# View environment variables
vercel env ls

# Add environment variable
vercel env add VARIABLE_NAME production

# Pull environment variables
vercel env pull
```

---

## 🎯 Next Steps:

1. ✅ Frontend deployed
2. ⏳ Backend deploy செய்ய வேண்டும் (Railway use செய்யவும்)
3. ⏳ Database setup செய்ய வேண்டும் (Neon use செய்யவும்)

**Full instructions:** DEPLOYMENT_INSTRUCTIONS.md file-ஐ படியுங்கள்

---

**Built with ❤️ | Deployed on Vercel**
