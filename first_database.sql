CREATE DATABASE record_music; /* creating a database */
USE record_music;
CREATE table artists(  /* creating a table */
	id INT NOT NULL auto_increment, 
	name VARCHAR (255) NOT NULL,
    PRIMARY KEY(id)  /* creating a primary key */
);
CREATE TABLE music_projects(
	id INT NOT NULL auto_increment,
    name VARCHAR(255) NOT NULL,
    release_year INT,
    artist_id INT NOT NULL, 
    PRIMARY KEY (id), FOREIGN KEY(artist_id) REFERENCES artists(id) /* creating a foreign key */
);


INSERT INTO artists (name)   /* inserting data */
VALUES ('Future');
INSERT INTO artists (name)      /* inserting data multiple */
VALUES ('The Weeknd'), ('NBA YoungBoy'), ('Lil Baby'), ('Drake'),('Young Thug');
SELECT * FROM artists;  /* selecting data */

SELECT * FROM artists LIMIT 3; /* selecting data w/ limits */

SELECT name FROM artists;  /* selecting data from a specific column */

SELECT id as 'ID', name as 'Artists' from artists; /* changing a column name can do multiple times */

SELECT * FROM Artists ORDER BY name; /* order by whatever in column in auto it will be asc  */

SELECT * FROM Artists ORDER BY name DESC; /* order by whatever in column DESC  */

INSERT INTO music_projects (name, release_year, artist_id)  /* inserting data from music proj to artist (can do mult times) */
VALUES ('After Hours', 2020, 2),
       ('DS2', 2015, 1),
       ('Top', 2020, 3),
       ('Take Care', 2011,5),
       ('Drip Harder',2018, 4),
       ('Monster', 2014, 1),
       ('Until Death Calls My Name', 2018, 3),
       ('Trilogy',2012 ,2),
       ('What A Time To Be Alive',2015,1),
       ('What A Time To Be Alive',2015,5),
       ('Certified Lover Boy', NULL, 5);    /* NULL is if there is no release date*/
       
SELECT * FROM music_projects;         /* select and shows all projects*/

SELECT DISTINCT name FROM music_projects; /* gets ALL DIFFERENT names of the projects */

UPDATE music_projects /*To update information in a table*/
set name = 'Until Death Call My Name' 
WHERE id = 7;   /*where statement*/

SELECT * FROM music_projects    /*Using where to get information*/
WHERE  release_year > 2017;

SELECT * FROM music_projects /*using where to find characters*/
WHERE name LIKE '%a%';

SELECT * FROM music_projects /* using OR in a where statement*/
WHERE name LIKE '%a%' or release_year < 2020;

SELECT * FROM music_projects /* using AND in a where statement*/
WHERE name LIKE '%a%' AND release_year < 2020;

SELECT * FROM music_projects /* using BETWEEN in a where statement*/
WHERE release_year BETWEEN 2015 AND 2017;

SELECT * FROM music_projects /* using IS NULL in a where statement*/
WHERE release_year IS NULL;

DELETE FROM music_projects /* to delete a row of data*/
WHERE id = 11;

DELETE FROM artists
WHERE id = 9;

SELECT * FROM artists /* to do a simple join from table to table*/
INNER JOIN music_projects ON artists.id = music_projects.artist_id; /*Inner Join is default setting*/

SELECT * FROM artists /* to do a simple left join from table to table*/
LEFT JOIN music_projects ON artists.id = music_projects.artist_id; /*shows everything on the left side(artist) even if null on right (young thug)*/

SELECT * FROM music_projects /* to do a simple left join from table to table (not used as often)*/
RIGHT JOIN artists ON artists.id = music_projects.artist_id; /*shows everything on the right side(artists) even if null(young thug)*/

SELECT AVG(release_year) FROM music_projects; /*aggregate function using average, sum, count etc..*/

SELECT artist_id, COUNT(artist_id) FROM music_projects /* group by method*/
GROUP BY  artist_id; /* used to check how many prject per artist is in terminal*/

SELECT a.name AS artist_name, count(m.id) as num_of_projects /*how to count how many project each artists have*/
FROM artists as a
LEFT JOIN music_projects as m ON a.id = m.artist_id /*left join from artists to music projects*/
/* WHERE m.id IS NOT NULL */   /*to filter out artist with no album in database*/
WHERE a.name = 'The Weeknd'
GROUP BY a.id /*group by the artists*/
HAVING num_of_projects = 2; /*using having to get a specific amount of projects*/

