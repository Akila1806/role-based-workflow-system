# 🚀 Role-Based Workflow Management System

## 🎯 இது என்ன?

ஒரு முழுமையான **Approval Workflow Management System** - React, Node.js, PostgreSQL-ல் built செய்யப்பட்டது.

---

## ✨ Features:

- ✅ **3 User Roles**: User, Manager, Admin
- ✅ **Request Management**: Create, Approve, Reject, Close
- ✅ **Workflow Engine**: Automatic status transitions
- ✅ **Action History**: Complete audit trail
- ✅ **Dark Mode**: Full dark mode support
- ✅ **Responsive**: Mobile, Tablet, Desktop
- ✅ **Secure**: JWT authentication, RBAC

---

## 🚀 Deploy செய்வது எப்படி?

### ⚡ Super Simple Method:

**3 Links Click செய்தால் போதும்!**

1. **Database**: https://neon.tech/ (3 mins)
2. **Backend**: https://railway.app/new (5 mins)
3. **Frontend**: https://vercel.com/new (5 mins)

**Total: 13 நிமிடம் | Cost: FREE** ✨

---

## 📖 Deployment Guides:

| File | Description |
|------|-------------|
| **SIMPLE_STEPS.md** | மிக எளிமையான வழி - 3 links |
| **ONE_CLICK_DEPLOY.md** | One-click deployment buttons |
| **DEPLOYMENT_INSTRUCTIONS.md** | Detailed step-by-step guide |
| **START_HERE.md** | இங்கே இருந்து start செய்யுங்கள் |

---

## 🎯 Quick Start:

### Local Development:

```bash
# 1. Clone repository
git clone https://github.com/Akila1806/role-based-workflow-system.git
cd role-based-workflow-system

# 2. Database setup
psql -U postgres
\i COMPLETE_DATABASE_SETUP.sql

# 3. Backend setup
cd backend
npm install
cp .env.example .env
# Update .env with your database credentials
npm run dev

# 4. Frontend setup (new terminal)
cd frontend
npm install
npm run dev
```

**Open:** http://localhost:3000

---

## 🔑 Demo Accounts:

### User:
```
Email: user@example.com
Password: password123
```

### Manager:
```
Email: manager@example.com
Password: password123
```

### Admin:
```
Email: admin@example.com
Password: password123
```

---

## 🛠️ Tech Stack:

### Frontend:
- React 18
- React Router
- Axios
- Vite
- CSS3

### Backend:
- Node.js
- Express.js
- PostgreSQL
- JWT
- bcryptjs

---

## 📸 Screenshots:

- ✅ Login Pages (3 different themes)
- ✅ Dashboard with Statistics
- ✅ Request Management
- ✅ Action History Timeline
- ✅ Dark Mode Support

---

## 🌐 Live Demo:

**Frontend:** https://your-app.vercel.app (deploy செய்த பிறகு)
**Backend:** https://your-backend.up.railway.app

---

## 📁 Project Structure:

```
role-based-workflow-system/
├── backend/              # Node.js + Express API
│   ├── controllers/      # Business logic
│   ├── middleware/       # Auth & validation
│   ├── routes/          # API routes
│   ├── config/          # Database config
│   └── utils/           # Helper functions
│
├── frontend/            # React + Vite
│   ├── src/
│   │   ├── components/  # Reusable components
│   │   ├── pages/       # Page components
│   │   ├── context/     # React context
│   │   └── config/      # API config
│   └── public/
│
└── docs/                # Documentation
    ├── SIMPLE_STEPS.md
    ├── ONE_CLICK_DEPLOY.md
    └── DEPLOYMENT_INSTRUCTIONS.md
```

---

## 🔄 Workflow Rules:

```
Submitted → Approved → Closed
         ↓
      Rejected
         ↓
    Resubmitted
```

**Permissions:**
- **User**: Create, Resubmit
- **Manager**: Approve, Reject, Request Clarification
- **Admin**: Close, Reopen

---

## 🧪 Testing:

```bash
# Backend tests
cd backend
npm test

# Frontend tests
cd frontend
npm test
```

**Manual Testing:** See TESTING_CHECKLIST.md

---

## 📦 Deployment:

### Production Deployment:

**Quick Method:**
```
1. Read: SIMPLE_STEPS.md
2. Follow 3 steps
3. Done in 13 minutes!
```

**Detailed Method:**
```
1. Read: DEPLOYMENT_INSTRUCTIONS.md
2. Follow step-by-step
3. Troubleshooting included
```

---

## 🆘 Common Issues:

### CORS Error:
```javascript
// backend/server.js
app.use(cors({
  origin: 'https://your-app.vercel.app',
  credentials: true
}));
```

### Database Connection:
```javascript
// backend/config/database.js
ssl: {
  rejectUnauthorized: false
}
```

### Build Failed:
```bash
# Check logs
vercel logs
# or
railway logs
```

---

## 🤝 Contributing:

This is a demonstration project. Not accepting contributions.

---

## 📄 License:

Educational and interview purposes.

---

## 👨‍💻 Developer:

**Name:** Akila
**Email:** akilar1829@gmail.com
**GitHub:** https://github.com/Akila1806

---

## 🌟 Features Checklist:

- ✅ Authentication & Authorization
- ✅ Role-Based Access Control
- ✅ Request CRUD Operations
- ✅ Workflow State Machine
- ✅ Action History & Audit Trail
- ✅ Dashboard with Statistics
- ✅ Dark Mode
- ✅ Responsive Design
- ✅ Input Validation
- ✅ Error Handling
- ✅ Loading States
- ✅ Pagination
- ✅ Filtering & Sorting
- ✅ Security (JWT, RBAC, SQL Injection Prevention)

---

## 📞 Support:

Issues இருந்தால்:
- Email: akilar1829@gmail.com
- GitHub Issues: https://github.com/Akila1806/role-based-workflow-system/issues

---

## 🎯 Next Steps:

1. **Local-ல் run செய்ய**: README.md படியுங்கள்
2. **Deploy செய்ய**: SIMPLE_STEPS.md படியுங்கள்
3. **Detailed guide**: DEPLOYMENT_INSTRUCTIONS.md படியுங்கள்

---

**Built with ❤️ using React, Node.js, and PostgreSQL**

**Deploy in 13 minutes | 100% FREE** ✨

---

## 🔗 Quick Links:

- 📖 [Simple Deployment Steps](SIMPLE_STEPS.md)
- 🚀 [One-Click Deploy](ONE_CLICK_DEPLOY.md)
- 📋 [Detailed Instructions](DEPLOYMENT_INSTRUCTIONS.md)
- ✅ [Testing Checklist](TESTING_CHECKLIST.md)
- 🎯 [Start Here](START_HERE.md)

---

**Repository:** https://github.com/Akila1806/role-based-workflow-system

**Star ⭐ this repo if you like it!**
