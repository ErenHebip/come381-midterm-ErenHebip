# COME381 — Ödev 2

## Çalıştırma Sırası

```bash
psql -d come381 -f sql/schema.sql
psql -d come381 -f week-05/constraints.sql
psql -d come381 -f week-05/seed.sql
psql -d come381 -f week-05/violations.sql
psql -d come381 -f week-05/algebra.sql
```

Not: `sql/schema.sql` ve `sql/constraints.sql` dosyaları depo kökünde bulunuyorsa komut yolları buna göre düzenlenmelidir. İhlal testleri beklenen SQL hatalarını üretir.

## NULL Testi

`violations.sql` dosyasındaki T12 testi, `member.full_name` alanına `NULL` eklemeyi deneyerek `NOT NULL` kuralını kontrol eder. Beklenen SQLSTATE kodu `23502`'dir.

## Beklenenden Farklı Durum ve Öğrenilenler

PostgreSQL kurulumu sırasında veritabanı kümesi başlatılamadığı için SQL testleri henüz çalıştırılamadı. Bu nedenle beklenen sonuçlarla gerçek çıktılar karşılaştırılamadı. Test sonuçlarının doğrulanması için çalışan bir PostgreSQL ortamı gereklidir.
