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

-- 1. ÜRÜNLER TABLOSU
CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50), 
    price DECIMAL(10, 2) NOT NULL,
    current_stock INT DEFAULT 0
);

-- 2. ENVANTER HAREKETLERİ (Üstteki employee_id ismine göre düzelttim)
CREATE TABLE IF NOT EXISTS inventory_logs (
    log_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    employee_id INT REFERENCES employees(employee_id), -- 'id' değil 'employee_id' yaptık
    change_amount INT NOT NULL,
    movement_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. MUHASEBE KAYITLARI (Üstteki employee_id ismine göre düzelttim)
CREATE TABLE IF NOT EXISTS accounting_records (
    record_id SERIAL PRIMARY KEY,
    log_id INT REFERENCES inventory_logs(log_id),
    accountant_id INT REFERENCES employees(employee_id), -- 'id' değil 'employee_id' yaptık
    total_amount DECIMAL(15, 2),
    record_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. ADMIN EKLEME (Üstteki kolon isimlerine göre düzelttim)
INSERT INTO employees (first_name, last_name, email, department, salary) 
SELECT 'Seckin', 'Admin', 'admin@hobbyworld.com', 'Owner', 0
WHERE NOT EXISTS (SELECT 1 FROM employees WHERE email = 'admin@hobbyworld.com');

-- 5. SİPARİŞLER TABLOSU
CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES users(user_id), -- Siparişi veren müşteri
    product_id INT REFERENCES products(product_id), -- Satılan ürün
    quantity INT NOT NULL, -- Kaç adet satıldı?
    total_price DECIMAL(10, 2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending' -- 'hazırlanıyor', 'kargolandı' vb.
);