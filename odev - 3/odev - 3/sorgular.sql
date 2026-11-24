-- Q1: Fiyatı 50 TL'den yüksek ürünleri pahalıdan ucuza sırala.
-- Ne işe yarar: Kafenin pahalı ürünlerini belirlemeyi sağlar.
SELECT name, price
FROM product
WHERE price > 50
ORDER BY price DESC;

-- Q2: YBS bölümündeki müşterilerin adlarını alfabetik sırala.
-- Ne işe yarar: YBS bölümündeki müşterileri belirlemeyi sağlar.
SELECT full_name
FROM customer
WHERE department = 'YBS'
ORDER BY full_name;

-- Q3: Sipariş numarasını, tarihini ve müşteri adını listele.
-- Ne işe yarar: Siparişlerin hangi müşteriye ait olduğunu gösterir.
SELECT o.order_id, o.order_date, c.full_name
FROM orders o
INNER JOIN customer c ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- Q4: Her sipariş kaleminin ürün adını ve adedini listele.
-- Ne işe yarar: Hangi üründen kaç adet alındığını gösterir.
SELECT oi.order_id, p.name, oi.quantity
FROM order_item oi
INNER JOIN product p ON oi.product_id = p.product_id
ORDER BY oi.order_id, oi.product_id;

-- Q5: Her müşterinin sipariş sayısını listele.
-- Ne işe yarar: Müşterilerin sipariş sıklığını gösterir.
SELECT c.full_name, COUNT(o.order_id) AS siparis_sayisi
FROM customer c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY siparis_sayisi DESC, c.full_name;

-- Q6: Her ürün kategorisinin ortalama fiyatını bul.
-- Ne işe yarar: Kategorilerin ortalama fiyatlarını karşılaştırır.
SELECT category, ROUND(AVG(price), 2) AS ortalama_fiyat
FROM product
GROUP BY category
ORDER BY category;