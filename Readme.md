Course Project - Getting and Cleaning Data
================

Overview
----------------

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Step-by-step Procedure of Data Cleaning (From Cluttered Data to Tidy Data)
--------------

1. Checks the directory harus data in the working directory. If the directory is not found, create it (lines 4 - 7).
2. download the zip file located at the fileUrl mentioned above (lines 9 - 10)
3. Unzip dataSet to /harus_data directory (Line 13)
4. Read the training tables for x, y and subject (lines 16 - 19)
5. Read the testing tables for x, y and subject (lines 21 - 23)
6. Read features vector that would be the basis for finding variables related to mean and standard deviation (line 27)
7. Read the activity labels (see the CodeBook for details) [line 30]
8. Rename the variables for training data (lines 33 - 35)
9. Rename the variables for testing data (lines 38 - 40)
10. Rename the variables for activity. This will be useful for merging (lines 43)
11. Column bind the data for the training and testing variables x, y, and subject (line 46 - 47)
12. Row bind the traing and testing data (line 50)
13. Get the column names of merged training and testing data (line 53)
14. Get all the columns related to mean and std as per required by the project (lines 56 - 60)
15. Subset the merge_train_and_test_data to include only those rows with mean and std (64).
16. Use descriptive activity names to name the activities in the data set (lines 67 - 69)
17. Split the data into subset of subject, activity and subset_activity_names and return the mean summary statistic for each aggregation (lines 73 - 74)
18. Set the activity type as factor to have a definitive name for that activity (line 77)
19. Save the data into tidy.txt (line 80)

The result of the previously enumerated data cleaning process is stored in the tidy.txt file in this repository.