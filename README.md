# Savdo dinamikasi tahlili va vizualizatsiyasi (2025-2026)

"Мир Косметика" kosmetika savdo tarmog'ining 2025 va 2026-yillarning birinchi yarim yilligidagi savdo ko'rsatkichlarini uchta savdo kanali (Shahar, Bozor, Rayon) bo'yicha tahlil qiluvchi to'liq ma'lumotlar tahlili loyihasi.

## Loyiha yo'li

```
Excel  →  Python (pandas, matplotlib)  →  SQL (PostgreSQL)  →  Tableau
```

Bitta ma'lumot to'plami to'rtta turli vosita orqali bosqichma-bosqich chuqurlashtirilgan tahlildan o'tkazildi — har bir bosqichda oldingi natijalar tasdiqlandi va yangi topilmalar qo'shildi.

## Asosiy natijalar

| Kanal | 2025 (so'm) | 2026 (so'm) | O'zgarish |
|---|---|---|---|
| Shahar | 817 624 750 | 716 901 600 | -12,3% |
| Bozor | 1 027 167 875 | 811 238 200 | -21,0% |
| Rayon | 349 436 975 | 407 209 200 | +16,5% |
| **Jami** | **2 194 229 600** | **1 935 349 000** | **-11,8%** |

**Asosiy xulosa:** pasayish umumiy emas — bu Bozor kanalidagi keskin tushish (-21%) butun natijani pastga tortmoqda. Rayon esa yagona o'sayotgan kanal.

SQL orqali o'tkazilgan chuqur tahlil (window function) qo'shimcha ravishda quyidagilarni aniqladi:
- Bozor kanalida 2026-yil aprel oyida +77,1% keskin sakrash
- Rayon kanalida 2026-yil mart-aprel oylarida +91,2% va +94,8% o'sish
- Shahar va Bozor hali 2025-yil martidagi rekordga yeta olmagan, Rayon esa 2026-yil mayida yangi rekord o'rnatgan

## Repository tarkibi

| Fayl | Tavsif |
|---|---|
| `data.csv` | Xom ma'lumot (long format: oy, yil, kanal, hajm) |
| `analysis.py` | Python (pandas, matplotlib) tahlil skripti |
| `queries.sql` | PostgreSQL so'rovlari (GROUP BY, LAG, SUM OVER, CTE, RANK) |
| `Loyiha_Hisoboti.docx` | To'liq yozma hisobot (Kirish, nazariy asos, amaliy qism, xulosa) |
| `mir_kosmetika_yakuniy_taqdimot.pptx` | Yakuniy taqdimot (10 slayd) |

## Ishlatilgan vositalar

- **Excel** — ma'lumotni boshlang'ich saqlash va formatlash
- **Python 3** (pandas, matplotlib) — Google Colab muhitida tezkor tahlil
- **PostgreSQL** — TablePlus orqali chuqur tahlil (window function, CTE)
- **Tableau Desktop** — interaktiv dashboard va vizualizatsiya

## Qanday ishga tushirish mumkin

```bash
pip install -r requirements.txt
python analysis.py
```

## Muallif

Gavhar Toshturdiyeva — Data Analytics loyihasi, 2026
