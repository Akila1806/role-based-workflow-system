# 🚀 Role-Based Approval & Workflow Management System

A full-stack web application for managing approval workflows with role-based access control, built with React, Node.js, and PostgreSQL.

![Project Status](https://img.shields.io/badge/status-completed-success)
![React](https://img.shields.io/badge/React-18.x-blue)
![Node.js](https://img.shields.io/badge/Node.js-18.x-green)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14.x-blue)

## 📋 Table of Contents
- [Features](#features)
- [Tech Stack](#tech-stack)
- [System Architecture](#system-architecture)
- [Getting Started](#getting-started)
- [Demo Credentials](#demo-credentials)
- [API Documentation](#api-documentation)
- [Workflow Rules](#workflow-rules)
- [Screenshots](#screenshots)
- [Deployment](#deployment)

---

## ✨ Features

### 🔐 Authentication & Authorization
- JWT-based authentication
- Three user roles: **User**, **Manager**, **Admin**
- Role-based access control (RBAC)
- Separate login pages for each role with unique UI themes
- Password visibility toggle
- Secure token storage

### 📝 Request Management
- Create requests with title, description, category, and priority
- View all requests (role-based filtering)
- View personal requests
- Update request status based on role permissions
- Rich request details page

### 🔄 Workflow Engine
- State machine-based workflow transitions
- Role-based status change permissions
- Validation of allowed transitions
- Prevents unauthorized status changes
- Complete workflow: Submitted → Approved → Closed

### 📊 Dashboards
- **User Dashboard**: Personal request statistics and recent requests
- **Manager Dashboard**: All requests with filtering capabilities
- **Admin Dashboard**: Complete system overview
- Real-time statistics (Total, Pending, Approved, Rejected)
- Interactive charts and cards

### 🕐 Action History
- Complete audit trail for every request
- Timeline UI showing all status changes
- Tracks who made changes and when
- Optional comments for each status change
- Visual timeline with color-coded status indicators

### 🎨 UI/UX Features
- **Professional Design**: Modern, clean interface
- **Dark Mode**: Full dark mode support with theme toggle
- **Responsive Design**: Works on desktop, tablet, and mobile
- **List/Grid Views**: Toggle between table and card layouts
- **Advanced Filtering**: Filter by status, category, date range
- **Sorting**: 7 sort options (newest, oldest, title, priority, status)
- **Pagination**: Efficient data loading with page navigation
- **Loading States**: Smooth loading indicators
- **Error Handling**: User-friendly error messages

### 🔒 Security Features
- JWT token authentication
- Role-based middleware
- Input validation and sanitization
- SQL injection prevention (parameterized queries)
- XSS protection
- CORS configuration
- Password hashing with bcrypt

---

## 🛠️ Tech Stack

### Frontend
- **React 18** - UI library
- **React Router** - Client-side routing
- **Axios** - HTTP client
- **React Icons** - Icon library
- **Vite** - Build tool
- **CSS3** - Styling with CSS variables

### Backend
- **Node.js** - Runtime environment
- **Express.js** - Web framework
- **PostgreSQL** - Relational database
- **JWT** - Authentication
- **bcryptjs** - Password hashing
- **express-validator** - Input validation
- **dotenv** - Environment variables

### Development Tools
- **Nodemon** - Auto-restart server
- **ESLint** - Code linting
- **Git** - Version control

---

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         Frontend (React)                     │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │  Login   │  │Dashboard │  │ Requests │  │  Detail  │   │
│  │  Pages   │  │   Page   │  │   Pages  │  │   Page   │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
│                          │                                   │
│                    Axios HTTP Client                         │
└──────────────────────────┼──────────────────────────────────┘
                           │
                    JWT Authentication
                           │
┌──────────────────────────┼──────────────────────────────────┐
│                    Backend (Express.js)                      │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Middleware Layer                         │  │
│  │  • Authentication (JWT Verify)                        │  │
│  │  • Authorization (Role Check)                         │  │
│  │  • Input Validation                                   │  │
│  └──────────────────────────────────────────────────────┘  │
│                           │                                  │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Controllers                              │  │
│  │  • authController  • requestController                │  │
│  └──────────────────────────────────────────────────────┘  │
│                           │                                  │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Workflow Engine                          │  │
│  │  • Validate Transitions                               │  │
│  │  • Check Role Permissions                             │  │
│  └──────────────────────────────────────────────────────┘  │
└──────────────────────────┼──────────────────────────────────┘
                           │
┌──────────────────────────┼──────────────────────────────────┐
│                   Database (PostgreSQL)                      │
│  ┌──────────┐  ┌──────────┐  ┌──────────────┐             │
│  │  users   │  │ requests │  │ request_logs │             │
│  └──────────┘  └──────────┘  └──────────────┘             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🚀 Getting Started

### Prerequisites
- Node.js (v18 or higher)
- PostgreSQL (v14 or higher)
- npm or yarn

### Installation

#### 1. Clone the repository
```bash
git clone <repository-url>
cd workflow-management-system
```

#### 2. Set up the database
```bash
# Login to PostgreSQL
psql -U postgres

# Run the database setup script
\i backend/config/database.sql
```

#### 3. Set up the backend
```bash
cd backend
npm install

# Create .env file
cp .env.example .env

# Update .env with your database credentials
DB_HOST=localhost
DB_PORT=5432
DB_NAME=workflow_db
DB_USER=postgres
DB_PASSWORD=your_password
JWT_SECRET=your_jwt_secret_key_here
PORT=5000
```

#### 4. Set up the frontend
```bash
cd ../frontend
npm install
```

#### 5. Start the development servers

**Terminal 1 - Backend:**
```bash
cd backend
npm run dev
```

**Terminal 2 - Frontend:**
```bash
cd frontend
npm run dev
```

#### 6. Access the application
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000

---

## 🔑 Demo Credentials

### User Account
```
Email: user@example.com
Password: password123
Role: User
```
**Permissions:**
- Create requests
- View own requests
- Resubmit requests after clarification

### Manager Account
```
Email: manager@example.com
Password: password123
Role: Manager
```
**Permissions:**
- View all requests
- Approve/Reject requests
- Request clarification
- All User permissions

### Admin Account
```
Email: admin@example.com
Password: password123
Role: Admin
```
**Permissions:**
- Close approved requests
- Reopen closed requests
- All Manager permissions
- All User permissions

---

## 📡 API Documentation

### Authentication Endpoints

#### POST /api/auth/login
Login with email and password.

**Request:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "name": "John User",
    "email": "user@example.com",
    "role": "User"
  }
}
```

#### GET /api/auth/me
Get current user information (requires authentication).

---

### Request Endpoints

#### POST /api/requests
Create a new request (requires authentication).

**Request:**
```json
{
  "title": "Need New Laptop",
  "description": "Current laptop is very slow",
  "category": "Administrative",
  "priority": "Medium"
}
```

#### GET /api/requests/my-requests
Get current user's requests (requires authentication).

**Query Parameters:**
- `page` (optional): Page number (default: 1)
- `limit` (optional): Items per page (default: 10)
- `sort` (optional): Sort option (default: created_desc)

#### GET /api/requests
Get all requests (requires Manager or Admin role).

**Query Parameters:**
- `status` (optional): Filter by status
- `category` (optional): Filter by category
- `startDate` (optional): Filter by start date
- `endDate` (optional): Filter by end date
- `page` (optional): Page number
- `limit` (optional): Items per page
- `sort` (optional): Sort option

#### GET /api/requests/:id
Get single request details (requires authentication).

#### PATCH /api/requests/:id/status
Update request status (requires authentication and proper role).

**Request:**
```json
{
  "status": "Approved",
  "comment": "Looks good, approved!"
}
```

#### GET /api/requests/:id/logs
Get action history for a request (requires authentication).

---

## 🔄 Workflow Rules

### Status Transitions

| From Status | To Status | Allowed Roles |
|------------|-----------|---------------|
| Submitted | Approved | Manager, Admin |
| Submitted | Rejected | Manager, Admin |
| Submitted | Needs Clarification | Manager, Admin |
| Needs Clarification | Submitted | User |
| Approved | Closed | Admin |
| Closed | Reopened | Admin |
| Rejected | Submitted | User |
| Reopened | Approved | Manager, Admin |
| Reopened | Rejected | Manager, Admin |
| Reopened | Closed | Admin |

### Workflow Diagram

```
┌──────────────┐
│  Submitted   │◄─────────────┐
└──────┬───────┘              │
       │                      │
       ├─────────────┐        │
       │             │        │
       ▼             ▼        │
┌──────────┐  ┌──────────┐   │
│ Approved │  │ Rejected │   │
└────┬─────┘  └────┬─────┘   │
     │             │          │
     ▼             └──────────┘
┌──────────┐
│  Closed  │
└────┬─────┘
     │
     ▼
┌──────────┐
│ Reopened │
└──────────┘
```

---

## 📸 Screenshots

### Login Pages
- User Login (Blue theme)
- Manager Login (Purple theme)
- Admin Login (Red/Pink theme)

### Dashboard
- Statistics cards
- Recent requests table
- List and Grid views

### Request Management
- Create request form
- My Requests page
- All Requests page (Manager/Admin)

### Request Details
- Request information
- Action buttons (role-based)
- Action history timeline

### Dark Mode
- All pages support dark mode
- Theme toggle in sidebar

---

## 🌐 Deployment

### Backend Deployment (Render/Railway)

1. Create account on Render or Railway
2. Connect GitHub repository
3. Set environment variables:
   ```
   DB_HOST=<your-db-host>
   DB_PORT=5432
   DB_NAME=workflow_db
   DB_USER=<your-db-user>
   DB_PASSWORD=<your-db-password>
   JWT_SECRET=<your-secret>
   PORT=5000
   ```
4. Deploy

### Frontend Deployment (Netlify/Vercel)

1. Create account on Netlify or Vercel
2. Connect GitHub repository
3. Set build settings:
   - Build command: `npm run build`
   - Publish directory: `dist`
4. Set environment variable:
   ```
   VITE_API_URL=<your-backend-url>
   ```
5. Deploy

### Database Setup (Production)

1. Create PostgreSQL database on your hosting provider
2. Run the SQL script from `backend/config/database.sql`
3. Update backend environment variables with production database credentials

---

## 📁 Project Structure

```
workflow-management-system/
├── backend/
│   ├── config/
│   │   ├── database.js          # Database connection
│   │   └── database.sql         # Database schema
│   ├── controllers/
│   │   ├── authController.js    # Authentication logic
│   │   └── requestController.js # Request CRUD operations
│   ├── middleware/
│   │   ├── auth.js              # JWT verification & authorization
│   │   └── validator.js         # Input validation
│   ├── routes/
│   │   ├── authRoutes.js        # Auth endpoints
│   │   └── requestRoutes.js     # Request endpoints
│   ├── utils/
│   │   ├── hashPassword.js      # Password hashing utility
│   │   └── workflowEngine.js    # Workflow transition logic
│   ├── .env.example             # Environment variables template
│   ├── package.json
│   └── server.js                # Express server setup
│
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── Layout.jsx       # Main layout with sidebar
│   │   │   ├── Layout.css
│   │   │   └── PrivateRoute.jsx # Protected route component
│   │   ├── context/
│   │   │   ├── AuthContext.jsx  # Authentication state
│   │   │   └── ThemeContext.jsx # Dark mode state
│   │   ├── pages/
│   │   │   ├── Login.jsx        # Login pages
│   │   │   ├── Dashboard.jsx    # Dashboard page
│   │   │   ├── CreateRequest.jsx
│   │   │   ├── MyRequests.jsx
│   │   │   ├── AllRequests.jsx
│   │   │   └── RequestDetail.jsx
│   │   ├── App.jsx              # Main app component
│   │   ├── App.css              # Global styles
│   │   ├── index.css            # CSS variables
│   │   └── main.jsx             # Entry point
│   ├── index.html
│   ├── package.json
│   └── vite.config.js
│
├── README.md
├── TESTING_CHECKLIST.md
└── package.json
```

---

## 🧪 Testing

See [TESTING_CHECKLIST.md](./TESTING_CHECKLIST.md) for comprehensive testing guide.

### Quick Test
1. Login as User → Create a request
2. Login as Manager → Approve the request
3. Login as Admin → Close the request
4. Check action history timeline

---

## 🤝 Contributing

This is a demonstration project for interview purposes. Not accepting contributions.

---

## 📄 License

This project is created for educational and interview purposes.

---

## 👨‍💻 Developer

**Name:** [Your Name]
**Email:** [Your Email]
**GitHub:** [Your GitHub Profile]

---

## 🎯 Project Requirements Met

✅ **Module 1 - Authentication**: JWT-based auth with role-based login pages  
✅ **Module 2 - Request Creation**: Complete form with validation  
✅ **Module 3 - Workflow Engine**: State machine with role-based transitions  
✅ **Module 4 - Action Logs**: Complete audit trail with timeline UI  
✅ **Module 5 - Dashboards**: Role-based dashboards with filters and pagination  
✅ **Module 6 - Security**: JWT, RBAC, input validation, SQL injection prevention  
✅ **Module 7 - UI Quality**: Professional design, dark mode, responsive, loading states  

---

## 🌟 Additional Features

- **Dark Mode**: Complete dark mode support with theme persistence
- **Mobile Responsive**: Works perfectly on all device sizes
- **List/Grid Views**: Toggle between table and card layouts
- **Advanced Sorting**: 7 different sort options
- **Real-time Updates**: Instant UI updates after actions
- **Professional Design**: Modern, clean, and intuitive interface
- **Comprehensive Error Handling**: User-friendly error messages
- **Loading States**: Smooth loading indicators throughout

---

## 📞 Contact

For any questions or issues, please contact:
- **WhatsApp**: 98409 99789
- **Email**: [Your Email]

---

**Built with ❤️ using React, Node.js, and PostgreSQL**
