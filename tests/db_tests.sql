-- ==========================================
-- HOBBYWORLDOFSEC - MASTER QA TEST SUITE
-- ==========================================

-- 1. ESKİ TEST: Personel ve Görev Dağılımı
SELECT 'TEST 1: Personel Listesi' AS rapor;
SELECT first_name, last_name, role FROM employees;

-- 2. ESKİ TEST: Kritik Stok Seviyesi (Stok Yönetimi)
SELECT 'TEST 2: Kritik Stok Kontrolü (10 altı)' AS rapor;
SELECT product_name, stock_quantity FROM products WHERE stock_quantity < 10;

-- 3. İLİŞKİSEL TEST: Stok Hareketi ve Muhasebe Eşleşmesi
-- (Bu test, tablolar arası bağın kopup kopmadığını denetler)
SELECT 'TEST 3: Stok ve Muhasebe Mutabakatı' AS rapor;
SELECT 
    p.product_name, 
    il.change_amount, 
    ar.total_amount,
    ar.transaction_type
FROM inventory_logs il
JOIN products p ON il.product_id = p.product_id
JOIN accounting_records ar ON il.log_id = ar.log_id;

-- 4. ÖZET TEST: Toplam Kayıt Sayıları
SELECT 'TEST 4: Sistem Sağlık Taraması' AS rapor;
SELECT 
    (SELECT COUNT(*) FROM products) as toplam_urun,
    (SELECT COUNT(*) FROM employees) as toplam_personel,
    (SELECT COUNT(*) FROM accounting_records) as toplam_islem;
