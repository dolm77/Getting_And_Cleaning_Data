#Step1. Merges the training and the test sets to create one data set.
#Read and combine data into dataframes
X_train <- read.table("X_train.txt")
X_test <- read.table("X_test.txt")
X_Data <- rbind(X_train, X_test)
dim(X_Data)

#Read and combine data into dataframes
Y_train <- read.table("y_train.txt")
Y_test <- read.table("y_test.txt")
Y_Data <- rbind(Y_train, Y_test)
dim(Y_Data)  

#Read and combine data into dataframes
S_train <- read.table("subject_train.txt")
S_test <- read.table("subject_test.txt")
S_Data <- rbind(S_train, S_test)
dim(S_Data)  

# Step2. Extracts only the measurements on the mean and standard
# deviation for each measurement.
features <- read.table("features.txt")
dim(features)  

#Create an integer vector of index of the good features dataframe 
Mean_Std_Indices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(Mean_Std_Indices) # 66
X_Data <-X_Data[, Mean_Std_Indices]
dim(X_Data)  
names(X_Data) <- gsub("\\(\\)", "", features[Mean_Std_Indices, 2])  
names(X_Data) <- gsub("mean", "Mean", names(X_Data))  
names(X_Data) <- gsub("std", "Std", names(X_Data))  
names(X_Data) <- gsub("-", "", names(X_Data))  

# Step3. Uses descriptive activity names to name the activities in
# the data set
Activity_Label <- read.table("activity_labels.txt")
Activity_Label[, 2] <- tolower(gsub("_", "", Activity_Label[, 2]))
substr(Activity_Label[2, 2], 8, 8) <- toupper(substr(Activity_Label[2, 2], 8, 8))
substr(Activity_Label[3, 2], 8, 8) <- toupper(substr(Activity_Label[3, 2], 8, 8))
ActivityLabel <- Activity_Label[Y_Data[, 1], 2]
Y_Data[, 1] <- ActivityLabel
names(Y_Data) <- "activity"

# Step4. Appropriately labels the data set with descriptive activity
# names.
names(S_Data) <- "subject"
Cleaned_Data <- cbind(S_Data, Y_Data, X_Data)
dim(Cleaned_Data)  
write.table(Cleaned_Data, "Merged_Dataset.txt")  

# Step5. Creates a second, independent tidy data set with the average of
# each variable for each activity and each subject.
subjectLen <- length(table(S_Data))  
activityLen <- dim(Activity_Label)[1]  
columnLen <- dim(Cleaned_Data)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen)
result <- as.data.frame(result)
colnames(result) <- colnames(Cleaned_Data)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(S_Data)[, 1])[i]
    result[row, 2] <- Activity_Label[j, 2]
    bool1 <- i == Cleaned_Data$subject
    bool2 <- Activity_Label[j, 2] == Cleaned_Data$Activity_Label
    result[row, 3:columnLen] <- colMeans(Cleaned_Data[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}
head(result)
write.table(result, "Data_With_Means.txt") # write out the 2nd dataset
