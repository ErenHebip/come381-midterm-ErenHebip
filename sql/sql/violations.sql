
\set VERBOSITY verbose

-- COME381 Odev 2 - Bolum B
-- Her test kendi transaction blogunda calisir.
-- Beklenen hatalardan sonra ROLLBACK ile devam edilir.
-- On kosul: schema.sql ve constraints.sql calistirilmis olmalidir.

-- Testler icin temiz baslangic
TRUNCATE TABLE class_registration, fitness_class, member,
    trainer, membership_plan RESTART IDENTITY CASCADE;

INSERT INTO membership_plan (plan_name, monthly_fee, duration_months)
VALUES ('Standard', 500, 1), ('Premium', 900, 12);

INSERT INTO member (plan_id, full_name, join_date, birth_date)
VALUES (1, 'Ali Yilmaz', '2026-10-01', '2000-05-10');

INSERT INTO trainer (full_name, specialization)
VALUES ('Ayse Demir', 'Pilates');

INSERT INTO fitness_class (trainer_id, class_name, start_datetime, capacity)
VALUES (1, 'Morning Pilates', '2026-11-01 09:00', 20);

INSERT INTO class_registration (member_id, class_id, registration_date)
VALUES (1, 1, '2026-10-20');

-- T01 | chk_membership_plan_fee | Beklenen: 23514
BEGIN;
INSERT INTO membership_plan (plan_name, monthly_fee, duration_months)
VALUES ('Negative Fee', -100, 3);
ROLLBACK;

-- T02 | chk_membership_plan_duration | Beklenen: 23514
BEGIN;
INSERT INTO membership_plan (plan_name, monthly_fee, duration_months)
VALUES ('Zero Duration', 100, 0);
ROLLBACK;

-- T03 | chk_fitness_class_capacity | Beklenen: 23514
BEGIN;
INSERT INTO fitness_class (trainer_id, class_name, start_datetime, capacity)
VALUES (1, 'Invalid Capacity', '2026-11-02 09:00', -1);
ROLLBACK;

-- T04 | chk_fitness_class_capacity | Beklenen: OK (sinir: 1)
BEGIN;
INSERT INTO fitness_class (trainer_id, class_name, start_datetime, capacity)
VALUES (1, 'Minimum Capacity', '2026-11-02 10:00', 1);
ROLLBACK;

-- T05 | uq_membership_plan_name | Beklenen: 23505
BEGIN;
INSERT INTO membership_plan (plan_name, monthly_fee, duration_months)
VALUES ('Standard', 600, 6);
ROLLBACK;

-- T06 | uq_registration_member_class | Beklenen: 23505
BEGIN;
INSERT INTO class_registration (member_id, class_id, registration_date)
VALUES (1, 1, '2026-10-21');
ROLLBACK;

-- T07 | fk_registration_member | Beklenen: 23503
BEGIN;
INSERT INTO class_registration (member_id, class_id, registration_date)
VALUES (9999, 1, '2026-10-21');
ROLLBACK;

-- T08 | fk_registration_member | Beklenen: 23503
-- Mevcut uyeyi silmek, ona bagli kayit nedeniyle engellenir.
BEGIN;
DELETE FROM member WHERE member_id = 1;
ROLLBACK;

-- T09 | fk_registration_class | Beklenen: 23503
BEGIN;
INSERT INTO class_registration (member_id, class_id, registration_date)
VALUES (1, 9999, '2026-10-21');
ROLLBACK;

-- T10 | fk_member_plan | Beklenen: 23503
BEGIN;
INSERT INTO member (plan_id, full_name, join_date)
VALUES (9999, 'Unknown Plan Member', '2026-10-21');
ROLLBACK;

-- T11 | fk_fitness_class_trainer | Beklenen: 23503
BEGIN;
INSERT INTO fitness_class (trainer_id, class_name, start_datetime, capacity)
VALUES (9999, 'Unknown Trainer', '2026-11-03 09:00', 10);
ROLLBACK;

-- T12 | member.full_name NOT NULL | Beklenen: 23502
BEGIN;
INSERT INTO member (plan_id, full_name, join_date)
VALUES (1, NULL, '2026-10-21');
ROLLBACK;

-- T13 | chk_member_birth_before_join | Beklenen: 23514
BEGIN;
INSERT INTO member (plan_id, full_name, join_date, birth_date)
VALUES (1, 'Future Birth', '2026-10-01', '2026-10-02');
ROLLBACK;
