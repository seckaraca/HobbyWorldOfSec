-- ==========================================
-- 1. TABLO YAPILARI (SCHEMA)
-- ==========================================

-- Kullanıcılar Tablosu 
CREATE TABLE IF NOT EXISTS users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) DEFAULT 'customer',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Personel Tablosu
CREATE TABLE IF NOT EXISTS employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL, -- Profesyonel kural: Email benzersiz olmalı
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE DEFAULT CURRENT_DATE
);

-- ==========================================
-- 2. BAŞLANGIÇ VERİLERİ (SEED DATA)
-- ==========================================

-- Yönetici Hesabı (Seni ekleyelim)
INSERT INTO users (username, email, password_hash, role)
VALUES ('seckin_admin', 'seckin@hobbyworld.com', 'hash_sifre_123', 'admin')
ON CONFLICT (username) DO NOTHING;

-- Hakan Çelik (Depo Görevlisi)
INSERT INTO employees (first_name, last_name, email, department, salary)
VALUES ('Hakan', 'Çelik', 'hakan.celik@hobbyworldofsec.com', 'Depo', 35000.00)
ON CONFLICT (email) DO NOTHING;

-- Leyla Yılmaz (Muhasebeci)
INSERT INTO employees (first_name, last_name, email, department, salary)
VALUES ('Leyla', 'Yılmaz', 'leyla@hobbyworldofsec.com', 'Muhasebe', 45000.00)
ON CONFLICT (email) DO NOTHING;

-- ==========================================
-- 3. KONTROL SORGUSU
-- ==========================================
SELECT * FROM employees;