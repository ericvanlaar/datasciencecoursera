## CodeBook

This code book will describe the variables, the data, and any transformations that have been performed to clean up the data.

### Overview 

The data utilized for this project represent experimental data collected from the accelerometers from a group of 30 volunteers within an age bracket of 19-48 years, using the Samsung Galaxy S smartphone. 

### Variables & Feature Selection

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The process described below creates a single data set containing the the mean and standard deviation for each measurement.

### The dataset includes the following files:

Metadata

* `features.txt`: List of all features - 561 features/variables
* `activity_labels.txt`: Name and ID of 6 activities: walking, walking upstairs, walking downstairs, sitting, standing, laying

Training Data [folder: /train]

* `X_train.txt`: 7352 observations of the 561 features, for 21 of the 30 volunteers
* `subject_train.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30
* `y_train.txt`: A vector of 7352 integers, denoting the ID of the activity related to each of the observations in X-train.txt


Test Data [folder: /test]

* `X_test.txt`: 2947 observations of the 561 features, for 9 of the 30 volunteers
* `subject_test.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30
* `y_test.txt`: A vector of 2947 integers, denoting the ID of the activity related to each of the observations in X-test.txt

Additional info regarding the files is available in `README.md`. More information about the features is available in `features_info.txt`.

### Processing steps

1. Merged the training and the test sets to create one data set
- All Training Data and Test Data were read into separate data frames, and then combined into a *subject*, *features*, and *activity* data frame. 
- `features.txt` metadata was used as column names for the *features* data frame
- *activity* data frame was given column name 'activity'
- *subject* data frame was given column name 'subjectID'
- 'full_data' data frame includes all data sets, which includes all observations of *subject*, *features*, and *activity*
- 'filtered_data' data frame includes only extracted measurements on mean and standard deviation from filter created in step 2 (below)

2. Extracted only the measurements on the mean and standard deviation for each measurement
- Any feature column was removed that didn't contain exact string 'mean()' or 'std()'. The result was **66** feature columns, plus the *subjectID* and *activity* columns.
        
3.  Used descriptive activity names to name the activities in the data set
- In the `activity_labels.txt` file unneeded character "_" was removed, and 'activity' name was converted to lower case  
- The 'activity' column in *activity* data frame was converted from an integer to a factor, using labels in `activity_labels.txt`
        
4. Appropriately labeled the data set with descriptive variable names
- The following replacements were made on the *features* data frame so as to make the final variable names more readable:  
Acc--> Accelerometer,  
Gyro--> Gyroscope,  
BodyBody--> Body,  
Mag--> Magnitude,  
tBody--> TimeBody,  
mean--> Mean,  
std--> STD,  
angle--> Angle,  
gravity--> Gravity

5. From the data set in step 4, a second, independent tidy data set was created using the average of each variable for each activity and each subject
- Tidy data set created which contains the mean of each feature for each subject and each activity. For instance, each subject has exactly 6 rows in the tidy data set - each row corresponds to each activity, and each row contains the mean value for each of the 66 features for that subject/activity combination. Given that there are 6 activities and 30 subjects there are a total of 180 rows

6. Output the tidy data set to `tidy.txt` file - removing row.names 





