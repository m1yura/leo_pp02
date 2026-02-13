-- Списание материалов при ремонте скважины
INSERT INTO MaterialWriteOffs (workover_id, material_name, quantity, unit)
VALUES
    (1, 'Насос ЭЦН-50', 1, 'шт'),
    (1, 'Кабель КПБП-3х16', 120, 'м'),
    (1, 'Масло гидравлическое', 50, 'л');

-- Отчет по списаниям за месяц
SELECT
    w.well_number,
    wo.start_date,
    wo.reason,
    mw.material_name,
    mw.quantity,
    mw.unit,
    mw.write_off_date
FROM MaterialWriteOffs mw
JOIN Workovers wo ON mw.workover_id = wo.workover_id
JOIN Wells w ON wo.well_id = w.well_id
WHERE mw.write_off_date >= '2026-02-01'
ORDER BY mw.write_off_date;