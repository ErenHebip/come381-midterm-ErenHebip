# Silme Politikası — Gym Membership System

## Foreign Key Silme Politikaları

| Foreign Key | Ebeveyn → Çocuk | Seçilen Politika | Neden |
|---|---|---|---|
| fk_member_plan | membership_plan → member | RESTRICT | Bir plana bağlı üyeler varken planın silinmesini engeller. |
| fk_fitness_class_trainer | trainer → fitness_class | RESTRICT | Antrenörün dersleri varken silinmesini engeller. |
| fk_registration_member | member → class_registration | CASCADE | Üye silindiğinde ona ait ders kayıtları da silinir. |
| fk_registration_class | fitness_class → class_registration | CASCADE | Ders silindiğinde o derse ait kayıtlar da silinir. |

## Politika Açıklamaları

**CASCADE:** Ebeveyn kayıt silindiğinde ilişkili çocuk kayıtlar da otomatik olarak silinir.

**RESTRICT:** İlişkili çocuk kayıt varsa ebeveyn kaydın silinmesine izin verilmez.

**NO ACTION:** PostgreSQL'de varsayılan davranıştır. RESTRICT'ten farkı, ertelenebilir kısıtlarda kontrolün işlem sonuna bırakılabilmesidir.

## CASCADE Testi

Üye silinmeden önce:

```sql
SELECT COUNT(*) FROM class_registration WHERE member_id = 1;
```

Üye silme işlemi:

```sql
DELETE FROM member WHERE member_id = 1;
```

Üye silindikten sonra:

```sql
SELECT COUNT(*) FROM class_registration WHERE member_id = 1;
```

**Beklenen sonuç:** Üyeye ait ders kayıtlarının sayısı sıfıra düşer.

**Gerçek sonuç:** PostgreSQL bağlantısı kurulamadığı için test henüz çalıştırılamadı.

## Önemli Not

Bu belgede seçilen politikaların uygulanabilmesi için `sql/constraints.sql` dosyasındaki foreign key tanımlarının ilgili `ON DELETE` seçenekleriyle güncellenmesi gerekir.
