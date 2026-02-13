-- Добавление суточных замеров по скважинам
INSERT INTO Measurements (well_id, oil_rate, liquid_rate, water_cut, wellhead_pressure)
VALUES
    (1, 145.2, 210.0, 30.8, 45.0),
    (2, 0.0, 0.0, 0.0, 0.0); -- скважина в ремонте

-- Отчет по скважинам с падением дебита более 20%
SELECT
    w.well_number,
    m.measurement_date,
    m.oil_rate,
    LAG(m.oil_rate) OVER (PARTITION BY w.well_id ORDER BY m.measurement_date) as prev_oil_rate,
    (1 - m.oil_rate / NULLIF(LAG(m.oil_rate) OVER (PARTITION BY w.well_id ORDER BY m.measurement_date), 0)) * 100 as drop_percent
FROM Measurements m
JOIN Wells w ON m.well_id = w.well_id
WHERE m.measurement_date >= DATEADD(day, -7, GETDATE())
    AND (1 - m.oil_rate / NULLIF(LAG(m.oil_rate) OVER (PARTITION BY w.well_id ORDER BY m.measurement_date), 0)) * 100 > 20;