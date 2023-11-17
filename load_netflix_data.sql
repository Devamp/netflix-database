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
\COPY movies (Name, Date_Added, Release_Year, Rating, Duration, Description)
FROM './results/movies.csv' DELIMITER ',' CSV HEADER;

\COPY movie_directors (Name, MovieID)
FROM './results/movie_directors.csv' DELIMITER ',' CSV HEADER;

\COPY movie_cast (Name, MovieID)
FROM './results/movie_cast.csv' DELIMITER ',' CSV HEADER;

\COPY shows (Name, Date_Added, Release_Year, Rating, Duration, Description)
FROM './results/shows.csv' DELIMITER ',' CSV HEADER;

\COPY show_directors (Name, ShowID)
FROM './results/show_directors.csv' DELIMITER ',' CSV HEADER;

\COPY show_cast (Name, ShowID)
FROM './results/show_cast.csv' DELIMITER ',' CSV HEADER;

\COPY genres (Name, ShowID, MovieID)
FROM './results/genres.csv' DELIMITER ',' CSV HEADER;

\COPY countries (Name, ShowID, MovieID)
FROM './results/countries.csv' DELIMITER ',' CSV HEADER;

