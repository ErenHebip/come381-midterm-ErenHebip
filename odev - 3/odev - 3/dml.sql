\set VERBOSITY verbose

-- Transaction başlat
BEGIN;

-- Güncelleme öncesi fiyatlar
SELECT product_id, name, price
FROM product
WHERE category = 'Sıcak İçecek'
ORDER BY product_id;

-- Sıcak içeceklerin fiyatını 5 TL artır
UPDATE product
SET price = price + 5
WHERE category = 'Sıcak İçecek';

-- Güncelleme sonrası fiyatlar
SELECT product_id, name, price
FROM product
WHERE category = 'Sıcak İçecek'
ORDER BY product_id;

-- Bilerek yabancı anahtar hatası oluştur
INSERT INTO order_item (order_id, product_id, quantity)
VALUES (1, 999, 1);

-- İşlemleri geri al
ROLLBACK;

-- Geri alma sonrası fiyatları kontrol et
SELECT product_id, name, price
FROM product
WHERE category = 'Sıcak İçecek'
ORDER BY product_id;