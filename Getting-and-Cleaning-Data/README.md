### Project Introduction

The purpose of this repository is to host the code for the "Getting and Cleaning Data Course Project."

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

### Data Background & Source

One of the most **exciting** areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data utilized for this project represent experiment data collected from the accelerometers from the Samsung Galaxy S smartphone. 

A full description is available at the site where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

A link to the source data can be found here:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


### Files

The files used in this project are as follows:

* `run_analysis.R` : the R-code run on the data set, which aggregates ands cleans the data as described in CodeBook.md

* `tidy.txt` : the clean data extracted from the original data using `run_analysis.R`

* `CodeBook.md` : the CodeBook reference to the variables in `tidy.txt`

* `README.md` : explains how all of the scripts work and how they are connected

The R code in `run_analysis.R` assumes that the zip file available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip has been downloaded and extracted in the R Working Directory.

### Execution of `run_analysis.R`

1. Load the necessary packages 

        library(reshape2)
        library(data.table)

2. Read Metadata for Labeling Purposes of final data set

        feature_names <- read.table("./UCI HAR Dataset/features.txt")
        activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
        activity_labels <- tolower(gsub("_", " ", activity_labels[,2]))

3. Read in Training Data from /UCI HAR Dataset/train

        subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        features_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
        activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

4. Read in Test Data from /UCI HAR Dataset/test

        subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        features_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
        activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

5. Combine the Training & Test Data sets

        subject <- rbind(subject_train, subject_test)
        features <- rbind(features_train, features_test)
        activity <- rbind(activity_train, activity_test)

6. Add transposed list of feature names from `features.txt` as variable names

        colnames(features) <- t(feature_names[2])`

7. Add missing column Labels: activity & subjectID

        colnames(activity) <- "activity"
        colnames(subject) <- "subjectID"

8. Create a single Data frame

        full_data <- cbind(subject, activity, features)

9. Extract out only the features that are the mean and standard deviation for each measurement 
        
        columnMeanStd <- grepl("mean\\(\\)", names(full_data)) |
                grepl("std\\(\\)", names(full_data))

10. Re-Include 'subjectID' & 'activity' in extracted columns to create a filtered data set
        
        columnMeanStd[1:2] <- TRUE
        filtered_data <- full_data[, columnMeanStd]

11. Change 'activity' column from numerical to factor using activity_labels.txt

        filtered_data$activity <- factor(filtered_data$activity, labels=activity_labels)

12. Replace abbreviations in variable names with full names for user readability 

        names(filtered_data)<-gsub("Acc", "Accelerometer", names(filtered_data))
        names(filtered_data)<-gsub("Gyro", "Gyroscope", names(filtered_data))
        names(filtered_data)<-gsub("BodyBody", "Body", names(filtered_data))
        names(filtered_data)<-gsub("Mag", "Magnitude", names(filtered_data))
        names(filtered_data)<-gsub("^f", "Frequency", names(filtered_data))
        names(filtered_data)<-gsub("^t", "Time", names(filtered_data))
        names(filtered_data)<-gsub("tBody", "TimeBody", names(filtered_data))
        names(filtered_data)<-gsub("-mean\\(\\)", "_Mean", names(filtered_data), ignore.case = TRUE)
        names(filtered_data)<-gsub("-std\\(\\)", "_STD", names(filtered_data), ignore.case = TRUE)
        names(filtered_data)<-gsub("angle", "Angle", names(filtered_data))
        names(filtered_data)<-gsub("gravity", "Gravity", names(filtered_data))

13. Set subjectID as a factor variable

        filtered_data$subjectID <- as.factor(filtered_data$subjectID)
        filtered_data <- data.table(filtered_data)

14. Create a final tidy data set and write data set to `tidy.txt` file - removing the row.names column
        
        tidyData <- aggregate(. ~subjectID + activity, filtered_data, mean)
        tidyData <- tidyData[order(tidyData$subjectID, tidyData$activity),]
        write.table(tidyData, file = "tidy.txt", row.names=FALSE)

