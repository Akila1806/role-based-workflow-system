# 🧪 Complete Testing Checklist - Role-Based Approval & Workflow Management System

## Project Information
- **Tech Stack**: React + Node.js (Express) + PostgreSQL
- **Authentication**: JWT-based
- **Roles**: User, Manager, Admin
- **Status**: Ready for Testing

---

## 📋 MODULE 1: AUTHENTICATION (FULL STACK)

### Backend API Tests
- [x] **POST /api/auth/login**
  - ✅ Validates email + password
  - ✅ Returns JWT token
  - ✅ Returns user info (name, email, role)
  - ✅ Handles invalid credentials
  - ✅ Input validation (email format, required fields)

### Frontend Tests
- [x] **Login Pages**
  - ✅ Three separate login pages (User, Manager, Admin)
  - ✅ Split-screen design (colored left, white form right)
  - ✅ Role tabs for switching
  - ✅ Password visibility toggle
  - ✅ Email and lock icons in inputs
  - ✅ Form validation
  - ✅ Error handling
  - ✅ Token storage in localStorage
  - ✅ Redirect based on role → Dashboard

### Test Credentials
```
User Login:
Email: user@example.com
Password: password123

Manager Login:
Email: manager@example.com
Password: password123

Admin Login:
Email: admin@example.com
Password: password123
```

---

## 📋 MODULE 2: REQUEST CREATION

### Backend API Tests
- [x] **POST /api/requests**
  - ✅ Stores: title, description, category, priority, user_id
  - ✅ Default status = 'Submitted'
  - ✅ Requires authentication
  - ✅ Input validation
  - ✅ Creates log entry on creation

### Frontend Tests
- [x] **Create Request Form**
  - ✅ Form UI with all fields
  - ✅ Title input (required)
  - ✅ Description textarea (required)
  - ✅ Category dropdown (Technical, Administrative, Financial, HR, Other)
  - ✅ Priority dropdown (Low, Medium, High, Critical)
  - ✅ Client-side validation
  - ✅ Submit via API
  - ✅ Success message
  - ✅ Redirect to My Requests
  - ✅ Error handling

### Manual Test Steps
1. Login as User
2. Click "Create Request" in sidebar
3. Fill form:
   - Title: "Website Login Page Not Loading"
   - Description: "Users cannot access the login page"
   - Category: Technical
   - Priority: High
4. Submit
5. Verify redirect to My Requests
6. Verify request appears in list

---

## 📋 MODULE 3: WORKFLOW ENGINE (CORE LOGIC)

### Backend Workflow Rules
- [x] **Transition Rules Implemented**
  ```
  Submitted → Approved (Manager, Admin)
  Submitted → Rejected (Manager, Admin)
  Submitted → Needs Clarification (Manager, Admin)
  Needs Clarification → Submitted (User)
  Approved → Closed (Admin)
  Closed → Reopened (Admin)
  Rejected → Submitted (User)
  Reopened → Approved (Manager, Admin)
  Reopened → Rejected (Manager, Admin)
  Reopened → Closed (Admin)
  ```

### Backend API Tests
- [x] **PATCH /api/requests/:id/status**
  - ✅ Validates user role
  - ✅ Validates current status
  - ✅ Rejects invalid transitions
  - ✅ Creates log entry on status change
  - ✅ Returns error for unauthorized transitions

### Frontend Tests
- [x] **Request Detail Page**
  - ✅ Shows current status
  - ✅ Shows action buttons based on role
  - ✅ Disables invalid actions
  - ✅ Confirmation before status change
  - ✅ Optional comment field
  - ✅ Success/error messages
  - ✅ Real-time status update

### Manual Test Scenarios

#### Scenario 1: Manager Approves Request
1. Login as Manager
2. Go to "All Requests"
3. Click on a "Submitted" request
4. Click "Approve" button
5. Add comment (optional)
6. Verify status changes to "Approved"
7. Verify log entry created

#### Scenario 2: Manager Rejects Request
1. Login as Manager
2. Find a "Submitted" request
3. Click "Reject" button
4. Add comment explaining reason
5. Verify status changes to "Rejected"

#### Scenario 3: Manager Requests Clarification
1. Login as Manager
2. Find a "Submitted" request
3. Click "Needs Clarification" button
4. Add comment with questions
5. Verify status changes to "Needs Clarification"

#### Scenario 4: User Resubmits After Clarification
1. Login as User (who created the request)
2. Go to "My Requests"
3. Find request with "Needs Clarification" status
4. Click "Resubmit" button
5. Verify status changes back to "Submitted"

#### Scenario 5: Admin Closes Approved Request
1. Login as Admin
2. Find an "Approved" request
3. Click "Close" button
4. Verify status changes to "Closed"

