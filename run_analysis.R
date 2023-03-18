library(dplyr)

file <- "UCI Data.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists(file)){
  download.file(url, "UCI Data.zip")
  }

if(!file.exists("UCI HAR Dataset"))
{
  unzip(file)
}
  

#loading descriptive data
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "feature"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("labels", "activity"))

#TrainSet
subjectstrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xtrainset <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
ytrainset <- read.table("UCI HAR Dataset/train/y_train.txt",col.names = "labels")


xtrainset <-xtrainset %>% mutate("subject" = subjectstrain$subject) %>%
  mutate("labels" = ytrainset$labels) %>% left_join(activities) %>%
  select(-c("labels", "labels"))


#Testset
subjectstest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
xtestset <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
ytestset <- read.table("UCI HAR Dataset/test/y_test.txt",col.names = "labels")

xtestset <- xtestset %>% mutate("subject" = subjectstest$subject) %>%
  mutate("labels" = ytestset$labels) %>% left_join(activities) %>%
  select(-c("labels", "labels"))

#Merging and dropping irrelevant datasets
merged_set <- bind_rows(xtrainset, xtestset)
rm(xtrainset, ytrainset, ytestset, xtestset, features, activities, subjectstest, subjectstrain)

#using grep to select the std, mean subject and activity columns
selectset <- merged_set %>% select(grep("std|mean|subject|activity", names(merged_set)))
rm(merged_set)

Namedset <- selectset
names(Namedset) <- gsub("std", "Std", names(Namedset))
names(Namedset) <- gsub("BodyBody", "Body", names(Namedset)) 
names(Namedset) <- gsub("^t", "Time", names(Namedset)) 
names(Namedset) <- gsub("Freq", "Frequency", names(Namedset))
names(Namedset) <- gsub("^f", "Frequency", names(Namedset))
names(Namedset) <- gsub("mean", "Mean", names(Namedset))
names(Namedset) <- gsub("Acc", "Accelerometer", names(Namedset)) 
names(Namedset) <- gsub("Gyro", "Gyroscope", names(Namedset)) 
names(Namedset) <- gsub("Mag", "Magnitude", names(Namedset))
names(Namedset) <- gsub("\\.", "", names(Namedset))
rm(selectset)

Finalset <- Namedset %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))
names(Finalset)[-c(1:2)] <- gsub("^", "Average", names(Finalset)[-c(1:2)])
write.table(Finalset, "Analysis_Data.txt", row.names = FALSE)