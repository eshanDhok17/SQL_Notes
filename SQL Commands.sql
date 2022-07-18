--Create db
-> CREATE DATABASE record_company;

--Drop db
-> DROP DATABASE record_company;

-- Use specific db
-> USE record_company;

-- Create Table
-> CREATE TABLE test (
	-- create columns
	id INT NOT NULL AUTO_INCREMENT, -- id must be not null and must increment everytime entered, also saves us a line if we want to add more id's.
	test_column INT NOT NULL, -- If we dont want value to be null
	PRIMARY KEY (id) --makes this primary key
);

CREATE TABLE ablums (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	release_year INT,
	band_id INT NOT NULL,
	PRIMARY KEY (id), -- primary key
	FOREIGN KEY (band_id) REFERENCES bands(id)  --foreign key for bands (any kind of key which references other table, other than itself)
)

--Change a existing table
->	ALTER TABLE test
	ADD another_column VARCHAR(255);

-- Drop table
-> DROP TABLE test;

-- Insert into specific table/ supply different values
	-- 1 value
->  INSERT INTO bands (name) -- Id column automatically generates itself due to AUTO_INCREMENT
	VALUES ('Iron Maiden');

	-- Multiple values
->  VALUES ('Deuce'), ('Avenged Sevenfold'), ('Linkin Park');

-- Select Command for quering
-> SELECT * FROM bands; -- selects every tuple inside band
-> SELECT * FROM bands LIMIT 2; -- columns limited to 2
-> SELECT name FROM bands; --only name column

-- Rename column titles
-> SELECT id AS 'ID', name AS 'Band Name' FROM bands;

-- Order by "value"
-> SELECT * FROM bands ORDER BY name DESC; -- everything from bands is ordered by "name" to descending order, Default is Ascending

-- Distint select
->  INSERT INTO albums (name, release_year, band_id)
	VALUES ('The number of beasts', 1981, 1),
	       ('Power Slave', 1984, 1),
	       ('Nightmare', 2018, 2),
	       ('Nightmare', 2013, 2),
	       ('Test Album', NULL, 3);

SELECT * FROM albums; --Select all elements, not unique too
SELECT DISTINT name FROM albums; -- Select/ Shows only unique elements

-- Update table
->  UPDATE albums
	SET release_year = 1982 -- updates year of all elements
	-- additional for distintion
	where id = 1; -- updates only the tuple with id 1

-- Select based on conditionals
->	SELECT * FROM albums
	WHERE release_year < 2000;

-- Select based on wildcards or certain parts of string, ex- string = 'eshan', therefore, if searched for 'sha', tuple with name 'eshan' will get displayed.
->	SELECT * FROM albums
	WHERE name LIKE  '%er%' or band_id = 2; -- % signifies any charecters before/ after, or means either of two gets selected

-- To filter between two different values
->  SELECT * FROM albums
	WHERE release_year BETWEEN 2000 AND 2018;

--  Filter for things which are NULL and remove them (Undesired)
->  SELECT * FROM albums
	WHERE release_year IS NULL;

-- Delete specific thing
-> DELETE FROM albums WHERE id = 5;

-- Join two different tables
->  SELECT * FROM bands
	JOIN albums ON bands.id = albums.band_id;

-- Relational Databases
-- Inner/ Outer/ Left/ Right Join
-- Inner join (Basically default join)
->  SELECT * FROM bands
	INNER JOIN albums ON bands.id = albums.band_id;

-- Left join (list everything from left table even if it's not present on left side, and then other things present on right side)
->  SELECT * FROM bands
	LEFT JOIN albums ON bands.id = albums.band_id;

-- Right join (Same as Left Join But Flipped)
->  SELECT * FROM bands
	RIGHT JOIN albums ON bands.id = albums.band_id;

-- Outer join (list everything from left table even if it's not present)
->

-- Aggregate Functions
-- Average
->  SELECT AVG(release_year) FROM albums; -- returning average value of release_year and return a tuple

-- Sum
->  SELECT SUM(release_year) FROM albums; -- Returns sum of all tuples in release_year

-- Count
->  SELECT band_id, COUNT(release_year) FROM albums
	GROUP BY band_id; --groups by band id and returns count of band_id(how many times it comes in table)

-- To know which band this table represents, we use joins
->  SELECT b.name AS band_name, COUNT(a.id) AS num_albums
	FROM bands AS b
	LEFT JOIN albums AS a ON b.id = a.band_id
	GROUP BY b.id;
 
 -- Normal version
 -> SELECT band_name.name, COUNT(num_albums.id)
	LEFT JOIN albums ON bands.id = num_albums.band_id
	GROUP BY band_name.id;

-- What if we want to filter by Aggregate? (return bands (Only deuce here, if that statement is included) who have only 1 single albums)
->  SELECT band_name.name, COUNT(num_albums.id)
	LEFT JOIN albums ON bands.id = num_albums.band_id
	WHERE b.name = 'Deuce'
	GROUP BY band_name.id
	HAVING num_albums = 1;
