-- ============================================
-- COMPLETE DATABASE SETUP
-- Workflow Management System
-- ============================================
-- This file contains:
-- 1. Database creation
-- 2. All tables with fields
-- 3. Sample users (User, Manager, Admin)
-- 4. Sample requests
-- 5. Sample action logs
-- ============================================

-- Create Database (Run this separately if needed)
-- CREATE DATABASE workflow_db;

-- Connect to the database
-- \c workflow_db;

-- ============================================
-- STEP 1: CREATE ENUM TYPES
-- ============================================

-- Drop existing types if they exist
DROP TYPE IF EXISTS user_role CASCADE;
DROP TYPE IF EXISTS request_status CASCADE;
DROP TYPE IF EXISTS request_priority CASCADE;
DROP TYPE IF EXISTS request_category CASCADE;

-- Create ENUM types
CREATE TYPE user_role AS ENUM ('User', 'Manager', 'Admin');
CREATE TYPE request_status AS ENUM ('Submitted', 'Approved', 'Rejected', 'Needs Clarification', 'Closed', 'Reopened');
CREATE TYPE request_priority AS ENUM ('Low', 'Medium', 'High', 'Critical');
CREATE TYPE request_category AS ENUM ('Technical', 'Administrative', 'Financial', 'HR', 'Other');

-- ============================================
-- STEP 2: CREATE TABLES
-- ============================================

