

merge_data<-function(){
sub_Train  <- data.table(read.table("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"))     # load the subject train data
sub_Test   <- data.table(read.table("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")) 

Train_X_data  <- data.table(read.table("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"))     # load the subject train data
Test_X_data   <- data.table(read.table("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")) 

Train_Y_data  <- data.table(read.table("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt"))     # load the subject train data
Test_Y_data   <- data.table(read.table("F:/data science specialist/course3/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")) 

merge_X <- rbind(Train_X_data, Test_X_data)
# cahnges the names of column of data x
old_x_name=names(merge_X)
new_x_name=gsub("V","X",colnames(merge_X))
setnames(merge_X,old_x_name,new_x_name)
# cahnges the names of column of data y
merge_y <- rbind(Train_Y_data, Test_Y_data)
old_y_name=names(merge_y)
new_y_name=gsub("V","y",colnames(merge_y))
setnames(merge_y,old_y_name,new_y_name)
# cahnges the names of column of data sub
merge_sub<- rbind(sub_Train, sub_Test)
setnames(merge_sub,"V1","SUB")
#COMPINE ALL
alldata<- cbind(merge_sub,merge_X,merge_y)
  }
