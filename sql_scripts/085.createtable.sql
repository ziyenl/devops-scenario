USE tracker_db;
CREATE TABLE children (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
	last_name VARCHAR(100),
	age INT
);
INSERT INTO children VALUES (DEFAULT, 'James', 'Pink', 17);