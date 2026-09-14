-- ============================================================
-- Мир Косметика — Savdo dinamikasi tahlili (2025-2026)
-- PostgreSQL SQL so'rovlari to'plami
-- ============================================================

-- ---------- 1. Jadval yaratish ----------
CREATE TABLE Sales (
    id SERIAL PRIMARY KEY,
    oy INT NOT NULL,
    yil INT NOT NULL,
    kanal VARCHAR(25) NOT NULL,
    hajm NUMERIC(15,2) NOT NULL
);

-- ---------- 2. Ma'lumotlarni kiritish ----------
INSERT INTO Sales (oy, yil, kanal, hajm) VALUES
(1, 2025, 'Shahar', 114629675),
(1, 2025, 'Bozor', 172967875),
(1, 2025, 'Rayon', 54815350),
(2, 2025, 'Shahar', 108465625),
(2, 2025, 'Bozor', 148443175),
(2, 2025, 'Rayon', 41713850),
(3, 2025, 'Shahar', 173194650),
(3, 2025, 'Bozor', 190809400),
(3, 2025, 'Rayon', 50764000),
(4, 2025, 'Shahar', 130412600),
(4, 2025, 'Bozor', 179143750),
(4, 2025, 'Rayon', 63106850),
(5, 2025, 'Shahar', 160999500),
(5, 2025, 'Bozor', 156002050),
(5, 2025, 'Rayon', 69020075),
(6, 2025, 'Shahar', 129922700),
(6, 2025, 'Bozor', 179801625),
(6, 2025, 'Rayon', 70016850),
(1, 2026, 'Shahar', 81354725),
(1, 2026, 'Bozor', 103333475),
(1, 2026, 'Rayon', 40604950),
(2, 2026, 'Shahar', 118596100),
(2, 2026, 'Bozor', 102920925),
(2, 2026, 'Rayon', 25792750),
(3, 2026, 'Shahar', 115248075),
(3, 2026, 'Bozor', 98727300),
(3, 2026, 'Rayon', 49311975),
(4, 2026, 'Shahar', 164811400),
(4, 2026, 'Bozor', 174847950),
(4, 2026, 'Rayon', 96079175),
(5, 2026, 'Shahar', 110488100),
(5, 2026, 'Bozor', 185525025),
(5, 2026, 'Rayon', 98337225),
(6, 2026, 'Shahar', 126403200),
(6, 2026, 'Bozor', 145883525),
(6, 2026, 'Rayon', 97083125);

-- ---------- 3. Tekshirish ----------
SELECT * FROM Sales ORDER BY yil, oy, kanal;

-- ---------- 4. GROUP BY: yillik jami ----------
SELECT yil, SUM(hajm) AS jami_savdo
FROM Sales
GROUP BY yil
ORDER BY yil;

-- ---------- 5. Yillik o'sish foizi ----------
SELECT
    (MAX(CASE WHEN yil = 2026 THEN jami END) - MAX(CASE WHEN yil = 2025 THEN jami END))
    / MAX(CASE WHEN yil = 2025 THEN jami END) * 100 AS osish_foizi
FROM (
    SELECT yil, SUM(hajm) AS jami
    FROM Sales
    GROUP BY yil
) t;

-- ---------- 6. Kanal darajasidagi yillik jamlanma ----------
SELECT yil, kanal, SUM(hajm) AS jami_hajm
FROM Sales
GROUP BY yil, kanal
ORDER BY kanal, yil;

-- ---------- 7. Window function: LAG() — oydan-oyga o'zgarish foizi ----------
SELECT
    yil,
    oy,
    kanal,
    hajm,
    LAG(hajm) OVER (PARTITION BY kanal ORDER BY yil, oy) AS otgan_oy_hajm,
    ROUND(
        (hajm - LAG(hajm) OVER (PARTITION BY kanal ORDER BY yil, oy))
        / LAG(hajm) OVER (PARTITION BY kanal ORDER BY yil, oy) * 100,
        1
    ) AS osish_foizi
FROM Sales
ORDER BY kanal, yil, oy;

-- ---------- 8. Window function: SUM() OVER — oylik kanal ulushi ----------
SELECT
    yil,
    oy,
    kanal,
    hajm,
    SUM(hajm) OVER (PARTITION BY yil, oy) AS oy_jami,
    ROUND(hajm / SUM(hajm) OVER (PARTITION BY yil, oy) * 100, 1) AS ulush_foizi
FROM Sales
ORDER BY yil, oy, kanal;

-- ---------- 9. CTE: kanal bo'yicha yillik taqqoslash (pivot) ----------
WITH yillik_jami AS (
    SELECT
        yil,
        kanal,
        SUM(hajm) AS hajm_jami
    FROM Sales
    GROUP BY yil, kanal
)
SELECT
    kanal,
    MAX(CASE WHEN yil = 2025 THEN hajm_jami END) AS hajm_2025,
    MAX(CASE WHEN yil = 2026 THEN hajm_jami END) AS hajm_2026,
    ROUND(
        (MAX(CASE WHEN yil = 2026 THEN hajm_jami END) - MAX(CASE WHEN yil = 2025 THEN hajm_jami END))
        / MAX(CASE WHEN yil = 2025 THEN hajm_jami END) * 100,
        1
    ) AS osish_foizi
FROM yillik_jami
GROUP BY kanal
ORDER BY kanal;

-- ---------- 10. CTE + RANK(): har bir kanalning eng yaxshi oyi ----------
WITH reyting AS (
    SELECT
        yil,
        oy,
        kanal,
        hajm,
        RANK() OVER (PARTITION BY kanal ORDER BY hajm DESC) AS orin
    FROM Sales
)
SELECT yil, oy, kanal, hajm
FROM reyting
WHERE orin = 1
ORDER BY kanal;
