-- 1. Vytvoření databáze pro projekt
CREATE DATABASE football_analytics;

-- 1. Tabulka soutěží
CREATE TABLE competitions (
    competition_id VARCHAR(10) PRIMARY KEY,
    competition_code VARCHAR(50),
    name VARCHAR(100),
    sub_type VARCHAR(50),
    type VARCHAR(50),
    country_id INT,
    country_name VARCHAR(100),
    domestic_league_code VARCHAR(10),
    confederation VARCHAR(50),
    url VARCHAR(255),
    is_major_national_league BOOLEAN
);

-- 2. Tabulka klubů
CREATE TABLE clubs (
    club_id INT PRIMARY KEY,
    club_code VARCHAR(100),
    name VARCHAR(100),
    domestic_competition_id VARCHAR(10),
    total_market_value NUMERIC,
    squad_size INT,
    average_age NUMERIC,
    foreigners_number INT,
    foreigners_percentage NUMERIC,
    national_team_players INT,
    stadium_name VARCHAR(100),
    stadium_seats INT,
    net_transfer_record VARCHAR(100),
    coach_name VARCHAR(100),
    last_season INT,
    filename VARCHAR(255),
    url VARCHAR(255)
);

-- 3. Tabulka hráčů
CREATE TABLE players (
    player_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    name VARCHAR(255),
    last_season INT,
    current_club_id INT,
    player_code VARCHAR(255),
    country_of_birth VARCHAR(255),
    city_of_birth VARCHAR(255),
    country_of_citizenship VARCHAR(255),
    date_of_birth TEXT, -- Změněno na TEXT kvůli různorodým formatům data
    sub_position VARCHAR(100),
    position VARCHAR(100),
    foot VARCHAR(50),
    height_in_cm INT,
    contract_expiration_date TEXT,
    agent_name VARCHAR(255),
    image_url TEXT,
    url TEXT,
    current_club_domestic_competition_id VARCHAR(50),
    current_club_name VARCHAR(255),
    market_value_in_eur NUMERIC,
    highest_market_value_in_eur NUMERIC
);

-- 4. Tabulka zápasů
CREATE TABLE games (
    game_id INT PRIMARY KEY,
    competition_id VARCHAR(50),
    season INT,
    round VARCHAR(50),
    date TEXT,
    home_club_id INT,
    away_club_id INT,
    home_club_goals INT,
    away_club_goals INT,
    home_club_position INT,
    away_club_position INT,
    home_club_manager_name VARCHAR(255),
    away_club_manager_name VARCHAR(255),
    stadium VARCHAR(255),
    attendance INT,
    referee VARCHAR(255),
    url TEXT,
    home_club_formation VARCHAR(100),
    away_club_formation VARCHAR(100),
    home_club_name VARCHAR(255),
    away_club_name VARCHAR(255),
    aggregate VARCHAR(50),
    competition_type VARCHAR(100)
);

-- 5. Tabulka výstupů/statistik hráčů v zápasech (Appearances)
CREATE TABLE appearances (
    appearance_id VARCHAR(50) PRIMARY KEY,
    game_id INT,
    player_id INT,
    player_club_id INT,
    player_current_club_id INT,
    date DATE,
    player_name VARCHAR(150),
    competition_id VARCHAR(10),
    yellow_cards INT,
    red_cards INT,
    goals INT,
    assists INT,
    minutes_played INT
);