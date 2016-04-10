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

if (!is.element("plyr", installed.packages()[,1])) {
  print("Installing packages...")
  install.packages("plyr")
}

library(plyr)

# Changing the working directory to the dataset folder
setwd(paste(c(wd, dataset_folder), collapse = "/"))

# Doing the five steps required by the project
# 1. Merges the training and the test sets to create one data set.
print("Merging the training and the test sets to create one data set...")
dataset_x_train <- read.table("train/X_train.txt")
dataset_x_test <- read.table("test/X_test.txt")
dataset_x <- rbind(dataset_x_train, dataset_x_test)

dataset_y_train <- read.table("train/y_train.txt")
dataset_y_test <- read.table("test/y_test.txt")
dataset_y <- rbind(dataset_y_train, dataset_y_test)

dataset_subject_train <- read.table("train/subject_train.txt")
dataset_subject_test <- read.table("test/subject_test.txt")
dataset_subject_data <- rbind(dataset_subject_train, dataset_subject_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
print("Extracting only the measurements on the mean and standard deviation for each measurement...")
# Reading the features file
features <- read.table("features.txt")

# Selecting the mean and std features
mean_features <- grep("-(mean)\\(\\)", features[, 2])
std_features  <- grep("-(std)\\(\\)", features[, 2])
mean_and_std_features <- rbind(mean_features, std_features)

# Subsetting the mean and std features
dataset_x <- dataset_x[, mean_and_std_features]

# Setting the names of the dataset_x columns
names(dataset_x) <- features[mean_and_std_features, 2]

# 3. Uses descriptive activity names to name the activities in the data set
print("Using descriptive activity names to name the activities in the data set...")
# Reading the activty labels file
activities <- read.table("activity_labels.txt")

# Updating the values with the descriptive activity names
dataset_y[, 1] <- activities[dataset_y[, 1], 2]

# Setting the name of the dataset_y column
names(dataset_y) <- "activity"

# 4. Appropriately labels the data set with descriptive variable names.
print("Labeling the data set with descriptive variable names...")
# Setting the name of the dataset_subject_data
names(dataset_subject_data) <- "subject"

# Binding all the data in a single and final data set
final_data <- cbind(dataset_x, dataset_y, dataset_subject_data)

# Writing the results to the output file
write.table(averages_data, "final_data.txt", row.name=FALSE)

# 5. From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for each activity and each subject.
print("Creating a second independent tidy data set with the average of each variable for each activity and each subject...")
# Calculating the mean of each column except for the subject and its activity
averages_data <- ddply(final_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

# Writing the results to the output file
write.table(averages_data, "averages_data.txt", row.name=FALSE)

# Changing back to the original working directory
setwd(wd)