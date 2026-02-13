-- Создание базы данных
CREATE DATABASE OilGasManagement;
GO

USE OilGasManagement;

-- Справочник пластов
CREATE TABLE Formations (
    formation_id INT PRIMARY KEY IDENTITY(1,1),
    formation_name NVARCHAR(100) NOT NULL,
    depth_from FLOAT,
    depth_to FLOAT,
    oil_saturation FLOAT
);

-- Скважины
CREATE TABLE Wells (
    well_id INT PRIMARY KEY IDENTITY(1,1),
    well_number NVARCHAR(20) UNIQUE NOT NULL,
    formation_id INT FOREIGN KEY REFERENCES Formations(formation_id),
    status NVARCHAR(50) CHECK (status IN ('бурение', 'эксплуатация', 'ремонт', 'консервация', 'ликвидация')),
    commission_date DATE,
    target_oil_rate FLOAT
);

-- Оборудование (ЭЦН, ШГН, и т.д.)
CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY IDENTITY(1,1),
    equipment_type NVARCHAR(50) CHECK (equipment_type IN ('ЭЦН', 'ШГН', 'компрессор', 'сепаратор')),
    model NVARCHAR(100),
    well_id INT FOREIGN KEY REFERENCES Wells(well_id),
    installation_date DATE,
    running_hours INT DEFAULT 0,
    status NVARCHAR(50) CHECK (status IN ('работает', 'простой', 'ремонт', 'списано'))
);

-- Замеры (дебиты)
CREATE TABLE Measurements (
    measurement_id INT PRIMARY KEY IDENTITY(1,1),
    well_id INT FOREIGN KEY REFERENCES Wells(well_id),
    measurement_date DATETIME DEFAULT GETDATE(),
    oil_rate FLOAT, -- тонн/сутки
    liquid_rate FLOAT, -- м3/сутки
    water_cut FLOAT, -- обводненность %
    wellhead_pressure FLOAT -- давление на устье, атм
);

-- Ремонты (ТКРС/КРС)
CREATE TABLE Workovers (
    workover_id INT PRIMARY KEY IDENTITY(1,1),
    well_id INT FOREIGN KEY REFERENCES Wells(well_id),
    start_date DATE,
    end_date DATE,
    reason NVARCHAR(255),
    brigade_name NVARCHAR(100),
    cost_estimate FLOAT
);

-- Инциденты (отказы, остановки, аварии)
CREATE TABLE Incidents (
    incident_id INT PRIMARY KEY IDENTITY(1,1),
    well_id INT FOREIGN KEY REFERENCES Wells(well_id),
    incident_type NVARCHAR(50) CHECK (incident_type IN ('отказ ЭЦН', 'остановка', 'разгерметизация', 'загазованность')),
    incident_date DATETIME,
    description NVARCHAR(MAX),
    downtime_hours INT
);

-- Списание материалов (на ремонт/обслуживание)
CREATE TABLE MaterialWriteOffs (
    write_off_id INT PRIMARY KEY IDENTITY(1,1),
    workover_id INT FOREIGN KEY REFERENCES Workovers(workover_id),
    material_name NVARCHAR(200),
    quantity INT,
    unit NVARCHAR(20),
    write_off_date DATE DEFAULT GETDATE()
);