
library(dplyr)

#
# 1.Merges the training and the test sets to create one data set
#

# read files
#   subject fules
subjectTrain <- read.fwf("./train/subject_train.txt", width = 3, col.names = "subject")
subjectTest <- read.fwf("./test/subject_test.txt", width = 3, col.names = "subject")

#   features vector files (X, train and test) which have 561 features. each column width = 16
XTrain  <- read.fwf("./train/X_train.txt", width = (numeric(561) + 16))
XTest  <- read.fwf("./test/X_test.txt", width = (numeric(561) + 16))

#   label files (y, train and test)
yTrain  <- read.fwf("./train/y_train.txt", width = 3, col.names = "activityLabel")
yTest  <- read.fwf("./test/y_test.txt", width = 3, col.names = "activityLabel")

train <- cbind(XTrain, yTrain, subjectTrain)
test <- cbind(XTest, yTest, subjectTest)

dataset <- rbind(train, test)

#
# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
#

#   read feature names
features <- scan("./features.txt",what = character(), sep = "\n")

features <- sub(" ","_", features)
features <- sprintf("X%s", features)

#   selects necessary columns
#    -- the mean and standard deviation for each measurement

necessaryColumns <- c(sprintf("V%s", grep("mean\\(|std\\(", features)), "activityLabel", "subject")
features <- grep("mean\\(|std\\(", features, value = TRUE)

dataset <- select(dataset, necessaryColumns)

#
# 3.Uses descriptive activity names to name the activities in the data set
#

#   read activity labels
activityLabels <- read.fwf("./activity_labels.txt", width = c(2,18), col.names = c("activityLabel","activityName"))

#   merge activity names
dataset <- merge(dataset, activityLabels, by = "activityLabel")

#
# 4.Appropriately labels the data set with descriptive variable names.
#

names(dataset) <- c("activityLabel", features, "subject", "activityName")

#
# 5.From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
#

# grouped by subject and activityName
dataset2 <- dataset %>%
            group_by(subject, activityName) %>%
            summarize_all(mean)

write.table(dataset2, "./dataset2.csv", quote=F, sep=",", row.name=FALSE)
