# 🗄️ Complete Database Setup Instructions

## 📁 File: `COMPLETE_DATABASE_SETUP.sql`

This single SQL file contains **EVERYTHING** you need:
- ✅ All tables with fields
- ✅ All ENUM types
- ✅ All indexes
- ✅ All triggers
- ✅ 3 Users (User, Manager, Admin)
- ✅ 6 Sample requests
- ✅ 11 Action logs

---

## 🚀 How to Run

### Method 1: Using psql (Recommended)

```bash
# Step 1: Create database (if not exists)
psql -U postgres -c "CREATE DATABASE workflow_db;"

# Step 2: Run the complete setup
psql -U postgres -d workflow_db -f COMPLETE_DATABASE_SETUP.sql
```

### Method 2: Using pgAdmin

1. Open pgAdmin
2. Connect to PostgreSQL server
3. Create database `workflow_db` (if not exists)
4. Right-click on `workflow_db` → Query Tool
5. Open file `COMPLETE_DATABASE_SETUP.sql`
6. Click Execute (F5)

### Method 3: Copy-Paste

1. Open the file `COMPLETE_DATABASE_SETUP.sql`
2. Copy all content
3. Open your PostgreSQL client
4. Paste and execute

---

## 📊 What Gets Created

### 1️⃣ **Tables**

#### **users** table
| Field | Type | Description |
|-------|------|-------------|
| id | SERIAL | Primary key |
| name | VARCHAR(255) | User's full name |
| email | VARCHAR(255) | Unique email |
| password | VARCHAR(255) | Hashed password |
| role | user_role | User/Manager/Admin |
| created_at | TIMESTAMP | Creation time |
| updated_at | TIMESTAMP | Last update time |

#### **requests** table
| Field | Type | Description |
|-------|------|-------------|
| id | SERIAL | Primary key |
| title | VARCHAR(255) | Request title |
| description | TEXT | Request details |
| category | request_category | Technical/Administrative/Financial/HR/Other |
| priority | request_priority | Low/Medium/High/Critical |
| status | request_status | Submitted/Approved/Rejected/etc. |
| user_id | INTEGER | Foreign key to users |
| created_at | TIMESTAMP | Creation time |
| updated_at | TIMESTAMP | Last update time |

#### **request_logs** table
| Field | Type | Description |
|-------|------|-------------|
| id | SERIAL | Primary key |
| request_id | INTEGER | Foreign key to requests |
| old_status | request_status | Previous status |
| new_status | request_status | New status |
| changed_by | INTEGER | Foreign key to users |
| role | user_role | Role of person who changed |
| comment | TEXT | Optional comment |
| created_at | TIMESTAMP | When change happened |

### 2️⃣ **ENUM Types**

- **user_role**: User, Manager, Admin
- **request_status**: Submitted, Approved, Rejected, Needs Clarification, Closed, Reopened
- **request_priority**: Low, Medium, High, Critical
- **request_category**: Technical, Administrative, Financial, HR, Other

### 3️⃣ **Sample Users**

| ID | Name | Email | Password | Role |
|----|------|-------|----------|------|
| 1 | John User | user@example.com | password123 | User |
| 2 | Jane Manager | manager@example.com | password123 | Manager |
| 3 | Admin User | admin@example.com | password123 | Admin |

### 4️⃣ **Sample Requests**

| ID | Title | Status | Priority | Category |
|----|-------|--------|----------|----------|
| 1 | New Laptop Request | Closed | High | Administrative |
| 2 | Update Office Contact | Needs Clarification | Medium | Administrative |
| 3 | Fix Login Page Bug | Submitted | Critical | Technical |
| 4 | Annual Leave Request | Approved | Medium | HR |
| 5 | New Office Furniture | Rejected | Low | Administrative |
| 6 | Software License Renewal | Submitted | High | Financial |

### 5️⃣ **Sample Action Logs**

11 action log entries showing complete workflows:
- Request creation
- Status changes
- Comments from users/managers/admins
- Complete audit trail

---

## 🔍 Verify Installation

After running the script, verify with these queries:

```sql
-- Check users
SELECT * FROM users;

-- Check requests
SELECT * FROM requests;

-- Check action logs
SELECT * FROM request_logs;

-- Check request with logs
SELECT 
  r.id,
  r.title,
  r.status,
  COUNT(rl.id) as log_count
FROM requests r
LEFT JOIN request_logs rl ON r.id = rl.request_id
GROUP BY r.id, r.title, r.status
ORDER BY r.id;
```

---

## 🔑 Login Credentials

Use these credentials to test the application:

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

## 🧪 Test Scenarios

After setup, you can test:

1. **Login as User** → See 6 requests
2. **Login as Manager** → Review and approve/reject
3. **Login as Admin** → Close/reopen requests
4. **Check Action Logs** → See complete history

---

## 🔄 Reset Database

If you want to start fresh:

```sql
-- Drop all tables
DROP TABLE IF EXISTS request_logs CASCADE;
DROP TABLE IF EXISTS requests CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Drop all types
DROP TYPE IF EXISTS user_role CASCADE;
DROP TYPE IF EXISTS request_status CASCADE;
DROP TYPE IF EXISTS request_priority CASCADE;
DROP TYPE IF EXISTS request_category CASCADE;

-- Then run the setup script again
\i COMPLETE_DATABASE_SETUP.sql
```

---

## ⚠️ Important Notes

1. **Password Hash**: The password hash in the file is for `password123`
2. **Timestamps**: Uses `NOW()` with intervals for realistic dates
3. **Foreign Keys**: Properly set up with CASCADE/SET NULL
4. **Indexes**: Created for better query performance
5. **Triggers**: Auto-update `updated_at` timestamp

---

## 🐛 Troubleshooting

### Error: "database does not exist"
```bash
psql -U postgres -c "CREATE DATABASE workflow_db;"
```

### Error: "role does not exist"
```bash
# Create PostgreSQL user
psql -U postgres -c "CREATE USER your_user WITH PASSWORD 'your_password';"
psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE workflow_db TO your_user;"
```

### Error: "permission denied"
```bash
# Grant permissions
psql -U postgres -d workflow_db -c "GRANT ALL ON ALL TABLES IN SCHEMA public TO your_user;"
psql -U postgres -d workflow_db -c "GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO your_user;"
```

---

## 📞 Support

If you encounter issues:
1. Check PostgreSQL is running: `pg_isready`
2. Check database exists: `psql -U postgres -l`
3. Check connection: `psql -U postgres -d workflow_db`
4. Review error messages carefully

---

## ✅ Success Indicators

After successful setup, you should see:

```
✅ 3 users created
✅ 6 requests created
✅ 11 action logs created
✅ All tables and indexes created
✅ All triggers set up
✅ Ready to use!
```

---

**Happy Testing! 🎉**
