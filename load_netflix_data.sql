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

-- Load data from CSV files
\COPY netflix_movies_shows.movies FROM '~/netflix-database/results/movies.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.movie_directors FROM '~/netflix-database/results/movie_directors.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.movie_cast FROM '~/netflix-database/results/movie_cast.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.shows FROM '~/netflix-database/results/shows.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.show_directors FROM '~/netflix-database/results/show_directors.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.show_cast FROM '~/netflix-database/results/show_cast.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.genres FROM '~/netflix-database/results/genres.csv' WITH DELIMITER ',' CSV HEADER;
\COPY netflix_movies_shows.countries FROM '~/netflix-database/results/countries.csv' WITH DELIMITER ',' CSV HEADER;