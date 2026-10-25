
-- ÖDEV 2 / BÖLÜM A
-- Gym Membership System: Veri bütünlüğü kuralları
-- Bu dosya schema.sql dosyasından sonra çalıştırılır.

-- Zorunlu bilgilerin boş bırakılmasını engeller.
ALTER TABLE membership_plan
    ALTER COLUMN plan_name SET NOT NULL,
    ALTER COLUMN monthly_fee SET NOT NULL,
    ALTER COLUMN duration_months SET NOT NULL;

ALTER TABLE member
    ALTER COLUMN plan_id SET NOT NULL,
    ALTER COLUMN full_name SET NOT NULL,
    ALTER COLUMN join_date SET NOT NULL;

ALTER TABLE trainer
    ALTER COLUMN full_name SET NOT NULL;

ALTER TABLE fitness_class
    ALTER COLUMN trainer_id SET NOT NULL,
    ALTER COLUMN class_name SET NOT NULL,
    ALTER COLUMN start_datetime SET NOT NULL,
    ALTER COLUMN capacity SET NOT NULL;

ALTER TABLE class_registration
    ALTER COLUMN member_id SET NOT NULL,
    ALTER COLUMN class_id SET NOT NULL,
    ALTER COLUMN registration_date SET NOT NULL;

-- Aynı üyelik planı adı iki kez kullanılamaz.
ALTER TABLE membership_plan
    ADD CONSTRAINT uq_membership_plan_name UNIQUE (plan_name);

-- Aynı üye aynı derse iki kez kayıt yaptıramaz.
ALTER TABLE class_registration
    ADD CONSTRAINT uq_registration_member_class UNIQUE (member_id, class_id);

-- Aylık üyelik ücreti negatif olamaz.
ALTER TABLE membership_plan
    ADD CONSTRAINT chk_membership_plan_fee
    CHECK (monthly_fee >= 0);

-- Üyelik süresi en az bir ay olmalıdır.
ALTER TABLE membership_plan
    ADD CONSTRAINT chk_membership_plan_duration
    CHECK (duration_months > 0);

-- Grup dersinin kapasitesi sıfırdan büyük olmalıdır.
ALTER TABLE fitness_class
    ADD CONSTRAINT chk_fitness_class_capacity
    CHECK (capacity > 0);

-- Üyelerin doğum tarihi kayıt tarihinden sonra olamaz.
ALTER TABLE member
    ADD CONSTRAINT chk_member_birth_before_join
    CHECK (birth_date IS NULL OR birth_date <= join_date);

-- Önceden tanımlanmış foreign key'leri kaldır.
ALTER TABLE member DROP CONSTRAINT member_plan_id_fkey;
ALTER TABLE fitness_class DROP CONSTRAINT fitness_class_trainer_id_fkey;
ALTER TABLE class_registration DROP CONSTRAINT class_registration_member_id_fkey;
ALTER TABLE class_registration DROP CONSTRAINT class_registration_class_id_fkey;


-- Bir plana bağlı üyeler varsa plan silinemez.
ALTER TABLE member
    ADD CONSTRAINT fk_member_plan
    FOREIGN KEY (plan_id)
    REFERENCES membership_plan(plan_id)
    ON DELETE RESTRICT;

-- Bir antrenörün dersleri varsa antrenör silinemez.
ALTER TABLE fitness_class
    ADD CONSTRAINT fk_fitness_class_trainer
    FOREIGN KEY (trainer_id)
    REFERENCES trainer(trainer_id)
    ON DELETE RESTRICT;

-- Üye silinirse ders kayıtları da silinir.
ALTER TABLE class_registration
    ADD CONSTRAINT fk_registration_member
    FOREIGN KEY (member_id)
    REFERENCES member(member_id)
    ON DELETE CASCADE;

-- Ders silinirse o derse ait kayıtlar da silinir.
ALTER TABLE class_registration
    ADD CONSTRAINT fk_registration_class
    FOREIGN KEY (class_id)
    REFERENCES fitness_class(class_id)
    ON DELETE CASCADE;
