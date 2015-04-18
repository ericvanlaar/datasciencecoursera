### Project Introduction

The purpose of this repository is to host the code for the "Getting and Cleaning Data Course Project."

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

### Data Background & Source

One of the most **exciting** areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data utilized for this project represent experiment data collected from the accelerometers from the Samsung Galaxy S smartphone. 

A full description is available at the site where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

A link to the source data can be found here:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


### Execution and files

The files used in this project are as follows:

* `run_analysis.R` : the R-code run on the data set, which aggregates ands cleans the data as described in CodeBook.md

* `tidy.txt` : the clean data extracted from the original data using `run_analysis.R`

* `CodeBook.md` : the CodeBook reference to the variables in `tidy.txt`

* `README.md` : explains how all of the scripts work and how they are connected

The R code in `run_analysis.R` assumes that the zip file available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip has been downloaded and extracted in the R Home Working Directory.

