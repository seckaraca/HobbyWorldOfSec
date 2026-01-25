/*
TEST TC-01: Veri Doğrulama (Data Integrity)
-------------------------------------------
Sorgu: SELECT * FROM employees;
Beklenen Sonuç: 
1. Hakan Çelik -> Depo (35,000.00)
2. Leyla Yılmaz -> Muhasebe (45,000.00)
*/

/*
TEST TC-02: Mükerrer E-posta Engeli (Unique Constraint)
-------------------------------------------
Sorgu: 
INSERT INTO employees (first_name, last_name, email, department, salary) 
VALUES ('Deneme', 'User', 'leyla@hobbyworldofsec.com', 'Test', 10000.00);

Beklenen Sonuç: "duplicate key value violates unique constraint" hatası alınmalı.
*/