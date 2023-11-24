-- Drop schema if it exists
DROP SCHEMA IF EXISTS netflix_movies_shows CASCADE;

-- Create schema
CREATE SCHEMA netflix_movies_shows;

DROP TABLE IF EXISTS netflix_movies_shows.movies CASCADE;
DROP TABLE IF EXISTS netflix_movies_shows.movie_directors CASCADE;
DROP TABLE IF EXISTS netflix_movies_shows.genres CASCADE;
DROP TABLE IF EXISTS netflix_movies_shows.countries CASCADE;
DROP TABLE IF EXISTS netflix_movies_shows.show_cast CASCADE;
DROP TABLE IF EXISTS netflix_movies_shows.show_directors CASCADE;
DROP TABLE IF EXISTS netflix_movies_shows.movie_cast CASCADE;
DROP TABLE IF EXISTS netflix_movies_shows.shows CASCADE;

-- Create tables
CREATE TABLE netflix_movies_shows.movies (
    MovieID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    Date_Added DATE,
    Release_Year INTEGER,
    Rating VARCHAR(124),
    Duration VARCHAR(124),
    Description TEXT
);

CREATE TABLE netflix_movies_shows.movie_directors (
    DirectorID INTEGER,
    Name VARCHAR(255),
    MovieID INTEGER REFERENCES netflix_movies_shows.movies(MovieID)
);

CREATE TABLE netflix_movies_shows.movie_cast (
    CastID INTEGER,
    Name VARCHAR(255),
    MovieID INTEGER REFERENCES netflix_movies_shows.movies(MovieID)
);

CREATE TABLE netflix_movies_shows.shows (
    ShowID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    Date_Added DATE,
    Release_Year INTEGER,
    Rating VARCHAR(124),
    Duration VARCHAR(124),
    Description TEXT
);

CREATE TABLE netflix_movies_shows.show_directors (
    DirectorID INTEGER,
    Name VARCHAR(255),
    ShowID INTEGER REFERENCES netflix_movies_shows.shows(ShowID)
);

CREATE TABLE netflix_movies_shows.show_cast (
    CastID INTEGER,
    Name VARCHAR(255),
    ShowID INTEGER REFERENCES netflix_movies_shows.shows(ShowID)
);

CREATE TABLE netflix_movies_shows.genres (
    GenreID INTEGER,
    Name VARCHAR(255),
    ShowID INTEGER REFERENCES netflix_movies_shows.shows(ShowID),
    MovieID INTEGER REFERENCES netflix_movies_shows.movies(MovieID)
);

CREATE TABLE netflix_movies_shows.countries (
    CountryID INTEGER,
    Name VARCHAR(255),
    ShowID INTEGER REFERENCES netflix_movies_shows.shows(ShowID),
    MovieID INTEGER REFERENCES netflix_movies_shows.movies(MovieID)
);

ALTER TABLE netflix_movies_shows.countries DROP CONSTRAINT countries_pkey;
ALTER TABLE netflix_movies_shows.show_directors DROP CONSTRAINT show_directors_pkey;
ALTER TABLE netflix_movies_shows.movie_directors DROP CONSTRAINT movie_directors_pkey;
ALTER TABLE netflix_movies_shows.genres DROP CONSTRAINT genres_pkey;
ALTER TABLE netflix_movies_shows.show_cast DROP CONSTRAINT show_cast_pkey;
ALTER TABLE netflix_movies_shows.movie_cast DROP CONSTRAINT movie_cast_pkey;


SELECT COUNT(*) FROM netflix_movies_shows.countries;
SELECT COUNT(*) FROM netflix_movies_shows.show_directors;
SELECT COUNT(*) FROM netflix_movies_shows.movie_directors;
SELECT COUNT(*) FROM netflix_movies_shows.genres;
SELECT COUNT(*) FROM netflix_movies_shows.show_cast;
SELECT COUNT(*) FROM netflix_movies_shows.movie_cast;
SELECT COUNT(*) FROM netflix_movies_shows.movies;
SELECT COUNT(*) FROM netflix_movies_shows.shows;


-- Load data from CSV files
\COPY netflix_movies_shows.movies FROM './results/movies.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.movie_directors FROM './results/movie_directors.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.movie_cast FROM './results/movie_cast.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.shows FROM './results/shows.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.show_directors FROM './results/show_directors.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.show_cast FROM './results/show_cast.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.genres FROM './results/genres.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.countries FROM './results/countries.csv' WITH DELIMITER ',' CSV HEADER;
