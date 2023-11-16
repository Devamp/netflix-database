import csv
import sys

sys.path.remove("/Users/devam/Desktop/netflix_database")


csv_file_path = "./netflix_titles.csv"

# def createMoviesTable()

with open(csv_file_path, "r") as csvfile:
    reader = csv.reader(csvfile)

    # Get header
    header = next(reader)

    for row in reader:
        print(row)
