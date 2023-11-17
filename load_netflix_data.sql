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
CREATE TABLE movies (
    MovieID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    Date_Added DATE,
    Release_Year INTEGER,
    Rating VARCHAR(124),
    Duration VARCHAR(124),
    Description TEXT
);

CREATE TABLE movie_directors (
    DirectorID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    MovieID INTEGER REFERENCES movies(MovieID)
);

CREATE TABLE movie_cast (
    CastID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    MovieID INTEGER REFERENCES movies(MovieID)
);

CREATE TABLE shows (
    ShowID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    Date_Added DATE,
    Release_Year INTEGER,
    Rating VARCHAR(124),
    Duration VARCHAR(124),
    Description TEXT
);

CREATE TABLE show_directors (
    DirectorID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    ShowID INTEGER REFERENCES shows(ShowID)
);

CREATE TABLE show_cast (
    CastID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    ShowID INTEGER REFERENCES shows(ShowID)
);

CREATE TABLE genres (
    GenreID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    ShowID INTEGER REFERENCES shows(ShowID),
    MovieID INTEGER REFERENCES movies(MovieID)
);

CREATE TABLE countries (
    CountryID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    ShowID INTEGER REFERENCES shows(ShowID),
    MovieID INTEGER REFERENCES movies(MovieID)
);

-- Load data from CSV files
\COPY movies FROM './results/movies.csv' WITH DELIMITER ',' CSV HEADER;
\COPY movie_directors FROM './results/movie_directors.csv' WITH DELIMITER ',' CSV HEADER;
\COPY movie_cast FROM './results/movie_cast.csv' WITH DELIMITER ',' CSV HEADER;
\COPY shows FROM './results/shows.csv' WITH DELIMITER ',' CSV HEADER;
\COPY show_directors FROM './results/show_directors.csv' WITH DELIMITER ',' CSV HEADER;
\COPY show_cast FROM './results/show_cast.csv' WITH DELIMITER ',' CSV HEADER;
\COPY genres FROM './results/genres.csv' WITH DELIMITER ',' CSV HEADER;
\COPY countries FROM './results/countries.csv' WITH DELIMITER ',' CSV HEADER;


