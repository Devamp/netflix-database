# Netflix Database Management System Project

## Overview

This repository is the culmination of my final graduate project for the Database Management Systems course. The project focuses on processing a CSV file containing information about 8000 Netflix TV shows and movies. The data is parsed and organized into eight smaller CSV files, each representing a specific table in a PostgreSQL database. A Python script handles the data parsing, while a SQL script initializes the database and loads the data into the respective tables.

## Project Structure

### 1. Data Parsing (Python Script)

- The `netflix_parser.py` script parses the original CSV file into eight smaller CSV files, each corresponding to a table in the database.

### 2. Database Initialization (SQL Script)

- The `load_netflix_data.sql` script:
  - Creates the required PostgreSQL schema and tables.
  - Loads data from the parsed CSV files into the respective tables using the `\COPY` command.

## Dependencies

- Python >= 3.11
- PostgreSQL

## Contributors
- Devam Patel (devamp)
- Manisha Kumari (kumari)


