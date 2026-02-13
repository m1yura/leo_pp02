-- Добавление новой скважины в эксплуатацию
INSERT INTO Wells (well_number, formation_id, status, commission_date, target_oil_rate)
VALUES
    ('Скв-1010', 1, 'эксплуатация', '2026-01-15', 150.5),
    ('Скв-1011', 2, 'бурение', NULL, 200.0),
    ('Скв-1012', 1, 'консервация', NULL, NULL);

-- Проверка
SELECT * FROM Wells;