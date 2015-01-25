library(reshape2)

#1.	Merge training data set & test data set (to rawAll)
#	activity & subject will not be added until step 4
rawTrain <- read.table("Downloads/UCI HAR Dataset/train/X_train.txt")
rawTest <- read.table("Downloads/UCI HAR Dataset/test/X_test.txt")
rawAll <- rbind(rawTrain, rawTest)
rawAll

#2.	Extract only the measurements on the mean and standard deviation for each measurement (to result2)
ave <- apply(rawAll, 2, mean)
sd <- apply(rawAll, 2, sd)
result2 <- rbind(ave, sd)
#	Give the row names
rownames(result2) <- c(“mean”, “std_dev”)
result2

3.	Use descriptive activity name to name the activityies in the data set
activityTrain <- read.table("Downloads/UCI HAR Dataset/train/y_train.txt")
activityTest <- read.table("Downloads/UCI HAR Dataset/test/y_test.txt")
activityAll <- rbind(activityTrain, activityTest)

activityLabel <- read.table("Downloads/UCI HAR Dataset/activity_labels.txt")
activity <- merge(activityAll, activityLabel)
% Keep activity name only
activity <- activity[c(“V2”)]
colnames(activity) <- c("actName")
%	var 'activity' stores the list of activity	

#4.	Join activity & subject to the data list
subjectTrain <- read.table("Downloads/UCI HAR Dataset/train/subject_train.txt")
subjectTest <- read.table("Downloads/UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(subjectTrain, subjectTest)
colnames(subject) <- c("subject")

%	Assign variable names
all <- cbind(rawAll, activity, subject)
all <- all[c(seq(1,561), “actName”, “subject”)

%5.	Create a tiny data set with the average of each variable for each activity and each subject (to finalResult)
allMelt <- melt(all, id=c(“actName”, “subject”), measure.vars=seq(1,561))
finalResult <- dcast(allMelt, actName + subject ~ variable, mean)


