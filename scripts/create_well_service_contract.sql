-- Таблица договоров на сервисное обслуживание
CREATE TABLE ServiceContracts (
    contract_id INT PRIMARY KEY IDENTITY(1,1),
    well_id INT FOREIGN KEY REFERENCES Wells(well_id),
    contractor_name NVARCHAR(200),
    contract_number NVARCHAR(50),
    start_date DATE,
    end_date DATE,
    contract_value FLOAT,
    status NVARCHAR(50) CHECK (status IN ('действует', 'завершен', 'расторгнут'))
);

-- Добавление нового договора
INSERT INTO ServiceContracts (well_id, contractor_name, contract_number, start_date, end_date, contract_value, status)
VALUES
    (1, 'ООО "Нефтесервис"', 'Д-2026/01', '2026-01-01', '2026-12-31', 2500000.00, 'действует'),
    (2, 'АО "Бурнефть"', 'Д-2026/02', '2026-02-01', '2026-08-01', 5000000.00, 'действует');