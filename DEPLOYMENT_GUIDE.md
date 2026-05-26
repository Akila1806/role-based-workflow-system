# 🚀 Deployment Guide - Workflow Management System

## Quick Deployment Checklist

### ✅ Pre-Deployment
- [ ] All features tested locally
- [ ] Database schema finalized
- [ ] Environment variables documented
- [ ] README.md updated
- [ ] Git repository clean and pushed

---

## 📦 Option 1: Deploy to Render + Netlify (Recommended)

### Step 1: Deploy Database (Render PostgreSQL)

1. **Create Render Account**
   - Go to https://render.com
   - Sign up with GitHub

2. **Create PostgreSQL Database**
   - Click "New +" → "PostgreSQL"
   - Name: `workflow-db`
   - Database: `workflow_db`
   - User: (auto-generated)
   - Region: Choose closest to you
   - Plan: Free
   - Click "Create Database"

3. **Get Database Credentials**
   - Copy the "Internal Database URL" (starts with `postgresql://`)
   - Save for backend deployment

4. **Initialize Database**
   - Click "Connect" → "External Connection"
   - Use provided PSQL command to connect
   - Run the SQL from `backend/config/database.sql`
   
   ```bash
   psql -h <hostname> -U <username> -d workflow_db -f backend/config/database.sql
   ```

### Step 2: Deploy Backend (Render Web Service)

1. **Create Web Service**
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Name: `workflow-backend`
   - Root Directory: `backend`
   - Environment: `Node`
   - Build Command: `npm install`
   - Start Command: `node server.js`
   - Plan: Free

2. **Set Environment Variables**
   ```
   DB_HOST=<from-render-postgres>
   DB_PORT=5432
   DB_NAME=workflow_db
   DB_USER=<from-render-postgres>
   DB_PASSWORD=<from-render-postgres>
   JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
   PORT=5000
   NODE_ENV=production
   ```

3. **Deploy**
   - Click "Create Web Service"
   - Wait for deployment (5-10 minutes)
   - Copy the service URL (e.g., `https://workflow-backend.onrender.com`)

4. **Test Backend**
   ```bash
   curl https://workflow-backend.onrender.com/api/health
   ```

### Step 3: Deploy Frontend (Netlify)

1. **Update Frontend API URL**
   - Create `frontend/.env.production`
   ```
   VITE_API_URL=https://workflow-backend.onrender.com
   ```

2. **Update Axios Configuration**
   - Edit `frontend/src/main.jsx` or create `frontend/src/config.js`:
   ```javascript
   import axios from 'axios';
   
   axios.defaults.baseURL = import.meta.env.VITE_API_URL || 'http://localhost:5000';
   ```

3. **Create Netlify Account**
   - Go to https://netlify.com
   - Sign up with GitHub

4. **Deploy Site**
   - Click "Add new site" → "Import an existing project"
   - Choose GitHub → Select your repository
   - Configure:
     - Base directory: `frontend`
     - Build command: `npm run build`
     - Publish directory: `frontend/dist`
   - Environment variables:
     ```
     VITE_API_URL=https://workflow-backend.onrender.com
     ```
   - Click "Deploy site"

5. **Configure Custom Domain (Optional)**
   - Go to "Domain settings"
   - Add custom domain or use Netlify subdomain

6. **Test Frontend**
   - Visit your Netlify URL
   - Try logging in with demo credentials

---

## 📦 Option 2: Deploy to Railway (All-in-One)

### Step 1: Create Railway Account
- Go to https://railway.app
- Sign up with GitHub

### Step 2: Deploy Database
1. Click "New Project" → "Provision PostgreSQL"
2. Copy connection string
3. Connect and run SQL schema

### Step 3: Deploy Backend
1. Click "New" → "GitHub Repo"
2. Select your repository
3. Root directory: `backend`
4. Add environment variables
5. Deploy

### Step 4: Deploy Frontend
1. Click "New" → "GitHub Repo"
2. Select your repository
3. Root directory: `frontend`
4. Build command: `npm run build`
5. Start command: `npx serve dist`
6. Add environment variables
7. Deploy

---

## 📦 Option 3: Deploy to Vercel + Supabase

### Step 1: Deploy Database (Supabase)
1. Go to https://supabase.com
2. Create new project
3. Run SQL schema in SQL Editor
4. Copy connection string

### Step 2: Deploy Backend (Vercel)
1. Go to https://vercel.com
2. Import GitHub repository
3. Root directory: `backend`
4. Framework: Other
5. Add environment variables
6. Deploy

### Step 3: Deploy Frontend (Vercel)
1. Import same repository again
2. Root directory: `frontend`
3. Framework: Vite
4. Add environment variables
5. Deploy

