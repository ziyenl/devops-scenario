CREATE DATABASE tracker_db;
USE tracker_db;
CREATE TABLE versioning (
	version integer not null default 0
);
INSERT INTO versioning VALUES (DEFAULT);
