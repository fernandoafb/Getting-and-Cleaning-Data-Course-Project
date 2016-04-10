Getting and Cleaning Data Course Project
========================================

This repository contains the course project done by Fernando Braz (fernando.afb@gmail.com) for Coursera's Getting and Cleaning Data course. It is mostly composed of  R code and documentation files.

The dataset used can be found in [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The article [Data Science, Wearable Computing and the Battle for the Throne as World’s Top Sports Brand](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) discusses the study field of the dataset.

## How to Use It

The R script, run_analysis.R, does the following:

1. Downloads and unzips the dataset if it does not already exists in the working directory
2. Installs required packages (plyr)
3. Loads both the training and test datasets
4. Merges the two datasets
5. Loads the activity and feature info to describe and filter the dataset
6. Merges activity, mean, standard deviation and subject columns as a single dataset (`UCI HAR Dataset\final_data.txt`)
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair (`UCI HAR Dataset\averages_data.txt`).

To run it, simple type `source('run_analysis.R')` in the R console.

## Files

`CodeBook.md` describes the variables of the data.

`run_analysis.R` contains the code to create the tidy set.

`LICENSE` is the GNU License for this code.

`.gitignore` is the files that should not be versioned (e.g. the dataset and output).