#### Scenario 6: Admin Reopens Closed Request
1. Login as Admin
2. Find a "Closed" request
3. Click "Reopen" button
4. Verify status changes to "Reopened"

#### Scenario 7: Invalid Transition (Should Fail)
1. Login as User
2. Try to approve their own request
3. Verify error message: "Not authorized"

---

## 📋 MODULE 4: ACTION LOG (AUDIT TRAIL)

### Backend Tests
- [x] **Database Table: request_logs**
  - ✅ Columns: id, request_id, old_status, new_status, changed_by, role, comment, timestamp
  - ✅ Foreign keys properly set
  - ✅ Indexes for performance

- [x] **GET /api/requests/:id/logs**
  - ✅ Returns all logs for a request
  - ✅ Includes user info (name, email)
  - ✅ Ordered by timestamp (ASC)
  - ✅ Authorization check

### Frontend Tests
- [x] **Timeline UI**
  - ✅ Clean, professional design
  - ✅ Shows all status changes
  - ✅ Displays: old status → new status
  - ✅ Shows who made the change
  - ✅ Shows role of person
  - ✅ Shows timestamp
  - ✅ Shows comments (if any)
  - ✅ Visual timeline with icons
  - ✅ Color-coded by status

### Manual Test Steps
1. Login as any user
2. Open a request that has multiple status changes
3. Scroll to "Action History" section
4. Verify timeline shows:
   - Request created
   - Status changes
   - Who made each change
   - When it happened
   - Comments (if any)

---

## 📋 MODULE 5: DASHBOARDS

### Backend API Tests

#### User Dashboard
- [x] **GET /api/requests/my-requests**
  - ✅ Returns only user's own requests
  - ✅ Supports pagination (page, limit)
  - ✅ Supports sorting (7 options)
  - ✅ Returns total count and pages

#### Manager Dashboard
- [x] **GET /api/requests?status=Submitted**
  - ✅ Returns all requests
  - ✅ Filter by status
  - ✅ Filter by category
  - ✅ Filter by date range (startDate, endDate)
  - ✅ Supports pagination
  - ✅ Supports sorting
  - ✅ Requires Manager/Admin role

#### Admin Dashboard
- [x] **GET /api/requests**
  - ✅ Returns all requests
  - ✅ All filters available
  - ✅ Pagination and sorting

### Frontend Tests

#### Dashboard Page
- [x] **Stats Cards**
  - ✅ Total Requests
  - ✅ Pending (Submitted)
  - ✅ Approved
  - ✅ Rejected
  - ✅ Icons and colors

- [x] **Recent Requests Table**
  - ✅ Shows latest 5 requests
  - ✅ List view and Grid view toggle
  - ✅ Sort dropdown (7 options)
  - ✅ Pagination
  - ✅ View Details button

#### My Requests Page
- [x] **Features**
  - ✅ Shows user's own requests
  - ✅ List/Grid view toggle
  - ✅ Sort dropdown
  - ✅ Pagination
  - ✅ Create New Request button with icon
  - ✅ Empty state with CTA

#### All Requests Page (Manager/Admin)
- [x] **Features**
  - ✅ Shows all requests in system
  - ✅ Filter by status
  - ✅ Filter by category
  - ✅ Filter by date range
  - ✅ Clear filters button
  - ✅ List/Grid view toggle
  - ✅ Sort dropdown
  - ✅ Pagination
  - ✅ Shows user name for each request

### Manual Test Steps

#### Test Filters
1. Login as Manager
2. Go to "All Requests"
3. Test Status filter: Select "Submitted"
4. Verify only submitted requests shown
5. Test Category filter: Select "Technical"
6. Test Date range filter
7. Click "Clear Filters"
8. Verify all requests shown again

#### Test Sorting
1. Select "Newest First" - verify order
2. Select "Oldest First" - verify order
3. Select "Title (A-Z)" - verify alphabetical
4. Select "Priority (High to Low)" - verify order
5. Select "Status (A-Z)" - verify alphabetical

#### Test Pagination
1. Create 15+ requests
2. Verify pagination shows "Page 1 of 2"
3. Click "Next" button
4. Verify page 2 loads
5. Click "Previous" button
6. Verify page 1 loads

#### Test View Toggle
1. Click Grid view icon
2. Verify cards layout
3. Click List view icon
4. Verify table layout

---

## 📋 MODULE 6: SECURITY

### Backend Security Tests
- [x] **JWT Authentication**
  - ✅ All protected routes require token
  - ✅ Invalid token returns 401
  - ✅ Expired token returns 401
  - ✅ Token includes user id and role

