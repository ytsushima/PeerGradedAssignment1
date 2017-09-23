# PeerGradedAssignment1

This script intends to summarize the original dataset below.

(from the original readme.txt file)
>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
>Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
>wearing a smartphone (Samsung Galaxy S II) on the waist. 
>Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular 
>velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 
(from the original readme.txt file)

###Original source

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>


The script extracts only the measurements on the mean and standard deviation for each measurement
and grouped by subject, activity.

The script reads the following files

*'features.txt': List of all features.
*'activity_labels.txt': Links the class labels with their activity name.
*'train/X_train.txt': Training set.
*'train/y_train.txt': Training labels.
*'test/X_test.txt': Test set.
*'test/y_test.txt': Test labels.


