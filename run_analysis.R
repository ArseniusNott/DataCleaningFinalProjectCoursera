# Checks the directory harus data in the working directory. If the directory is
# not found, create it.
# HARUS Stands for Human Activity Recognition Using Smartphones
if(!file.exists("./harus_data")) {
        dir.create("./harus_data")
}

#download the zip file located at the fileUrl below
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./harus_data/harus_dataset.zip")

# Unzip dataSet to /harus_data directory
unzip(zipfile="./harus_data/harus_dataset.zip",exdir="./harus_data")

# Read the training tables for x, y and subject:
x_train <- read.table("./harus_data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./harus_data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./harus_data/UCI HAR Dataset/train/subject_train.txt")

# Read the testing tables for x, y and subject:
x_test <- read.table("./harus_data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./harus_data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./harus_data/UCI HAR Dataset/test/subject_test.txt")

# Read features vector that would be the basis for finding variables related to
# mean and standard deviation:
features <- read.table('./harus_data/UCI HAR Dataset/features.txt')

# Read the activity labels (see the CodeBook for details):
activity_labels = read.table('./harus_data/UCI HAR Dataset/activity_labels.txt')

# Rename the variables for training data
colnames(x_train) <- features[ , 2] 
colnames(y_train) <-"activity_id"
colnames(subject_train) <- "subject_id"

# Rename the variables for testing data
colnames(x_test) <- features[ , 2] 
colnames(y_test) <- "activity_id"
colnames(subject_test) <- "subject_id"

# Rename the variables for activity. This will be useful for merging
colnames(activity_labels) <- c('activity_id','activity_type')

# Column bind the data for the training and testing variables x, y, and subject
merge_train_data <- cbind(y_train, subject_train, x_train)
merge_test_data <- cbind(y_test, subject_test, x_test)

# Row bind the traing and testing data
merge_train_and_test_data <- rbind(merge_train_data, merge_test_data)

# Get the column names of merged training and testing data
col_names <- colnames(merge_train_and_test_data)

# Get all the columns related to mean and std as per required by the project
mean_and_std <- (grepl("activity_id" , col_names) | 
                         grepl("subject_id" , col_names) | 
                         grepl("mean.." , col_names) | 
                         grepl("std.." , col_names) 
)

# Subset the merge_train_and_test_data to include only those rows with mean and
# std.
subset_mean_std <- merge_train_and_test_data[ , mean_and_std == TRUE]

# Use descriptive activity names to name the activities in the data set
subset_activity_names <- merge(subset_mean_std, activity_labels,
                              by='activity_id',
                              all.x=TRUE)

# Split the data into subset of subject, activity and subset_activity_names and 
# return the mean summary statistic for each aggregation
tidy_set <- aggregate(. ~subject_id + activity_id, subset_activity_names, mean)
tidy_set <- tidy_set[order(tidy_set$subject_id, tidy_set$activity_id), ]

# Set the activity type as factor to have a definitive name for that activity
tidy_set$activity_type <- factor(tidy_set$activity_type, levels = activity_labels[,1], labels = activity_labels[,2])

# Save the data into tidy.txt
write.table(tidy_set, "tidy.txt", row.names = FALSE, quote = FALSE)