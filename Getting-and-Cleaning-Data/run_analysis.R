# Purpose: create a R script that does the following:
#       1. Merges the training and the test sets to create one data set
#       2. Extracts only the measurements on the mean and standard deviation for each measurement
#       3. Uses descriptive activity names to name the activities in the data set
#       4. Appropriately labels the data set with descriptive variable names
#       5. creates a second, independent tidy data set with the average of each variable for each 
#          activity and each subject

# Load necessary packages
library(reshape2)
library(data.table)

# Read Metadata for Labeling Purposes
feature_names <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels <- tolower(gsub("_", " ", activity_labels[,2]))

# Read Training Data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
features_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# Read Test Data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
features_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

# Combine Training & Test Data sets
subject <- rbind(subject_train, subject_test)
features <- rbind(features_train, features_test)
activity <- rbind(activity_train, activity_test)

colnames(features) <- t(feature_names[2])

# Add missing Labels
colnames(activity) <- "activity"
colnames(subject) <- "subjectID"

# Create single Data frame
full_data <- cbind(subject, activity, features)

# Select out only features that are the mean and standard deviation for each measurement 
columnMeanStd <- grepl("mean\\(\\)", names(full_data)) |
        grepl("std\\(\\)", names(full_data))

# Include 'subjectID' & 'activity' in selected columns, and create filtered data set
columnMeanStd[1:2] <- TRUE

filtered_data <- full_data[, columnMeanStd]

# Change 'activity' column from numerical to factor using activity_labels.txt
filtered_data$activity <- factor(filtered_data$activity, labels=activity_labels)

# Replace abbreviations in variable names with full names for user readability 
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

# Set subject as factor variable
filtered_data$subjectID <- as.factor(filtered_data$subjectID)
filtered_data <- data.table(filtered_data)

# Create final tidy data set and write data set to tidy.txt file - removing row.names column
tidyData <- aggregate(. ~subjectID + activity, filtered_data, mean)
tidyData <- tidyData[order(tidyData$subjectID, tidyData$activity),]
write.table(tidyData, file = "tidy.txt", row.names=FALSE)