---

## 🔧 Environment Variables Reference

### Backend (.env)
```bash
# Database
DB_HOST=your-db-host
DB_PORT=5432
DB_NAME=workflow_db
DB_USER=your-db-user
DB_PASSWORD=your-db-password

# JWT
JWT_SECRET=your-super-secret-jwt-key-min-32-characters

# Server
PORT=5000
NODE_ENV=production

# CORS (if needed)
FRONTEND_URL=https://your-frontend-url.netlify.app
```

### Frontend (.env.production)
```bash
VITE_API_URL=https://your-backend-url.onrender.com
```

---

## 🧪 Post-Deployment Testing

### 1. Test Backend API
```bash
# Health check
curl https://your-backend-url.com/api/health

# Login test
curl -X POST https://your-backend-url.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"password123"}'
```

### 2. Test Frontend
1. Visit your frontend URL
2. Try all three logins
3. Create a request
4. Test workflow transitions
5. Check dark mode
6. Test mobile responsiveness

### 3. Test Complete Workflow
1. Login as User → Create request
2. Login as Manager → Approve request
3. Login as Admin → Close request
4. Verify action logs

---

## 🐛 Common Deployment Issues

### Issue 1: CORS Error
**Problem:** Frontend can't connect to backend

**Solution:**
```javascript
// backend/server.js
const cors = require('cors');

app.use(cors({
  origin: process.env.FRONTEND_URL || '*',
  credentials: true
}));
```

### Issue 2: Database Connection Failed
**Problem:** Backend can't connect to database

**Solution:**
- Check environment variables
- Verify database is running
- Check connection string format
- Ensure database allows external connections

### Issue 3: Build Failed
**Problem:** Frontend build fails

**Solution:**
```bash
# Clear cache and rebuild
cd frontend
rm -rf node_modules dist
npm install
npm run build
```

### Issue 4: API URL Not Working
**Problem:** Frontend shows "Network Error"

**Solution:**
- Check VITE_API_URL is set correctly
- Ensure backend is deployed and running
- Check browser console for exact error
- Verify CORS is configured

### Issue 5: 404 on Refresh
**Problem:** Page refresh shows 404

**Solution (Netlify):**
Create `frontend/public/_redirects`:
```
/*    /index.html   200
```

**Solution (Vercel):**
Create `frontend/vercel.json`:
```json
{
  "rewrites": [
    { "source": "/(.*)", "destination": "/" }
  ]
}
```

---

## 📊 Monitoring & Maintenance

### Backend Monitoring
- Check Render/Railway logs for errors
- Monitor database connections
- Check API response times

### Frontend Monitoring
- Check Netlify/Vercel build logs
- Monitor bundle size
- Check browser console for errors

### Database Maintenance
- Regular backups
- Monitor storage usage
- Optimize queries if needed

---

## 🔒 Security Checklist

- [ ] JWT_SECRET is strong and unique
- [ ] Database credentials are secure
- [ ] CORS is properly configured
- [ ] Environment variables are not in Git
- [ ] HTTPS is enabled (automatic on Netlify/Render)
- [ ] Input validation is working
- [ ] SQL injection prevention is active

---

## 📝 Deployment Checklist

### Before Deployment
- [ ] All tests passing locally
- [ ] Database schema is final
- [ ] Environment variables documented
- [ ] README.md is complete
- [ ] Git repository is clean
- [ ] .gitignore includes .env files

### During Deployment
- [ ] Database deployed and initialized
- [ ] Backend deployed with correct env vars
- [ ] Frontend deployed with correct API URL
- [ ] All services are running

### After Deployment
- [ ] Health check endpoint working
- [ ] Login working for all roles
- [ ] Request creation working
- [ ] Workflow transitions working
- [ ] Action logs recording correctly
- [ ] Dark mode working
- [ ] Mobile responsive
- [ ] No console errors

---

## 🎉 Success!

Your application is now live! 

**Next Steps:**
1. Test all features thoroughly
2. Share the live URL
3. Prepare submission message
4. Send to WhatsApp: 98409 99789

---

## 📞 Support

If you encounter issues:
1. Check the logs on your hosting platform
2. Review the Common Issues section above
3. Check browser console for frontend errors
4. Test API endpoints directly with curl/Postman

---

## 🔗 Useful Links

- **Render Docs**: https://render.com/docs
- **Netlify Docs**: https://docs.netlify.com
- **Railway Docs**: https://docs.railway.app
- **Vercel Docs**: https://vercel.com/docs
- **Supabase Docs**: https://supabase.com/docs

---

**Good luck with your deployment! 🚀**
