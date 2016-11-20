USE tracker_db;
CREATE TABLE customers (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
	last_name VARCHAR(100)
);
INSERT INTO customers VALUES (DEFAULT, 'John', 'Smith');