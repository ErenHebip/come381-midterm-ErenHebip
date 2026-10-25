# Bölüm D — İlişkisel Cebir ve SQL

**Senaryo:** Gym Membership System

## D1 — Seçme ve Projeksiyon

**Soru:** Kapasitesi 20'den büyük olan derslerin adları nelerdir?

**İlişkisel cebir:**

π_class_name(σ_capacity > 20(fitness_class))

**SQL:** `algebra.sql` dosyasındaki D1 sorgusu.

**Beklenen sonuç:** Fitness, Cardio.

## D2 — JOIN

**Soru:** Hangi üye hangi derse kayıt yaptırmıştır?

**İlişkisel cebir:**

π_full_name,class_name(member ⋈ class_registration ⋈ fitness_class)

**SQL:** `algebra.sql` dosyasındaki D2 sorgusu.

**Beklenen sonuç:** 10 üyelik-ders kaydı.

## D3 — UNION

**Soru:** Yoga veya Pilates derslerinden en az birine katılan üyeler kimlerdir?

**İlişkisel cebir:**

π_member_id,full_name(member ⋈ class_registration ⋈ σ_class_name='Yoga'(fitness_class))
∪
π_member_id,full_name(member ⋈ class_registration ⋈ σ_class_name='Pilates'(fitness_class))

**SQL:** `algebra.sql` dosyasındaki D3 sorgusu.

**Beklenen sonuç:** Ali Yilmaz, Ayse Demir, Mehmet Kaya, Zeynep Arslan.

## D4 — DIFFERENCE

**Soru:** Hiçbir derse kaydolmamış üyeler kimlerdir?

**İlişkisel cebir:**

π_member_id,full_name(member) − π_member_id,full_name(member ⋈ class_registration)

**SQL:** `algebra.sql` dosyasında iki yöntem vardır: `EXCEPT` ve `NOT EXISTS`.

**Beklenen sonuç:** Mevcut örnek verilerde tüm üyeler en az bir derse kayıtlı olduğu için boş sonuç.

## D5 — RENAME ve SELF JOIN

**Soru:** Aynı üyelik planına sahip farklı üye çiftleri kimlerdir?

**İlişkisel cebir:**

π_m1.full_name,m2.full_name(σ_m1.plan_id=m2.plan_id ∧ m1.member_id<m2.member_id(ρ_m1(member) × ρ_m2(member)))

**SQL:** `algebra.sql` dosyasındaki D5 sorgusu.

**Beklenen sonuç:** Ali Yilmaz – Zeynep Arslan ve Ayse Demir – Can Aydin.

## D6 — DIVISION

**Soru:** Bütün Yoga derslerine kayıt yaptırmış üyeler kimlerdir?

**İlişkisel cebir:**

R = π_member_id,class_id(class_registration)

S = π_class_id(σ_class_name LIKE '%Yoga%'(fitness_class))

Sonuç = π_member_id,full_name(member ⋈ (R ÷ S))

**SQL:** `algebra.sql` dosyasındaki D6 sorgusu. İç içe `NOT EXISTS` kullanılmıştır.

**Beklenen sonuç:** Zeynep Arslan.

## İlişkisel Hesap

**D1 için tuple relational calculus:**

{ t.class_name | fitness_class(t) ∧ t.capacity > 20 }

**D4 için tuple relational calculus:**

{ m | member(m) ∧ ¬∃r (class_registration(r) ∧ r.member_id = m.member_id) }

## DISTINCT Açıklaması

İlişkisel cebirde sonuçlar küme mantığıyla değerlendirilir; tekrar eden satırlar bulunmaz. SQL ise bazı sorgularda tekrar eden satırlar döndürebilir. Bu nedenle gerektiğinde `DISTINCT` kullanılmalıdır.

D3 sorgusunda `UNION` tekrarları otomatik kaldırır. D2 sorgusunda aynı isimli farklı üyeler olabileceğinden kimlik alanlarıyla birlikte değerlendirme yapılmalıdır.

**Test durumu:** Yukarıdaki sonuçlar `seed.sql` verilerinden hesaplanan beklenen sonuçlardır. PostgreSQL ortamında henüz doğrulanmamıştır.
