## Getting and Cleaning Data Course Project

# The final run_analysis.R does the following:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Transformations and steps involved run_analysis.R

* Load plyr library
* Load source dataset one by one
* Set wroking directory to point to "UCI HAR Dataset" and place run_analysis.R in it 
* Follow the comments in run_analysis.R to get and clean this dataset. It will generate tidy_avg_data_final.txt in the end.
