# ----------------------- Script requirements -------------------------------------------------
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# -----------------------------------------------------------------------------------------------
library(dplyr)
fileURL<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile<-"C:/Documents and Settings/brian.robinson/coursera/tidy.zip"
download.file(fileURL,destfile)
datedownloaded<-date()
print(paste("Downloaded ",datedownloaded))
# Unzip and get organized
unzip(destfile,overwrite=TRUE)
# create DATA dfs
testdf<-read.table("C:\\Documents and Settings\\brian.robinson\\coursera\\UCI HAR Dataset\\test\\X_test.txt",sep="")
traindf<-read.table("C:\\Documents and Settings\\brian.robinson\\coursera\\UCI HAR Dataset\\train\\X_train.txt",sep="")
#Requirement 1 -- combine testing and training data files
data_df<-rbind(testdf,traindf)
# Requirement 3 -- create ACTIVITY dfs with proper factor names
testActivity<-read.table("C:\\Documents and Settings\\brian.robinson\\coursera\\UCI HAR Dataset\\test\\Y_test.txt",sep="")
testActivity[,1]<-factor(testActivity[,1],labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
trainActivity<-read.table("C:\\Documents and Settings\\brian.robinson\\coursera\\UCI HAR Dataset\\train\\Y_train.txt",sep="")
trainActivity[,1]<-factor(trainActivity[,1],labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
activity_df<-rbind(testActivity,trainActivity)
# Requirement 4 --- create SUBJECT dfs with proper factor names
testSubject<-read.table("C:\\Documents and Settings\\brian.robinson\\coursera\\UCI HAR Dataset\\test\\Subject_test.txt",sep="")
testSubject[,1]<-factor(testSubject[,1],labels=c("Subject2","Subject4","Subject9", "Subject10", "Subject12","Subject13","Subject18", "Subject20", "Subject24"))
trainSubject<-read.table("C:\\Documents and Settings\\brian.robinson\\coursera\\UCI HAR Dataset\\train\\Subject_train.txt",sep="")
trainSubject[,1]<-factor(trainSubject[,1],labels=c("Subject1", "Subject3",  "Subject5", "Subject6","Subject7", "Subject8", "Subject11", "Subject14", "Subject15", "Subject16", "Subject17", "Subject19", "Subject21", "Subject22", "Subject23", "Subject25", "Subject26", "Subject27", "Subject28", "Subject29", "Subject30"))
subject_df<-rbind(testSubject,trainSubject)
dfrm<-cbind(subject_df,activity_df,data_df)
# add columns for Subject, Activity, and then create the vector of names for the final dataframe
activity<-data.frame(NA,"Activity")
subject<-data.frame(NA,"Subject")
features<-read.table("C:\\Documents and Settings\\brian.robinson\\coursera\\UCI HAR Dataset\\features.txt")
names(activity)<-names(features)
names(subject)<-names(features)
features<-rbind(subject,activity,features)
features<-features[,2]
# requirement 4 -- Assigns the variable names from features.txt
names(dfrm)<-features
# requirement 2 -- extracts only the columns with names pertaining to "std" or "mean"
dfrm<-subset(dfrm,select=grep("std|mean|Activity|Subject",names(dfrm)))
# 
move<-tbl_df(dfrm)
by_subject <- move %>% group_by(Subject)
subject_stats <- by_subject %>% summarise_each(funs(mean,sd))
by_activity <- move %>% group_by(Activity)
activity_stats <- by_activity %>% summarise_each(funs(mean,sd))
# Remove superfluous columns; rbind requires a common set of colnames
subject_stats<-subject_stats[,-which(names(subject_stats) %in% c("Activity_mean","Activity_sd"))]
activity_stats<-activity_stats[,-which(names(activity_stats) %in% c("Subject_mean","Subject_sd"))]
names(subject_stats)[names(subject_stats)=="Subject"] <- "Category"
names(activity_stats)[names(activity_stats)=="Activity"] <- "Category"
# Requirement 5 -- create the final tidy dataset "tidy_df"
tidy_df<-rbind(subject_stats,activity_stats)
write.table(tidy_df,file="./tidy_df.txt",col.names=T,row.names=F)
# 
# setwd("C:/Documents and Settings/brian.robinson/coursera")

