\# NULL Deneyi



\## Deney 1



Sorgu:

SELECT COUNT(\*), COUNT(phone) FROM customer;



Tahmin: 8 ve 5.



Sonuç: 8 ve 5.



Yorum: COUNT(\*) tüm satırları sayar.

COUNT(phone) ise NULL olmayan telefon

numaralarını sayar.



\## Deney 2



Sorgu:

SELECT AVG(age), SUM(age) / COUNT(\*) FROM customer;



Tahmin: 20.83 ve 15.



Sonuç: 20.8333333333333333 ve 15.



Yorum: AVG(age), NULL değerleri hesaba katmaz.

SUM(age) / COUNT(\*) ise tüm müşterilerin

sayısına böler ve tam sayı bölmesi yapar.

