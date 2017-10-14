
run_analysis<-function(){
  ##q1 Merges the training and the test sets to create one data set.
  ## read all the datasets
sub_Train  <- data.table(read.table("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"))     # load the subject train data
sub_Test   <- data.table(read.table("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")) 

Train_X_data  <- data.table(read.table("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"))     # load the subject train data
Test_X_data   <- data.table(read.table("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")) 

Train_Y_data  <- data.table(read.table("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt"))     # load the subject train data
Test_Y_data   <- data.table(read.table("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")) 
# merge the data of x
merge_X <- rbind(Train_X_data, Test_X_data)
# cahnges the names of column of data x
#old_x_name=names(merge_X)
#new_x_name=gsub("V","X",colnames(merge_X))
#setnames(merge_X,old_x_name,new_x_name)
# cahnges the names of column of data y
  # merge the data of y
merge_y <- rbind(Train_Y_data, Test_Y_data)
#old_y_name=names(merge_y)
#new_y_name=gsub("V1","Y",colnames(merge_y))
#setnames(merge_y,old_y_name,new_y_name)
setnames(merge_y,"V1","Y")
# cahnges the names of column of data sub
merge_sub<- rbind(sub_Train, sub_Test)
setnames(merge_sub,"V1","SUB")
# merge the data
alldata<- cbind(merge_sub,merge_y,merge_X)

##q2  Extracts only the measurements on the mean and standard deviation for each measurement.

features_Data  <- fread("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/features.txt") 
MeanStd_pos   <- grep("mean|std",features_Data$V2)  # looking for the position of mean and sd
meanAndStd_data   <- subset(alldata[,3:length(alldata)], select=MeanStd_pos,with=FALSE)
alldata_with_m_sd<- cbind(alldata[,1:2],meanAndStd_data) # combine the data for y and subset

##q3 Uses descriptive activity names to name the activities in the data set

activityNames<- fread("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")                           # load the file
names(activityNames) <- c("Y", "Activities_Name")             # Set col names
#setkey(alldata,y1)                                     # Set a key
#setkey(activityNames,mergeY)                                  # Set a key
#all <- merge(alldata,activityNames)                 # Merge by the key of each data 
all=merge(x=alldata_with_m_sd,y=activityNames,by="Y")
seq_all=cbind(all[,2],all[,1],all[,82],all[,3:81]) #rorder the data

###q4 Appropriately labels the data set with descriptive variable names.
  
feature_name=features_Data$V2[MeanStd_pos]  
feature_name <- gsub("Acc", "Acceleration", feature_name)
feature_name <- gsub("^t", "Time", feature_name)
feature_name <- gsub("^f", "Frequency", feature_name)
feature_name <- gsub("BodyBody", "Body", feature_name)
feature_name<- gsub("mean", "Mean", feature_name)
feature_name<- gsub("std", "Std", feature_name)
feature_name<- gsub("Freq", "Frequency", feature_name)
feature_name<- gsub("Mag", "Magnitude", feature_name)
feature_name <- gsub("-","_",feature_name)
feature_name_x<-feature_name
feature_name<- append(c("Subject","Activity_ID","Activity_Name"),feature_name)

names(seq_all)=feature_name

##q5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

dataMelt    <- melt(seq_all, id = c("Subject","Activity_ID","Activity_Name"), measure.vars = feature_name_x)

# CASTING DATA FRAME
tidyData   <- dcast(dataMelt, Subject + Activity_Name ~ variable, mean)
  # write into the data
write.table(tidyData,file="F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/tidydata.txt",row.name=FALSE)
}

