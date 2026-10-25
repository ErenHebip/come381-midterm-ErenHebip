
-- COME381 Odev 2 - Bolum D
-- Gym Membership System
-- On kosul: schema.sql, constraints.sql ve seed.sql calistirilmali.

-- D1: Secme ve projeksiyon
-- Kapasitesi 20'den buyuk derslerin adlari
SELECT class_name
FROM fitness_class
WHERE capacity > 20;

-- D2: JOIN
-- Uyelerin kaydoldugu dersler
SELECT m.full_name, f.class_name
FROM member AS m
JOIN class_registration AS cr
    ON m.member_id = cr.member_id
JOIN fitness_class AS f
    ON cr.class_id = f.class_id;

-- D3: UNION
-- Yoga veya Pilates dersine katilan uyeler
SELECT m.member_id, m.full_name
FROM member AS m
JOIN class_registration AS cr
    ON m.member_id = cr.member_id
JOIN fitness_class AS f
    ON cr.class_id = f.class_id
WHERE f.class_name = 'Yoga'

UNION

SELECT m.member_id, m.full_name
FROM member AS m
JOIN class_registration AS cr
    ON m.member_id = cr.member_id
JOIN fitness_class AS f
    ON cr.class_id = f.class_id
WHERE f.class_name = 'Pilates';

-- D4: DIFFERENCE - EXCEPT
-- Hicbir derse kaydolmamis uyeler
SELECT member_id, full_name
FROM member

EXCEPT

SELECT m.member_id, m.full_name
FROM member AS m
JOIN class_registration AS cr
    ON m.member_id = cr.member_id;

-- D4: DIFFERENCE - NOT EXISTS
-- Ayni sorunun ikinci cozum yolu
SELECT m.member_id, m.full_name
FROM member AS m
WHERE NOT EXISTS (
    SELECT 1
    FROM class_registration AS cr
    WHERE cr.member_id = m.member_id
);

-- D5: RENAME ve SELF JOIN
-- Ayni uyelik planina sahip farkli uye ciftleri
SELECT
    m1.full_name AS member_1,
    m2.full_name AS member_2
FROM member AS m1
JOIN member AS m2
    ON m1.plan_id = m2.plan_id
   AND m1.member_id < m2.member_id;

-- D6: DIVISION
-- Butun Yoga derslerine kaydolmus uyeler
SELECT m.member_id, m.full_name
FROM member AS m
WHERE NOT EXISTS (
    SELECT 1
    FROM fitness_class AS f
    WHERE f.class_name LIKE '%Yoga%'
      AND NOT EXISTS (
          SELECT 1
          FROM class_registration AS cr
          WHERE cr.member_id = m.member_id
            AND cr.class_id = f.class_id
      )
);
