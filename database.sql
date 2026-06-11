CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    team_name VARCHAR(100),
    budget BIGINT DEFAULT 10000000,
    reputation INT DEFAULT 10,
    factory_level INT DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    name VARCHAR(100),
    role VARCHAR(50),
    skill INT,
    salary BIGINT,
    morale INT DEFAULT 70,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE drivers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    name VARCHAR(100),
    speed INT,
    consistency INT,
    rain_skill INT,
    experience INT,
    salary BIGINT,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE engines (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    power_hp INT,
    reliability INT,
    price BIGINT
);

CREATE TABLE cars (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    engine_id INT,
    name VARCHAR(100),
    reliability INT DEFAULT 70,
    condition_percent INT DEFAULT 100,
    FOREIGN KEY (team_id) REFERENCES teams(id),
    FOREIGN KEY (engine_id) REFERENCES engines(id)
);

CREATE TABLE components (
    id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT,
    component_name VARCHAR(100),
    durability INT DEFAULT 100,
    condition_percent INT DEFAULT 100,
    replacement_cost BIGINT,
    FOREIGN KEY (car_id) REFERENCES cars(id)
);

CREATE TABLE tyres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    tyre_type VARCHAR(20),
    quantity INT,
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
    litres INT,
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
    level INT DEFAULT 1,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE trucks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    name VARCHAR(100),
    condition_percent INT DEFAULT 100,
    speed_rating INT DEFAULT 50,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE weather (
    id INT AUTO_INCREMENT PRIMARY KEY,
    race_id INT,
    condition_name VARCHAR(50),
    temperature INT
);

CREATE TABLE races (
    id INT AUTO_INCREMENT PRIMARY KEY,
    race_name VARCHAR(100),
    country VARCHAR(100),
    race_order INT
);

CREATE TABLE race_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    race_id INT,
    team_id INT,
    position_finish INT,
    points INT,
    prize_money BIGINT
);

CREATE TABLE standings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    points INT DEFAULT 0,
    wins INT DEFAULT 0
);

CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT,
    event_title VARCHAR(255),
    event_description TEXT,
    event_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
