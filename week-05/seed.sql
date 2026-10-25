
-- Spor salonu üyelik planları
INSERT INTO membership_plan (plan_name, monthly_fee, duration_months)
VALUES
('Basic', 500, 1),
('Standard', 1200, 3),
('Premium', 4000, 12);

-- Üyeler
INSERT INTO member (plan_id, full_name, join_date, birth_date)
VALUES
(1, 'Ali Yilmaz', '2026-01-10', '2002-05-15'),
(2, 'Ayse Demir', '2026-02-12', '2001-08-20'),
(3, 'Mehmet Kaya', '2026-03-05', '1999-11-10'),
(1, 'Zeynep Arslan', '2026-04-01', '2003-02-14'),
(2, 'Can Aydin', '2026-04-15', '2000-07-22');

-- Antrenörler
INSERT INTO trainer (full_name, specialization)
VALUES
('Burak Celik', 'Yoga'),
('Elif Yildiz', 'Pilates'),
('Deniz Aksoy', 'Fitness');

-- Grup dersleri
INSERT INTO fitness_class (trainer_id, class_name, start_datetime, capacity)
VALUES
(1, 'Yoga', '2026-11-01 10:00', 20),
(2, 'Pilates', '2026-11-02 11:00', 15),
(3, 'Fitness', '2026-11-03 12:00', 25),
(1, 'Advanced Yoga', '2026-11-04 10:00', 12),
(3, 'Cardio', '2026-11-05 14:00', 30);

-- Ders kayıtları
INSERT INTO class_registration (member_id, class_id, registration_date)
VALUES
(1, 1, '2026-10-20'),
(1, 2, '2026-10-20'),
(2, 1, '2026-10-21'),
(2, 3, '2026-10-21'),
(3, 2, '2026-10-22'),
(3, 3, '2026-10-22'),
(4, 1, '2026-10-23'),
(4, 4, '2026-10-23'),
(5, 3, '2026-10-24'),
(5, 5, '2026-10-24');
