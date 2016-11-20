USE tracker_db;
CREATE TABLE students (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
	last_name VARCHAR(100)
);
INSERT INTO students VALUES (DEFAULT, 'Tom', 'Harris');