- [x] **Role-Based Authorization**
  - ✅ Middleware: `authorize('Manager', 'Admin')`
  - ✅ Users cannot access Manager/Admin routes
  - ✅ Proper 403 error for unauthorized access

- [x] **Input Validation**
  - ✅ Email format validation
  - ✅ Required fields validation
  - ✅ String length validation
  - ✅ Enum validation (status, category, priority)
  - ✅ SQL injection prevention (parameterized queries)

- [x] **Authorization Checks**
  - ✅ Users can only view their own requests
  - ✅ Users cannot approve their own requests
  - ✅ Workflow rules enforced
  - ✅ Status transition validation

### Manual Security Tests

#### Test 1: Unauthorized API Access
1. Open browser DevTools
2. Try to call API without token:
   ```
   fetch('http://localhost:5000/api/requests')
   ```
3. Verify 401 error

#### Test 2: Role-Based Access
1. Login as User
2. Try to access `/all-requests` in browser
3. Verify redirect or error

#### Test 3: Invalid Workflow Transition
1. Login as User
2. Try to approve own request via API
3. Verify 403 error with message

#### Test 4: SQL Injection Prevention
1. Try login with: `admin@example.com' OR '1'='1`
2. Verify login fails

---

## 📋 MODULE 7: UI QUALITY

### Design Tests
- [x] **Sidebar Layout**
  - ✅ Fixed sidebar on desktop
  - ✅ Slide-in sidebar on mobile
  - ✅ Navigation links with icons
  - ✅ Active state highlighting
  - ✅ User info in footer
  - ✅ Logout button
  - ✅ Theme toggle in sidebar header

- [x] **Dashboard Cards**
  - ✅ Professional card design
  - ✅ Box shadow
  - ✅ Rounded corners
  - ✅ Proper spacing
  - ✅ Responsive grid

- [x] **Status Badges**
  - ✅ Color-coded badges
  - ✅ Submitted: Blue
  - ✅ Approved: Green
  - ✅ Rejected: Red
  - ✅ Needs Clarification: Yellow
  - ✅ Closed: Gray
  - ✅ Reopened: Purple
  - ✅ Dark mode support

- [x] **Priority Badges**
  - ✅ Low: Gray
  - ✅ Medium: Blue
  - ✅ High: Orange
  - ✅ Critical: Red
  - ✅ Dark mode support

- [x] **Loading States**
  - ✅ Spinner component
  - ✅ Shows during API calls
  - ✅ Centered on page

- [x] **Error Handling**
  - ✅ Toast notifications
  - ✅ Error messages
  - ✅ Form validation errors
  - ✅ API error handling

### Responsive Design Tests
- [x] **Desktop (>1024px)**
  - ✅ Sidebar visible
  - ✅ Full table view
  - ✅ 3-4 column grid

- [x] **Tablet (768-1024px)**
  - ✅ Sidebar visible
  - ✅ 2-3 column grid
  - ✅ Horizontal scroll for tables

- [x] **Mobile (480-768px)**
  - ✅ Hamburger menu
  - ✅ Slide-in sidebar
  - ✅ 2 column grid
  - ✅ Stacked forms
  - ✅ Mobile header with theme toggle

- [x] **Small Mobile (<480px)**
  - ✅ Single column layout
  - ✅ Full-width buttons
  - ✅ Stacked navigation

### Dark Mode Tests
- [x] **Theme Toggle**
  - ✅ Located in sidebar header
  - ✅ Sun icon for dark mode
  - ✅ Moon icon for light mode
  - ✅ Persists to localStorage
  - ✅ Auto-detects system preference

- [x] **Dark Mode Styling**
  - ✅ All pages support dark mode
  - ✅ Login pages
  - ✅ Dashboard
  - ✅ Forms
  - ✅ Tables
  - ✅ Cards
  - ✅ Badges visible
  - ✅ Pagination visible
  - ✅ Proper contrast

---

## 🧪 COMPLETE WORKFLOW TEST

### End-to-End Test Scenario

#### Step 1: User Creates Request
1. Login as User (user@example.com)
2. Click "Create Request"
3. Fill form:
   - Title: "Need New Laptop"
   - Description: "Current laptop is 5 years old and very slow"
   - Category: Administrative
   - Priority: Medium
4. Submit
5. ✅ Verify request appears in "My Requests"
6. ✅ Verify status is "Submitted"

#### Step 2: Manager Reviews and Requests Clarification
1. Logout
2. Login as Manager (manager@example.com)
3. Go to "All Requests"
4. Find "Need New Laptop" request
5. Click "View Details"
6. Click "Needs Clarification"
7. Add comment: "Please specify laptop model and budget"
8. Submit
9. ✅ Verify status changed to "Needs Clarification"
10. ✅ Verify log entry created

