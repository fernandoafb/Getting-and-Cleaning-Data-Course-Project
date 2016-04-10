# Script for the Getting and Cleaning Data Course Project

# Constants

wd <- getwd()
dataset_local_filename <- "dataset.zip"
dataset_remote_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataset_folder <- "UCI HAR Dataset"

# Checking if the dataset does not exists
# If so, downloads it

if (!file.exists(dataset_local_filename)) {
  print("Downloading dataset...")
  download.file(dataset_remote_url, dataset_local_filename, mode = "wb")
} else {
  print("Dataset previously downloaded.")
}

# Checking if the dataset folder does not exists
# If so, unzips the file

if (!file.exists(dataset_folder)) {
  print("Unzipping dataset...")
  unzip(dataset_local_filename)
} else {
  print("Dataset previously unzipped.")
}

library(plyr)

setwd(paste(c(wd, dataset_folder), collapse = "/"))

setwd(wd)