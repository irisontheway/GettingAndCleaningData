# download the source file and unzip it

urlp <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

setwd("C:\\Users\\Desktop\\work\\DS\\")

file_download <- download.file(urlp, destfile = "dataset.zip")

unzip(zipfile = "./dataset.zip")


# read test and train dataset
setwd("C:\\Users\\Desktop\\work\\DS\\UCI HAR Dataset")

subject_test <- read.table("./test/subject_test.txt", header = FALSE)
x_test <- read.table("./test/X_test.txt", header = FALSE)
y_test <- read.table("./test/y_test.txt", header = FALSE)


subject_train <- read.table("./train/subject_train.txt", header = FALSE)
x_train <- read.table("./train/X_train.txt", header = FALSE)
y_train <- read.table("./train/y_train.txt", header = FALSE)

# read label and feature

feature <- read.table("features.txt", header = FALSE) 
activityLabel <- read.table("activity_labels.txt",header=FALSE)
colnames(activityLabel) <- c("activity", "activityDetails")

## 1. Merges the training and the test sets to create one data set.

subject <- rbind(subject_test, subject_train)
x <- rbind(x_test, x_train)
y <- rbind(y_test, y_train)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

colnames(feature) <- c("id", "signal")

names(x)<- feature$signal
AllData <- cbind (subject,x,y)

colnames(AllData)[1] <- c("subject")
colnames(AllData)[563] <- c("activity")
names(AllData)

data_mean_std_col <- AllData[,grep("subject|mean\\(\\)|std\\(\\)|activity", colnames(AllData))]


## 3. Uses descriptive activity names to name the activities in the data set

data_mean_std_activity <- merge(activityLabel,data_mean_std_col, by="activity", ALL=TRUE)

head(data_mean_std_activity$activityDetails, 30)


## 4. Appropriately labels the data set with descriptive variable names.

names(data_mean_std_activity) <- gsub("^t", "time", names(data_mean_std_activity))
names(data_mean_std_activity) <- gsub("^f", "frequency", names(data_mean_std_activity))
names(data_mean_std_activity) <- gsub("Acc", "Accelerometer", names(data_mean_std_activity))
names(data_mean_std_activity) <- gsub("Gyro", "Gyroscope", names(data_mean_std_activity))
names(data_mean_std_activity) <- gsub("Mag", "Magnitude", names(data_mean_std_activity))
names(data_mean_std_activity) <- gsub("BodyBody", "Body", names(data_mean_std_activity))

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr)

avg_data_final <- ddply(data_mean_std_activity, c("subject","activityDetails"), numcolwise(mean))

write.table(avg_data_final,file="tidy_avg_data_final.txt")


