-- Vercel Postgres Setup
-- Run this in Vercel Postgres SQL Editor

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('User', 'Manager', 'Admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create requests table
CREATE TABLE IF NOT EXISTS requests (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    category VARCHAR(50) NOT NULL,
    priority VARCHAR(20) NOT NULL CHECK (priority IN ('Low', 'Medium', 'High')),
    status VARCHAR(50) NOT NULL DEFAULT 'Submitted',
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create request_logs table
CREATE TABLE IF NOT EXISTS request_logs (
    id SERIAL PRIMARY KEY,
    request_id INTEGER NOT NULL REFERENCES requests(id) ON DELETE CASCADE,
    action VARCHAR(100) NOT NULL,
    old_status VARCHAR(50),
    new_status VARCHAR(50) NOT NULL,
    comment TEXT,
    user_id INTEGER NOT NULL REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert demo users (passwords are hashed for 'password123')
INSERT INTO users (name, email, password, role) VALUES
('John User', 'user@example.com', '$2a$10$rZ5YhJKLHx5YhJKLHx5YhOqK5YhJKLHx5YhJKLHx5YhJKLHx5YhJK', 'User'),
('Jane Manager', 'manager@example.com', '$2a$10$rZ5YhJKLHx5YhJKLHx5YhOqK5YhJKLHx5YhJKLHx5YhJKLHx5YhJK', 'Manager'),
('Admin User', 'admin@example.com', '$2a$10$rZ5YhJKLHx5YhJKLHx5YhOqK5YhJKLHx5YhJKLHx5YhJKLHx5YhJK', 'Admin')
ON CONFLICT (email) DO NOTHING;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_requests_user_id ON requests(user_id);
CREATE INDEX IF NOT EXISTS idx_requests_status ON requests(status);
CREATE INDEX IF NOT EXISTS idx_request_logs_request_id ON request_logs(request_id);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
