-- Установка нового ЭЦН в скважину
INSERT INTO Equipment (equipment_type, model, well_id, installation_date, status)
VALUES
    ('ЭЦН', 'ЭЦН-50-1800', 1, '2026-02-15', 'работает'),
    ('ШГН', 'ШГН-8-3-550', 2, '2026-01-10', 'работает');

-- Обновление наработки (например, +24 часа)
UPDATE Equipment
SET running_hours = running_hours + 24
WHERE equipment_id = 1;

-- Проверка
SELECT * FROM Equipment;