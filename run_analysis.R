activity_labels <- read.table("./data/project/activity_labels.txt")
feature_labels <- read.table("./data/project/features.txt")

#Creation of a Single Data set combining Signal/Activity/Subject Data across Test and Training Data
#Reading Training signal Data
x1 <- read.table("./data/project/train/X_train.txt")
y1 <- read.table("./data/project/train/y_train.txt")
z1 <- read.table("./data/project/train/subject_train.txt")

#Reading Test signal Data
x2 <- read.table("./data/project/test/X_test.txt")
y2 <- read.table("./data/project/test/y_test.txt")
z2 <- read.table("./data/project/test/subject_test.txt")

#Merging the Test and Training Signal/Activity/Subject Data
x3 <- rbind(x1,x2)
y3 <- rbind(y1,y2)
z3 <- rbind(z1,z2)

#Updating Column Names for Signal/Activity/Subject Data
colnames(x3) <- feature_labels$V2
colnames(y3) <- c("Activity_id")
colnames(z3) <- c("Subject_id")

#Merge all the Test and Training Data into a single Data Set Single_Data_Set
Single_Data_Set <- cbind(x3,cbind(z3,y3))

################################################################################
# 2.Extracts only the measurements on the mean and standard deviation for each measurement and stores them along with the subject and activity ids. 
Single_Data_Set <- Single_Data_Set[,grep("mean|std|Activity_id|Subject_id",colnames(Single_Data_Set))]

################################################################################
# Uses descriptive activity names to name the activities in the data set
# Append the activity name to activity id column
# To do a merge, rename the activity_labels column names, and then merge based on activity_id
colnames(activity_labels) = c("Activity_id","Activity_Description")
Single_Data_Set <- merge(activity_labels,Single_Data_Set,all=TRUE)


##########################################################
# Replace variable column names with more descriptive names
colnames(Single_Data_Set) <- gsub("tBodyAccJerk","Time Body Acceleration Jerk",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("tBodyGyroJerk","Time Body Gyro Jerk",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("tGravityAccMag","Time Gravity Acceleration Magnitude",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("tBodyAccMag","Time Body Acceleration Magnitude",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("tBodyGyroMag","Time Body Gyro Magnitude",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("tBodyAcc","Time Body Acceleration",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("tGravityAcc","Time Gravity Acceleration",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("tBodyGyro","Time Body Gyro",colnames(Single_Data_Set))

colnames(Single_Data_Set) <- gsub("fBodyBodyGyroJerkMag","FFT Body Body Gyro Jerk Magnitude",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("fBodyBodyAccJerkMag","FFT Body Body Acceleration Jerk Magnitude",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("fBodyBodyGyroMag","FFT Body Body Gyro Magnitude",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("fBodyAccMag","FFT Body Acceleration Magnitude",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("fBodyAccJerk","FFT Body Acceleration Jerk",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("fBodyGyro","FFT Body Gyro",colnames(Single_Data_Set))
colnames(Single_Data_Set) <- gsub("fBodyAcc","FFT Body Acceleration",colnames(Single_Data_Set))

###############################################
# 5. Group by activity and subject_id and 
#A <- group_by(Single_Data_Set,Activity_id,Subject_id)
drops <- c("Activity_Description")
Reshaped_Data_Set <- Single_Data_Set[,!(names(Single_Data_Set) %in% drops)]

Activity_id <- Reshaped_Data_Set[,Reshaped_Data_Set$Activity_id]
                                
Reshaped_Data_Set <- aggregate(Reshaped_Data_Set,by=list(Group.Activity_id=Reshaped_Data_Set$Activity_id,Group.Subject_id=Reshaped_Data_Set$Subject_id),FUN=mean, na.rm=TRUE)
drops <- c("Activity_id","Subject_id")
Reshaped_Data_Set <- Reshaped_Data_Set[,!(names(Reshaped_Data_Set) %in% drops)]
colnames(Reshaped_Data_Set)[1] <- "Activity_id"
colnames(Reshaped_Data_Set)[2] <- "Subject_id"

##############################
#Write the reshaped_data_set onto a file
write.table(Reshaped_Data_Set, './Data/Project/Activity_Subject_Mean_Data_Set.txt',row.names=FALSE,sep=',');







