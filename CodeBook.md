
##CodeBook

data and variables

*****description of data

Download data from the https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip;

the data consist of three category ;

1- the measured variable x which is consisted of 561 different variabel with 7352 training and 2947 test.x data consist of training data and test data which we will combine later.

2- the activites names y (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) the action that person can do while measure the variable.the training consist of 7352 row and one column and test data consist of 2947 row and one column.

3-subject who performed the activity for each window sample. Its range is from 1 to 30 person. the training consist of 7352 row and one column and test data consist of 2947 row and one column.

step1 
question

load all the file in the workspace subject_train.txt, subject_test.txt , X_train.txt, X_test.txt,Y_train.txt,Y_test.txt.

Merge subTrain and subTest into merge_sub,  Merge yTrain and yTest into merge_y,  Merge xTrain and xTest into merge_x by using rbind function 

then merge all table together using cbind function merge_sub,merge_y,merge_X 

step2
question

Extracts only the measurements on the mean and standard deviation for each measurement:

loading the features.txt in the workspace;
searching for the position of the variable that have mean or sd using function grep;
select that data that have mean or sd  
the selected data will be in alldata_with_m_sd variable it consist of 10299 row and 81 row
first element will be the subject , second activities and the rest will be the measurment of x

step3
question 

Uses descriptive activity names to name the activities in the data set:

Loading activity_labels.txt in the workspace. it consist of 6 row and 2 variable it mapp the code of the activity into its name.
we just merge the all data with activity data using activity id the firt row of activity dataset..
the new data set (seq_all) will be 10299 row and 82 column in this sequence 
"subject","activity_id",activity_name",and the rest of data that have mean or sd.

step4
question

Appropriately labels the data set with descriptive variable names:

we do this change 

ACC to accelration

t to Time

f to Frequency

BodyBody to Body

mean  to Mean

std to Std

Freq to Frequency

Mag to Magnitude

using gsub function

and apply it to the name of measured variables.

step5
question

Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Melting "meanAndStd" with the ids and measure variables defined. Creating "dataMelt" variable;

CASTING "dataMelt" using the formula Subject + Activity_Name ~ variable and the agglomerate function mean.
number of row is 180 and column is 81
