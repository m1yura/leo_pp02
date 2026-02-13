-- Планирование текущего ремонта скважины (ТКРС)
INSERT INTO Workovers (well_id, start_date, reason, brigade_name, cost_estimate)
VALUES
    (1, '2026-02-20', 'Замена ЭЦН (наработка 450 суток)', 'Бригада ТКРС-5', 1200000.00),
    (3, '2026-03-01', 'Вывод из консервации', 'Бригада КРС-2', 3000000.00);

-- Просмотр плана ремонтов
SELECT
    w.well_number,
    wo.start_date,
    wo.reason,
    wo.brigade_name,
    wo.cost_estimate
FROM Workovers wo
JOIN Wells w ON wo.well_id = w.well_id
WHERE wo.start_date >= '2026-02-01'
ORDER BY wo.start_date;