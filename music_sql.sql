CREATE database music_ratings;
USE music_ratings;
CREATE TABLE artist(
	artist_id INT NOT NULL AUTO_INCREMENT,
	artist_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (artist_id)
);

CREATE TABLE album(
	album_id INT NOT NULL AUTO_INCREMENT,
    album_name VARCHAR(100) NOT NULL,
   -- album_length INT NOT NULL,--
    album_year INT NOT NULL CHECK(album_year between 1900 AND 2099),
    artist_id INT NOT NULL, 
    PRIMARY KEY (album_id),
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);
ALTER TABLE album DROP COLUMN album_length;
CREATE TABLE rating(
	rating VARCHAR(1),
    rating_description VARCHAR(1000),
    PRIMARY KEY (rating)
);

CREATE TABLE song(
	song_id INT NOT NULL AUTO_INCREMENT,
    album_id INT,
    artist_id INT NOT NULL,
    song_name VARCHAR(50) NOT NULL,
    song_length FLOAT NOT NULL,
	song_rating VARCHAR(1) NOT NULL,
    song_feature_artist VARCHAR(150),
    number_of_plays INT NOT NULL,
    PRIMARY KEY(song_id), 
    FOREIGN KEY (album_id) REFERENCES album(album_id),
    FOREIGN KEY (song_rating) REFERENCES rating(rating),
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);
SELECT * FROM rating;
INSERT INTO rating(rating,rating_description) VALUES('S','This song is extremely good, replay value is high, one of the best songs from this artist/artists');
INSERT INTO rating(rating,rating_description) VALUES('A','This song is good, replay value is high, one of the more better songs from this artist/artists');
INSERT INTO rating(rating,rating_description) VALUES('C','This song is listenable, replay value is not too high, its above average songs from this artist/artists');
INSERT INTO rating(rating,rating_description) VALUES('D','This song is average, replay value is low, its average level songs from this artist/artists');
INSERT INTO rating(rating,rating_description) VALUES('W','This song is extremely trash, replay value is none, one of the worst songs from this artist/artists');

SELECT * FROM artist;
INSERT INTO artist(artist_name) VALUES('The Weeknd');
INSERT INTO artist(artist_name) VALUES('Future');
INSERT INTO artist(artist_name) VALUES('YoungBoy Never Broke Again');
INSERT INTO artist(artist_name) VALUES('Drake');
INSERT INTO artist(artist_name) VALUES('Young Thug');
INSERT INTO artist(artist_name) VALUES('Juice WRLD');
INSERT INTO artist(artist_name) VALUES('A$AP Ferg');
INSERT INTO artist(artist_name) VALUES('A$AP Rocky');
INSERT INTO artist(artist_name) VALUES('Ace Hood');
INSERT INTO artist(artist_name) VALUES('Adele');
INSERT INTO artist(artist_name) VALUES('Akon');
INSERT INTO artist(artist_name) VALUES('Aloe Blacc');
INSERT INTO artist(artist_name) VALUES('Ariana Grande');
INSERT INTO artist(artist_name) VALUES('Social House');
INSERT INTO artist(artist_name) VALUES('Arizona Zervas');
INSERT INTO artist(artist_name) VALUES('August Alsina');
INSERT INTO artist(artist_name) VALUES('B.o.B');
INSERT INTO artist(artist_name) VALUES('Baby Keem');
INSERT INTO artist(artist_name) VALUES('Kendrick Lamar');
INSERT INTO artist(artist_name) VALUES('Travis Scott');
INSERT INTO artist(artist_name) VALUES('Bad Bunny');
INSERT INTO artist(artist_name) VALUES('Bebe Rexha');
INSERT INTO artist(artist_name) VALUES('Becky G.');
INSERT INTO artist(artist_name) VALUES('Belly');
INSERT INTO artist(artist_name) VALUES('Big Sean');
INSERT INTO artist(artist_name) VALUES('Hit-Boy');
INSERT INTO artist(artist_name) VALUES('Metro Boomin');
INSERT INTO artist(artist_name) VALUES('BlocBoy JB');
INSERT INTO artist(artist_name) VALUES('Blueface');
INSERT INTO artist(artist_name) VALUES('OG Bobby Billions');
INSERT INTO artist(artist_name) VALUES('Bobby Shmurda');
INSERT INTO artist(artist_name) VALUES('A Boogie wit da Hoodie');
INSERT INTO artist(artist_name) VALUES('Brent Faiyaz');
INSERT INTO artist(artist_name) VALUES('Bruno Mars');
INSERT INTO artist(artist_name) VALUES('Anderson .Paak');
INSERT INTO artist(artist_name) VALUES('Bryson Tiller');
INSERT INTO artist(artist_name) VALUES('Calboy');
INSERT INTO artist(artist_name) VALUES('Calvin Harris');
INSERT INTO artist(artist_name) VALUES('Dua Lipa');
INSERT INTO artist(artist_name) VALUES('Camila Cabello');
INSERT INTO artist(artist_name) VALUES('Cardi B');
INSERT INTO artist(artist_name) VALUES('Carly Ray Jepsen');
INSERT INTO artist(artist_name) VALUES('The Chainsmokers');
INSERT INTO artist(artist_name) VALUES('Chance The Rapper');
INSERT INTO artist(artist_name) VALUES('Charli XCX');
INSERT INTO artist(artist_name) VALUES('Chief Keef');
INSERT INTO artist(artist_name) VALUES('Childish Gambino');
INSERT INTO artist(artist_name) VALUES('Chris Brown');
INSERT INTO artist(artist_name) VALUES('Tyga');
INSERT INTO artist(artist_name) VALUES('City Girls');
INSERT INTO artist(artist_name) VALUES('CJ');
INSERT INTO artist(artist_name) VALUES('Cordae');
INSERT INTO artist(artist_name) VALUES('Rod Wave');
SELECT * FROM artist WHERE artist_name LIKE '%roke%';

SELECT * FROM album;
INSERT INTO album VALUES(1,'High Off Life',2020,2);
INSERT INTO album VALUES(2,'DS2',2015,2);
INSERT INTO album VALUES(3,'Future',2017,2);
INSERT INTO album VALUES(4,'HNDRXX',2017,2);
INSERT INTO album VALUES(5,'Monster',2014,2);
INSERT INTO album VALUES(6,'After Hours',2020,1);
INSERT INTO album VALUES(7,'Beauty Behind The Madness',2015,1);
INSERT INTO album VALUES(8,'Kiss Land',2013,1);
INSERT INTO album VALUES(9,'Positions',2020,12);
INSERT INTO album VALUES(10,'38 Baby 2',2020,3);
SELECT * FROM album WHERE album_name = '';


SELECT * FROM song;
INSERT INTO song VALUES(1,6,2,'Blinding Lights','3.23','S',NULL,283);
INSERT INTO song VALUES(2,1,2,'Hard To Choose One','3.16','S',NULL,253);
INSERT INTO song VALUES(3,NULL,4,'Laugh Now Cry Later','4.21','A','Lil Durk',240);

