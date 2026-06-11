-- =====================================================
-- FORMULA TEAM MANAGER 1970 - DATABASE V3
-- =====================================================

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    team_name VARCHAR(100) NOT NULL,
    country VARCHAR(100),
    budget BIGINT DEFAULT 10000000,
    reputation INT DEFAULT 10,
    factory_level INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE factories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    factory_name VARCHAR(100),
    level INT DEFAULT 1,
    production_level INT DEFAULT 1,
    research_level INT DEFAULT 1,
    warehouse_level INT DEFAULT 1,
    condition_percent INT DEFAULT 100,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    name VARCHAR(100),
    role VARCHAR(50),
    skill INT DEFAULT 50,
    morale INT DEFAULT 70,
    salary BIGINT DEFAULT 50000,
    contract_months INT DEFAULT 12,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE drivers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    name VARCHAR(100),
    age INT,
    nationality VARCHAR(100),
    speed INT DEFAULT 50,
    consistency INT DEFAULT 50,
    rain_skill INT DEFAULT 50,
    development_skill INT DEFAULT 50,
    experience INT DEFAULT 50,
    salary BIGINT DEFAULT 100000,
    contract_months INT DEFAULT 12,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE engines (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    manufacturer VARCHAR(100),
    horsepower INT,
    reliability INT,
    fuel_consumption DECIMAL(6,2),
    price BIGINT
);

CREATE TABLE cars (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    engine_id INT,
    car_name VARCHAR(100),
    chassis_rating INT DEFAULT 50,
    aerodynamics_rating INT DEFAULT 50,
    reliability INT DEFAULT 70,
    condition_percent INT DEFAULT 100,
    FOREIGN KEY (team_id) REFERENCES teams(id),
    FOREIGN KEY (engine_id) REFERENCES engines(id)
);

CREATE TABLE car_parts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT,
    part_name VARCHAR(100),
    wear_percent INT DEFAULT 0,
    durability INT DEFAULT 100,
    replacement_cost BIGINT,
    FOREIGN KEY (car_id) REFERENCES cars(id)
);

CREATE TABLE inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    item_name VARCHAR(100),
    quantity INT DEFAULT 0,
    purchase_price BIGINT DEFAULT 0,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE tyres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    tyre_type VARCHAR(20),
    quantity INT DEFAULT 0,
    price_per_set BIGINT,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE fuel_market (
    id INT AUTO_INCREMENT PRIMARY KEY,
    current_price DECIMAL(10,2),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fuel_inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    litres INT DEFAULT 0,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE fuel_orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    litres INT,
    price_per_litre DECIMAL(10,2),
    total_cost BIGINT,
    order_date DATETIME,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE sponsors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    sponsor_name VARCHAR(100),
    payment BIGINT,
    contract_months INT,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE offices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    city VARCHAR(100),
    country VARCHAR(100),
    level INT DEFAULT 1,
    monthly_cost BIGINT,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE trucks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    truck_name VARCHAR(100),
    condition_percent INT DEFAULT 100,
    speed_rating INT DEFAULT 50,
    fuel_capacity INT DEFAULT 500,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE shipments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    truck_id INT,
    origin_city VARCHAR(100),
    destination_city VARCHAR(100),
    departure_date DATE,
    arrival_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (team_id) REFERENCES teams(id),
    FOREIGN KEY (truck_id) REFERENCES trucks(id)
);

CREATE TABLE races (
    id INT AUTO_INCREMENT PRIMARY KEY,
    race_name VARCHAR(100),
    circuit_name VARCHAR(100),
    country VARCHAR(100),
    race_order INT
);

CREATE TABLE weather_forecasts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    race_id INT,
    weather_type VARCHAR(50),
    temperature INT,
    rain_probability INT,
    FOREIGN KEY (race_id) REFERENCES races(id)
);

CREATE TABLE race_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    race_id INT,
    team_id INT,
    driver_id INT,
    finish_position INT,
    points INT,
    prize_money BIGINT,
    FOREIGN KEY (race_id) REFERENCES races(id),
    FOREIGN KEY (team_id) REFERENCES teams(id),
    FOREIGN KEY (driver_id) REFERENCES drivers(id)
);

CREATE TABLE standings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    points INT DEFAULT 0,
    wins INT DEFAULT 0,
    podiums INT DEFAULT 0,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE research_projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    project_name VARCHAR(100),
    progress_percent INT DEFAULT 0,
    cost BIGINT,
    completed TINYINT DEFAULT 0,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE random_events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    cost BIGINT,
    reputation_change INT
);

CREATE TABLE finances (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    transaction_type VARCHAR(50),
    description VARCHAR(255),
    amount BIGINT,
    transaction_date DATETIME,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE seasons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    season_year INT UNIQUE
);
INSERT INTO engines
(name,manufacturer,horsepower,reliability,fuel_consumption,price)
VALUES
('Ford Cosworth DFV','Ford',485,80,2.10,800000),
('Ferrari Flat-12','Ferrari',500,70,2.50,1200000),
('Alfa Romeo Flat-12','Alfa Romeo',510,65,2.70,1400000),
('Matra V12','Matra',495,75,2.30,1100000);
INSERT INTO fuel_market(current_price)
VALUES (1.20);
INSERT INTO races
(race_name,circuit_name,country,race_order)
VALUES
('South African Grand Prix','Kyalami','South Africa',1),
('Spanish Grand Prix','Jarama','Spain',2),
('Monaco Grand Prix','Monaco','Monaco',3),
('Belgian Grand Prix','Spa-Francorchamps','Belgium',4),
('Dutch Grand Prix','Zandvoort','Netherlands',5),
('French Grand Prix','Clermont-Ferrand','France',6),
('British Grand Prix','Brands Hatch','United Kingdom',7),
('German Grand Prix','Nurburgring','Germany',8),
('Austrian Grand Prix','Osterreichring','Austria',9),
('Italian Grand Prix','Monza','Italy',10),
('Canadian Grand Prix','Mont-Tremblant','Canada',11),
('United States Grand Prix','Watkins Glen','USA',12),
('Mexican Grand Prix','Magdalena Mixhuca','Mexico',13);
INSERT INTO random_events
(title,description,cost,reputation_change)
VALUES
('Sciopero in fabbrica','Produzione bloccata per 7 giorni',50000,-5),
('Incendio in fabbrica','Danni alla struttura',250000,-10),
('Guasto camion','Trasporto ritardato',15000,-2),
('Nuovo sponsor','Nuovo contratto commerciale',-500000,10),
('Nuovo regolamento FIA','Aggiornamento obbligatorio vettura',100000,-1);
