# everytime init_db changed
# terminal:
# flask db migrate
# flask db upgrade

DROP DATABASE holiday_planner;
CREATE DATABASE IF NOT EXISTS holiday_planner;
USE holiday_planner;

-- drop existing tables if they exist to clear out
DROP TABLE IF EXISTS packing_items;
DROP TABLE IF EXISTS feedbacks;
DROP TABLE IF EXISTS user_plans;
DROP TABLE IF EXISTS plans;
DROP TABLE IF EXISTS users;

-- create tables
CREATE TABLE users
(
    id           INT AUTO_INCREMENT PRIMARY KEY,
    first_name   VARCHAR(50) NOT NULL,
    last_name    VARCHAR(50) NOT NULL,
    email        VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15) UNIQUE
);

CREATE TABLE plans
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    `name`      VARCHAR(50) NOT NULL,
    access_code VARCHAR(100) UNIQUE
);

CREATE TABLE user_plans
(
    id      INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    plan_id INT,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (plan_id) REFERENCES plans (id)
);

CREATE TABLE packing_items
(
    id      INT AUTO_INCREMENT PRIMARY KEY,
    `name`  VARCHAR(100) NOT NULL,
    plan_id INT,
    user_id INT,
    FOREIGN KEY (plan_id) REFERENCES plans (id)
);

CREATE TABLE itineraries
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    `name`          VARCHAR(100) NOT NULL,
    start_datetime  DATETIME,
    end_datetime    DATETIME,
    created_user_id INT,
    plan_id         INT,
    remark          TEXT,
    FOREIGN KEY (created_user_id) REFERENCES users (id),
    FOREIGN KEY (plan_id) REFERENCES plans (id)
);

CREATE TABLE feedbacks
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT,
    content     TEXT NOT NULL,
    create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

-- insert data
INSERT INTO users (first_name, last_name, email, phone_number)
VALUES ('John', 'Doe', 'john.doe@example.com', '1234567890'),
       ('Jane', 'Smith', 'jane.smith@example.com', '0987654321');

INSERT INTO plans (name, access_code)
VALUES ('Vacation to Hawaii', CONCAT(1, '%', FLOOR(RAND() * 10000000))),
       ('Business Trip to New York', CONCAT(2, '%', FLOOR(RAND() * 10000000)));

INSERT INTO user_plans (user_id, plan_id)
VALUES (1, 1),
       (1, 2),
       (2, 2);

INSERT INTO packing_items (name, plan_id, user_id)
VALUES ('Sunglasses', 1, 1),
       ('Business Suit', 2, NULL);

INSERT INTO itineraries (name, start_datetime, end_datetime, created_user_id, plan_id, remark)
VALUES
    ('Flight to Hawaii', '2024-06-01 08:00:00', '2024-06-01 12:00:00', 1, 1, 'Direct flight with breakfast included'),
    ('Hotel Check-in', '2024-06-01 14:00:00', '2024-06-01 15:00:00', 1, 1, 'Check-in at the Hilton Waikiki Beach'),
    ('Business Meeting', '2024-06-05 09:00:00', '2024-06-05 11:00:00', 2, 2, 'Meeting with the client at their office'),
    ('Dinner with Client', '2024-06-05 19:00:00', '2024-06-05 21:00:00', 2, 2, 'Dinner at the Rainbow Room');

INSERT INTO feedbacks (user_id, content)
VALUES (1, 'Great service! Very helpful.'),
       (2, 'The itinerary generation could be improved.');