## Ödev 1

- Used ChatGPT to help design the ER diagram for a Gym Membership System.
- Used ChatGPT to draft the PostgreSQL schema with five tables, primary keys, foreign keys, and a many-to-many relationship.
- Used ChatGPT to prepare the README description.
- Used ChatGPT for step-by-step guidance on creating the GitHub repository, branch, and assignment files.
- I am responsible for reviewing, understanding, testing, and submitting the final work.

## Ödev 2 — Yapay Zekâ Kullanımı

**Kullanılan araç:** ChatGPT

**Kullanım amacı:** Spor salonu üyelik sistemi için SQL bütünlük kurallarının, ihlal testlerinin, silme politikalarının ve ilişkisel cebir sorgularının hazırlanmasında yardım almak.

### D6 — Bölme (Division) Sorgusu

**ChatGPT'ye verilen istek:**

"Spor salonu üyelik sisteminde bütün Yoga derslerine kayıt yaptırmış üyeleri bulan PostgreSQL sorgusunu yaz. İç içe NOT EXISTS kullan."

**ChatGPT'nin önerdiği sorgu:**

```sql
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
```

**Değerlendirme:** Sorgu, her üyenin bütün Yoga derslerine kayıtlı olup olmadığını iç içe `NOT EXISTS` ile kontrol eder. Örnek verilerimize göre beklenen sonuç Zeynep Arslan'dır.

**Test durumu:** PostgreSQL kurulumu sırasında veritabanı başlatma hatası oluştuğu için sorgu henüz çalıştırılamadı. Gerçek SQL çıktısı alınamadı.

**Yapılan düzenlemeler:** Veritabanı ve sütun adları Gym Membership System şemasına uyarlandı. Silme politikalarıyla uyumlu olması için foreign key tanımları güncellendi.
