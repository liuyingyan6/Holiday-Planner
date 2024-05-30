CREATE DATABASE IF NOT EXISTS holiday_planner;
USE holiday_planner;

-- drop existing tables if they exist to clear out
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS plans;
DROP TABLE IF EXISTS user_plans;
DROP TABLE IF EXISTS packing_items;
DROP TABLE IF EXISTS feedbacks;

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
    id     INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL
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

INSERT INTO plans (name)
VALUES ('Vacation to Hawaii'),
       ('Business Trip to New York');

INSERT INTO user_plans (user_id, plan_id)
VALUES (1, 1),
       (1, 2),
       (2, 2);

INSERT INTO packing_items (name, plan_id, user_id)
VALUES ('Sunglasses', 1, 1),
       ('Business Suit', 2, NULL);

INSERT INTO feedbacks (user_id, content)
VALUES (1, 'Great service! Very helpful.'),
       (2, 'The itinerary generation could be improved.');