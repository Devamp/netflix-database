import csv
import shutil
import os

# These hashtables are used for reference foreign keys

# Maps [Movie Name] -> [MovieID]
moviesList = {}
# Maps [Director Name] -> [DirectorID]
directorsList = {}
# Maps [Show Name] -> [ShowID]
showsList = {}
# Maps [Country Name] -> [CountryID]
countriesList = {}
# Maps [Genre Name] -> [GenreID]
genresList = {}
# Maps [Cast Name] -> [CastID]
castsList = {}


def getNetflixData(file_path):
    with open(file_path, "r") as csvfile:
        data = list(csv.reader(csvfile))
    return data

def toInt(data):
    i = data.split()
    if len(i) > 0:
        return int(i[0])


def createMoviesTable(data):
    with open("./results/movies.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile)  # csv writer for this file

        header = [  # header for the movies csv file
            "MovieID",
            "Name",
            "Date_Added",
            "Release_Year",
            "Rating",
            "Duration(minutes)",
            "Description",
        ]

        idCounter = 1  # to count primary key

        writer.writerow(header)  # first write header

        for rowIdx in range(len(data)):  # loop through the data
            if data[rowIdx][1] == "Movie":  # if the data row is a "Movie"
                row = [  # create row which will be written to csv using data and indexing the correct elements
                    idCounter,  # MovieID
                    data[rowIdx][2],  # Name
                    data[rowIdx][6],  # Data Added
                    data[rowIdx][7],  # Release Year
                    data[rowIdx][8],  # Rating
                    toInt(data[rowIdx][9]),  # Duration
                    data[rowIdx][11],  # Description
                ]

                writer.writerow(row)  # write the row to csv

                # add mapping (MovieID -> Movie Name) to hash table to be used for foreign key referencing later
                moviesList[data[rowIdx][2]] = idCounter

                idCounter += 1  # increment id counter


def createShowsTable(data):
    with open("./results/shows.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile)  # csv writer for this file

        header = [  # header for the shows csv file
            "ShowID",
            "Name",
            "Date_Added",
            "Release_Year",
            "Rating",
            "Duration(seasons)",
            "Description",
        ]

        idCounter = 1  # to count primary key

        writer.writerow(header)  # first write header

        for rowIdx in range(len(data)):  # loop through the data
            if data[rowIdx][1] == "TV Show":  # if the data row is a "TV Show"
                row = [  # create row which will be written to csv using data and indexing the correct elements
                    idCounter,  # ShowID
                    data[rowIdx][2],  # Name
                    data[rowIdx][6],  # Data Added
                    data[rowIdx][7],  # Release Year
                    data[rowIdx][8],  # Rating
                    toInt(data[rowIdx][9]),  # Duration
                    data[rowIdx][11],  # Description
                ]

                writer.writerow(row)  # write the row to csv

                # add mapping (ShowID -> Show Name) to hash table to be used for foreign key referencing later
                showsList[data[rowIdx][2]] = idCounter

                idCounter += 1  # increment id counter


def createMoviesDirectorsTable(data):
    with open("./results/movie_directors.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile)  # csv writer for this file

        header = [  # header for the directors csv file
            "DirectorID",
            "Name",
            "MovieID",
        ]

        idCounter = 1  # to count primary key

        writer.writerow(header)  # first write header

        for rowIdx in range(len(data)):  # loop through the data
            if data[rowIdx][1] == "Movie":  # if the data row is a "Movie"
                # split directors string into a list dilimited at ','
                directors = data[rowIdx][3].split(",")

                if data[rowIdx][3] == "":
                    continue

                # for each director in the current movie
                for d in directors:
                    dirID = idCounter
                    d = d.strip()

                    if (
                        d in directorsList
                    ):  # if director is already been seen, use their id
                        dirID = directorsList[d]
                    else:
                        directorsList[d] = dirID
                        idCounter += 1  # increment id counter

                    # create row which will be written to csv using data and indexing the correct elements
                    row = [
                        dirID,  # director id (either new or old)
                        d,  # director name
                        moviesList[
                            data[rowIdx][2]
                        ],  # move name (gotten from moviesList hashtable)
                    ]
                    writer.writerow(row)  # write the row to csv


def createShowsDirectorsTable(data):
    with open("./results/show_directors.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile)  # csv writer for this file

        header = [  # header for the show directors csv file
            "DirectorID",
            "Name",
            "ShowID",
        ]

        writer.writerow(header)  # first write header

        for rowIdx in range(len(data)):  # loop through the data
            if data[rowIdx][1] == "TV Show":  # if the data row is a "TV Show"
                # split directors string into a list dilimited at ','
                directors = data[rowIdx][3].split(",")

                if data[rowIdx][3] == "":  # skip null directors
                    continue

                # for each director in the current movie
                for d in directors:
                    d = d.strip()

                    if (
                        d in directorsList
                    ):  # if director is already been seen, use their id
                        dirID = directorsList[d]
                    else:
                        directorsList[d] = max(directorsList.values()) + 1

                    # create row which will be written to csv using data and indexing the correct elements
                    row = [
                        dirID,  # director id (either new or old)
                        d,  # director name
                        showsList[
                            data[rowIdx][2]
                        ],  # show name (gotten from showsList hashtable)
                    ]
                    writer.writerow(row)  # write the row to csv


def createMovieCastTable(data):
    with open("./results/movie_cast.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile)  # csv writer for this file

        header = [  # header for the cast csv file
            "CastID",
            "Name",
            "MovieID",
        ]

        idCounter = 1  # to count primary key

        writer.writerow(header)  # first write header

        for rowIdx in range(len(data)):  # loop through the data
            if data[rowIdx][1] == "Movie":  # if the data row is a "Movie"
                # split cast string into a list dilimited at ','
                casts = data[rowIdx][4].split(",")

                if data[rowIdx][4] == "":
                    continue

                # for each cast in the current movie
                for c in casts:
                    castID = idCounter
                    c = c.strip()

                    if c in castsList:  # if cast is already been seen, use their id
                        castID = castsList[c]
                    else:
                        castsList[c] = castID
                        idCounter += 1  # increment id counter

                    # create row which will be written to csv using data and indexing the correct elements
                    row = [
                        castID,  # cast id (either new or old)
                        c,  # cast name
                        moviesList[
                            data[rowIdx][2]
                        ],  # movie name (gotten from moviesList hashtable)
                    ]
                    writer.writerow(row)  # write the row to csv


def createShowCastTable(data):
    with open("./results/show_cast.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile)  # csv writer for this file

        header = [  # header for the cast csv file
            "CastID",
            "Name",
            "ShowID",
        ]

        writer.writerow(header)  # first write header

        for rowIdx in range(len(data)):  # loop through the data
            if data[rowIdx][1] == "TV Show":  # if the data row is a "TV Show"
                # split cast string into a list dilimited at ','
                casts = data[rowIdx][4].split(",")

                if data[rowIdx][4] == "":
                    continue

                # for each cast in the current movie
                for c in casts:
                    c = c.strip()

                    if c in castsList:  # if cast is already been seen, use their id
                        castID = castsList[c]
                    else:
                        castsList[c] = castID = max(castsList.values()) + 1

                    # create row which will be written to csv using data and indexing the correct elements
                    row = [
                        castID,  # cast id (either new or old)
                        c,  # cast name
                        showsList[
                            data[rowIdx][2]
                        ],  # show name (gotten from showList hashtable)
                    ]
                    writer.writerow(row)  # write the row to csv


def createGenresTable(data):
    with open("./results/genres.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile)  # csv writer for this file

        header = [  # header for the genre csv file
            "GenreID",
            "Name",
            "ShowID",
            "MovieID",
        ]

        idCounter = 1  # to count primary key

        writer.writerow(header)  # first write header

        for rowIdx in range(len(data)):  # loop through the data
            # split genres string into a list dilimited at ','
            genres = data[rowIdx][10].split(",")

            if data[rowIdx][10] == "":  # skip null directors
                continue

            # for each genre in the current row
            for g in genres:
                g = g.strip()
                gID = idCounter

                if g in genresList:
                    gID = genresList[g]
                else:
                    genresList[g] = gID

                mID, sID = None, None

                if data[rowIdx][1] == "TV Show":
                    sID = showsList[data[rowIdx][2]]
                elif data[rowIdx][1] == "Movie":
                    mID = moviesList[data[rowIdx][2]]

                row = [  # create row which will be written to csv using data and indexing the correct elements
                    gID,  # CountryID
                    g,  # Name
                    sID,  # Show ID
                    mID,  # Movie ID
                ]

                writer.writerow(row)  # write the row to csv

                idCounter += 1  # increment id counter


def createCountriesTable(data):
    with open("./results/countries.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile)  # csv writer for this file

        header = [  # header for the countries csv file
            "CountryID",
            "Name",
            "ShowID",
            "MovieID",
        ]

        idCounter = 1  # to count primary key

        writer.writerow(header)  # first write header

        for rowIdx in range(len(data)):  # loop through the data
            # split countries string into a list dilimited at ','
            countries = data[rowIdx][5].split(",")

            if data[rowIdx][5] == "":  # skip null directors
                continue

            # for each director in the current movie
            for c in countries:
                c = c.strip()
                cID = idCounter

                if c in countriesList:
                    cID = countriesList[c]
                else:
                    countriesList[c] = cID

                mID, sID = None, None

                if data[rowIdx][1] == "TV Show":
                    sID = showsList[data[rowIdx][2]]
                elif data[rowIdx][1] == "Movie":
                    mID = moviesList[data[rowIdx][2]]

                row = [  # create row which will be written to csv using data and indexing the correct elements
                    cID,  # CountryID
                    c,  # Name
                    sID,  # Show ID
                    mID,  # Movie ID
                ]

                writer.writerow(row)  # write the row to csv

                idCounter += 1  # increment id counter


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
