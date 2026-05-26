-- Fix user passwords with correct bcrypt hash
-- Password for all users: password123

UPDATE users SET password = '$2a$10$9FwEEvPufZ.VoT5NdcCZCecZLGZsZt/Rr2xgiqeKXc4MVkk8lwr7u' WHERE email = 'user@example.com';
UPDATE users SET password = '$2a$10$9FwEEvPufZ.VoT5NdcCZCecZLGZsZt/Rr2xgiqeKXc4MVkk8lwr7u' WHERE email = 'manager@example.com';
UPDATE users SET password = '$2a$10$9FwEEvPufZ.VoT5NdcCZCecZLGZsZt/Rr2xgiqeKXc4MVkk8lwr7u' WHERE email = 'admin@example.com';

-- Verify the update
SELECT id, name, email, role FROM users;
