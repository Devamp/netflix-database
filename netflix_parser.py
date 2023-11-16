import csv
import shutil
import os

def createMoviesTable(data):
    with open("./results/movies.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile) # csv writer for this file


def createShowsTable(data):
    with open("./results/shows.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile) # csv writer for this file


def createMoviesDirectorsTable(data):
    with open("./results/movie_directors.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile) # csv writer for this file


def createShowsDirectorsTable(data):
    with open("./results/show_directors.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile) # csv writer for this file


def createMovieCastTable(data):
    with open("./results/movie_cast.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile) # csv writer for this file


def createShowCastTable(data):
    with open("./results/show_cast.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile) # csv writer for this file


def createGenresTable(data):
    with open("./results/genres.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile) # csv writer for this file


def createShowsTable(data):
    with open("./results/shows.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile) # csv writer for this file


def createCountriesTable(data):
    with open("./results/countries.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile) # csv writer for this file

def getNetflixData(file_path):
    with open(file_path, "r") as csvfile:
        data = list(csv.reader(csvfile))
    return data

csv_file_path = "./netflix_titles.csv"

# create results dir to store the resulting csv files
if not os.path.exists("./results"):
    os.makedirs("./results")
else:
    shutil.rmtree("./results")
    os.makedirs("./results")

# read csv and get data
data = getNetflixData(csv_file_path)

# take out header
data = data[1:] 

# create subset csv files for each of the tables from the original data
createMoviesTable(data)
createMovieCastTable(data)
createMoviesDirectorsTable(data)
createShowsTable(data)
createShowCastTable(data)
createShowsDirectorsTable(data)
createCountriesTable(data)
createGenresTable(data)
