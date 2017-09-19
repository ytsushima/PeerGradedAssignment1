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

#   read feature names
features <- scan("./features.txt",what = character(), sep = "\n")

features <- sub(" ","_", features)

#   read activity labels
activityLabels <- read.fwf("./activity_labels.txt", width = c(2,18), col.names = c("activityLabel","activityName"))

#   merge activity names
dataset <- merge(dataset, activityLabels, by = "activityLabel")

names(dataset) <- c("activityLabel", features, "subject", "activityName")

#   selects necessary columns
necessaryColumns <- c("subject", "activityLabel", "activityName", grep("mean\\(|std\\(", features, value = TRUE))

library(dplyr)

# grouped by subject and activityName
dataset2 <- dataset %>%
            select(necessaryColumns) %>%
            group_by(subject, activityName) %>%
            summarize_all(mean)

write.table(dataset2, "./dataset2.csv", quote=F, sep=",", row.name=FALSE)