#### Step 3: User Provides Clarification
1. Logout
2. Login as User
3. Go to "My Requests"
4. Find request with "Needs Clarification" status
5. Click "View Details"
6. See manager's comment
7. Click "Resubmit"
8. Add comment: "Dell XPS 15, Budget: $2000"
9. Submit
10. ✅ Verify status changed back to "Submitted"
11. ✅ Verify log entry created

#### Step 4: Manager Approves Request
1. Logout
2. Login as Manager
3. Find the resubmitted request
4. Click "Approve"
5. Add comment: "Approved for purchase"
6. Submit
7. ✅ Verify status changed to "Approved"
8. ✅ Verify log entry created

#### Step 5: Admin Closes Request
1. Logout
2. Login as Admin (admin@example.com)
3. Go to "All Requests"
4. Find the approved request
5. Click "Close"
6. Add comment: "Laptop purchased and delivered"
7. Submit
8. ✅ Verify status changed to "Closed"
9. ✅ Verify log entry created

#### Step 6: Verify Complete Action Log
1. View request details
2. Check "Action History" section
3. ✅ Verify all 5 status changes are logged:
   - Created (Submitted)
   - Needs Clarification
   - Resubmitted (Submitted)
   - Approved
   - Closed
4. ✅ Verify each log shows:
   - Who made the change
   - Their role
   - Timestamp
   - Comments

---

## 📊 FINAL CHECKLIST

### Backend ✅
- [x] Authentication API working
- [x] Request CRUD operations
- [x] Workflow engine enforcing rules
- [x] Action logs recording all changes
- [x] Role-based authorization
- [x] Input validation
- [x] Error handling
- [x] Security measures

### Frontend ✅
- [x] Three login pages with split design
- [x] Dashboard with stats
- [x] Request creation form
- [x] Request list pages (My Requests, All Requests)
- [x] Request detail page with actions
- [x] Action history timeline
- [x] Filters and sorting
- [x] Pagination
- [x] List/Grid view toggle
- [x] Dark mode support
- [x] Mobile responsive
- [x] Professional UI design
- [x] Loading states
- [x] Error handling

### Database ✅
- [x] Users table
- [x] Requests table
- [x] Request logs table
- [x] Proper relationships
- [x] Indexes for performance
- [x] Sample data

---

## 🚀 DEPLOYMENT CHECKLIST

### Before Deployment
- [ ] Update .env with production values
- [ ] Set up production PostgreSQL database
- [ ] Run database migrations
- [ ] Insert sample users
- [ ] Test all API endpoints
- [ ] Build frontend for production
- [ ] Test production build locally

### Backend Deployment (Render/Railway/Heroku)
- [ ] Create account
- [ ] Connect GitHub repository
- [ ] Set environment variables
- [ ] Deploy backend
- [ ] Test API endpoints

### Frontend Deployment (Netlify/Vercel)
- [ ] Create account
- [ ] Connect GitHub repository
- [ ] Set build command: `npm run build`
- [ ] Set publish directory: `dist`
- [ ] Set environment variables (API URL)
- [ ] Deploy frontend
- [ ] Test live site

### Post-Deployment
- [ ] Test complete workflow on live site
- [ ] Test all three roles
- [ ] Test mobile responsiveness
- [ ] Test dark mode
- [ ] Verify API calls working
- [ ] Check browser console for errors

---

## 📝 SUBMISSION FORMAT

### GitHub Repository
```
Repository Name: workflow-management-system
Description: Role-Based Approval & Workflow Management System
Tech Stack: React + Node.js + PostgreSQL

README.md should include:
- Project description
- Tech stack
- Features list
- Setup instructions
- Demo credentials
- Screenshots
- Live demo link
```

### WhatsApp Message Format
```
Task Completed – React Developer Interview

Name: [Your Name]
GitHub: [Repository URL]
Live Demo: [Netlify/Vercel URL]

Tech Stack:
- Frontend: React + Vite
- Backend: Node.js + Express
- Database: PostgreSQL
- Authentication: JWT

Features Implemented:
✅ 3 Role-based logins (User, Manager, Admin)
✅ Request creation and management
✅ Workflow engine with state transitions
✅ Action logs with timeline UI
✅ Dashboards with filters and pagination
✅ Role-based authorization
✅ Dark mode support
✅ Mobile responsive design

Demo Credentials:
User: user@example.com / password123
Manager: manager@example.com / password123
Admin: admin@example.com / password123
```

---

## ✅ ALL MODULES VERIFIED AND WORKING!

**Status**: Ready for Submission 🎉