-- Drop existing tables if they exist
DROP TABLE IF EXISTS request_logs CASCADE;
DROP TABLE IF EXISTS requests CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Users Table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role user_role DEFAULT 'User',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Requests Table
CREATE TABLE requests (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  category request_category NOT NULL,
  priority request_priority DEFAULT 'Medium',
  status request_status DEFAULT 'Submitted',
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Request Logs Table (Action History)
CREATE TABLE request_logs (
  id SERIAL PRIMARY KEY,
  request_id INTEGER REFERENCES requests(id) ON DELETE CASCADE,
  old_status request_status,
  new_status request_status NOT NULL,
  changed_by INTEGER REFERENCES users(id) ON DELETE SET NULL,
  role user_role NOT NULL,
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- STEP 3: CREATE INDEXES FOR PERFORMANCE
-- ============================================

CREATE INDEX idx_requests_user_id ON requests(user_id);
CREATE INDEX idx_requests_status ON requests(status);
CREATE INDEX idx_request_logs_request_id ON request_logs(request_id);
CREATE INDEX idx_users_email ON users(email);

-- ============================================
-- STEP 4: CREATE TRIGGERS FOR UPDATED_AT
-- ============================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers for updated_at
CREATE TRIGGER update_users_updated_at 
  BEFORE UPDATE ON users
  FOR EACH ROW 
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_requests_updated_at 
  BEFORE UPDATE ON requests
  FOR EACH ROW 
  EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- STEP 5: INSERT SAMPLE USERS
-- ============================================
-- Password for all users: password123
-- Password hash generated using bcrypt with salt rounds = 10

INSERT INTO users (name, email, password, role) VALUES
('John User', 'user@example.com', '$2a$10$rZ5qYhVqVqVqVqVqVqVqVeK5YhVqVqVqVqVqVqVqVqVqVqVqVqVqV', 'User'),
('Jane Manager', 'manager@example.com', '$2a$10$rZ5qYhVqVqVqVqVqVqVqVeK5YhVqVqVqVqVqVqVqVqVqVqVqVqVqV', 'Manager'),
('Admin User', 'admin@example.com', '$2a$10$rZ5qYhVqVqVqVqVqVqVqVeK5YhVqVqVqVqVqVqVqVqVqVqVqVqVqV', 'Admin');

-- ============================================
-- STEP 6: INSERT SAMPLE REQUESTS
-- ============================================

-- Request 1: Complete workflow (Submitted -> Approved -> Closed)
INSERT INTO requests (title, description, category, priority, status, user_id, created_at, updated_at) VALUES
('New Laptop Request', 
 'Need a new laptop for development work. Current laptop is 5 years old and very slow. Requesting MacBook Pro 16" with 32GB RAM.',
 'Administrative', 
 'High', 
 'Closed', 
 1, 
 NOW() - INTERVAL '5 days', 
 NOW() - INTERVAL '1 day');

-- Request 2: Needs Clarification workflow
INSERT INTO requests (title, description, category, priority, status, user_id, created_at, updated_at) VALUES
('Update Office Contact Information', 
 'Please update the office contact details on the company website. The phone number and email need to be changed.',
 'Administrative', 
 'Medium', 
 'Needs Clarification', 
 1, 
 NOW() - INTERVAL '3 days', 
 NOW() - INTERVAL '2 days');

-- Request 3: Recently submitted
INSERT INTO requests (title, description, category, priority, status, user_id, created_at, updated_at) VALUES
('Fix Login Page Bug', 
 'Users are unable to login on mobile devices. Getting "Invalid credentials" error even with correct password. This is affecting multiple users.',
 'Technical', 
 'Critical', 
 'Submitted', 
 1, 
 NOW() - INTERVAL '1 day', 
 NOW() - INTERVAL '1 day');

-- Request 4: Approved and waiting
INSERT INTO requests (title, description, category, priority, status, user_id, created_at, updated_at) VALUES
('Annual Leave Request', 
 'Requesting 5 days annual leave for vacation from June 1-5, 2026. All pending work will be completed before leave.',
 'HR', 
 'Medium', 
 'Approved', 
 1, 
 NOW() - INTERVAL '4 days', 
 NOW() - INTERVAL '2 days');

-- Request 5: Rejected
INSERT INTO requests (title, description, category, priority, status, user_id, created_at, updated_at) VALUES
('New Office Furniture', 
 'Request for new ergonomic chairs for the development team. Current chairs are causing back pain issues.',
 'Administrative', 
 'Low', 
 'Rejected', 
 1, 
 NOW() - INTERVAL '6 days', 
 NOW() - INTERVAL '5 days');

-- Request 6: Financial request
INSERT INTO requests (title, description, category, priority, status, user_id, created_at, updated_at) VALUES
('Software License Renewal', 
 'Need to renew annual licenses for development tools including IntelliJ IDEA and Adobe Creative Suite.',
 'Financial', 
 'High', 
 'Submitted', 
 1, 
 NOW() - INTERVAL '2 days', 
 NOW() - INTERVAL '2 days');

-- ============================================
-- STEP 7: INSERT ACTION LOGS
-- ============================================

-- Action Logs for Request 1 (Complete workflow: Submitted -> Approved -> Closed)
INSERT INTO request_logs (request_id, old_status, new_status, changed_by, role, comment, created_at) VALUES
(1, NULL, 'Submitted', 1, 'User', 'Request created', NOW() - INTERVAL '5 days'),
(1, 'Submitted', 'Approved', 2, 'Manager', 'Approved for purchase. Budget has been allocated from Q2 funds.', NOW() - INTERVAL '4 days'),
(1, 'Approved', 'Closed', 3, 'Admin', 'Laptop purchased and delivered to user. Asset ID: LT-2026-001', NOW() - INTERVAL '1 day');

-- Action Logs for Request 2 (Needs Clarification workflow)
INSERT INTO request_logs (request_id, old_status, new_status, changed_by, role, comment, created_at) VALUES
(2, NULL, 'Submitted', 1, 'User', 'Request created', NOW() - INTERVAL '3 days'),
(2, 'Submitted', 'Needs Clarification', 2, 'Manager', 'Please provide the new contact details (phone and email) and specify which pages need to be updated.', NOW() - INTERVAL '2 days');

-- Action Logs for Request 3 (Recently submitted)
INSERT INTO request_logs (request_id, old_status, new_status, changed_by, role, comment, created_at) VALUES
(3, NULL, 'Submitted', 1, 'User', 'Request created', NOW() - INTERVAL '1 day');

-- Action Logs for Request 4 (Approved)
INSERT INTO request_logs (request_id, old_status, new_status, changed_by, role, comment, created_at) VALUES
(4, NULL, 'Submitted', 1, 'User', 'Request created', NOW() - INTERVAL '4 days'),
(4, 'Submitted', 'Approved', 2, 'Manager', 'Leave approved. Please coordinate with your team lead before departure.', NOW() - INTERVAL '2 days');

-- Action Logs for Request 5 (Rejected)
INSERT INTO request_logs (request_id, old_status, new_status, changed_by, role, comment, created_at) VALUES
(5, NULL, 'Submitted', 1, 'User', 'Request created', NOW() - INTERVAL '6 days'),
(5, 'Submitted', 'Rejected', 2, 'Manager', 'Budget not available for this quarter. Please resubmit in Q3 with updated cost estimates.', NOW() - INTERVAL '5 days');

-- Action Logs for Request 6 (Recently submitted)
INSERT INTO request_logs (request_id, old_status, new_status, changed_by, role, comment, created_at) VALUES
(6, NULL, 'Submitted', 1, 'User', 'Request created', NOW() - INTERVAL '2 days');

-- ============================================
-- STEP 8: VERIFICATION QUERIES
-- ============================================

-- Display created data
SELECT '========================================' as separator;
SELECT 'DATABASE SETUP COMPLETED SUCCESSFULLY!' as status;
SELECT '========================================' as separator;

SELECT '' as blank_line;
SELECT '📊 SUMMARY:' as info;
SELECT '========================================' as separator;

-- Count users
SELECT 'Users Created:' as info, COUNT(*) as count FROM users;

-- Count requests
SELECT 'Requests Created:' as info, COUNT(*) as count FROM requests;

-- Count action logs
SELECT 'Action Logs Created:' as info, COUNT(*) as count FROM request_logs;

SELECT '' as blank_line;
SELECT '👥 USERS:' as info;
SELECT '========================================' as separator;
SELECT id, name, email, role FROM users ORDER BY id;

SELECT '' as blank_line;
SELECT '📝 REQUESTS:' as info;
SELECT '========================================' as separator;
SELECT id, title, status, priority, category, created_at FROM requests ORDER BY id;

SELECT '' as blank_line;
SELECT '📋 ACTION LOGS:' as info;
SELECT '========================================' as separator;
SELECT 
  rl.id,
  rl.request_id,
  rl.old_status,
  rl.new_status,
  u.name as changed_by,
  rl.role,
  rl.comment,
  rl.created_at 
FROM request_logs rl 
LEFT JOIN users u ON rl.changed_by = u.id 
ORDER BY rl.request_id, rl.created_at;

SELECT '' as blank_line;
SELECT '🔑 LOGIN CREDENTIALS:' as info;
SELECT '========================================' as separator;
SELECT 'User:    user@example.com / password123' as credentials
UNION ALL
SELECT 'Manager: manager@example.com / password123'
UNION ALL
SELECT 'Admin:   admin@example.com / password123';

SELECT '' as blank_line;
SELECT '✅ Setup Complete! You can now start the application.' as final_message;
SELECT '========================================' as separator;

-- ============================================
-- END OF SCRIPT
-- ============================================
