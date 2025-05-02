CREATE TABLE users (
    user_id BIGSERIAL PRIMARY KEY,
    username VARCHAR(32) NOT NULL UNIQUE
);

CREATE INDEX idx_users_username ON users (username);

CREATE TABLE sessions (
    session_id UUID PRIMARY KEY,
    user_id BIGSERIAL NOT NULL REFERENCES users(user_id)
);

CREATE INDEX idx_sessions_user_id ON sessions (user_id);

CREATE TYPE game_status_enum AS ENUM ('ongoing', 'draw', 'white', 'black');

CREATE TYPE player_enum AS ENUM ('white', 'black');

CREATE TABLE games (
    game_id UUID PRIMARY KEY,
    player_white BIGSERIAL NOT NULL REFERENCES users(user_id),
    player_black BIGSERIAL NOT NULL REFERENCES users(user_id),
    game_status game_status_enum NOT NULL
);

CREATE TABLE moves (
    game_id UUID REFERENCES games(game_id),
    move_number INT NOT NULL,
    move_notation VARCHAR(10) NOT NULL,
    player player_enum NOT NULL,
    move_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (game_id, move_number)
)