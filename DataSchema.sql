-- Створення таблиці для опису навколишнього середовища
CREATE TABLE environments (
    environment_id SERIAL PRIMARY KEY,
    humidity INT NOT NULL CHECK (humidity BETWEEN 0 AND 100)
);

-- Створення таблиці користувачів
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    environment_id INT,
    CONSTRAINT fk_environment FOREIGN KEY (environment_id)
    REFERENCES environments (environment_id) ON DELETE SET NULL
);

-- Створення таблиці спортивних команд
CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT teams_name_format
    CHECK (team_name ~ '^[A-Za-z0-9 ]+$')
);

-- Створення таблиці спортивних подій
CREATE TABLE sports_events (
    event_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    event_date TIMESTAMP WITH TIME ZONE NOT NULL,
    result VARCHAR(50),
    event_status VARCHAR(20) NOT NULL,
    CONSTRAINT events_status_format
    CHECK (event_status ~ '^(Scheduled|Live|Finished)$')
);

-- Таблиця зв'язку "багато-до-багатьох" для учасників події
CREATE TABLE event_participants (
    event_id INT NOT NULL,
    team_id INT NOT NULL,
    PRIMARY KEY (event_id, team_id),
    CONSTRAINT fk_event_participants_event FOREIGN KEY (event_id)
    REFERENCES sports_events (event_id) ON DELETE CASCADE,
    CONSTRAINT fk_event_participants_team FOREIGN KEY (team_id)
    REFERENCES teams (team_id) ON DELETE CASCADE
);

-- Таблиця зв'язку "багато-до-багатьох" для переглянутих користувачем подій
CREATE TABLE user_viewed_events (
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    PRIMARY KEY (user_id, event_id),
    CONSTRAINT fk_user_viewed_user FOREIGN KEY (user_id)
    REFERENCES users (user_id) ON DELETE CASCADE,
    CONSTRAINT fk_user_viewed_event FOREIGN KEY (event_id)
    REFERENCES sports_events (event_id) ON DELETE CASCADE
);
