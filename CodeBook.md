Getting and Cleaning Data Course Project CodeBook

This file describes variables, the data, and work that I have performed to tidy up the data.
    
The site where the data was obtained:
-http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project:
-https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    
The run_analysis.R script performs the following steps to clean the data:
        
Read X_train.txt, y_train.txt and subject_train.txt from the default directory to which it has been in set in R to stores them as merged datasets in X_Data, Y_Data and S_Data respectively.
        
Read the features.txt file from default directory to which it has been set to in R and stores the data in a variable called features. We only extract the measurements on the mean and standard deviation. We get a subset of X_Data with the corresponding columns.
        
Clean the column names of the subset. 
We remove the "()" and "-" symbols in the names, 
as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.
        
Read the activity_labels.txt file from default directory to which it has been set to in R and store the data in a variable called Activity_Label.
        
Clean the activity names in the second column of activity. 
We first make all names to lower cases. 
If the name has an underscore between letters, 
we remove the underscore and capitalize the letter immediately after the underscore.
        
Transform the values of Y_Data according to the Activity_Label data frame.
        
Combine the S_Data, Y_Data and X_Data by column to get a new cleaned data frame, Cleaned_Data. 
Properly name the first two columns, "subject" and "activity". 
The "subject" column contains integers that range from 1 to 30 inclusive; 
the "activity" column contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1 exclusive.
        
Write the Cleaned_Data out to "Merged_Dataset.txt" file in current working directory.
        
Finally, generate a second independent tidy data set with the average of each measurement for each activity and each subject. 
We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. 
Then, for each combination, we calculate the mean of each measurement with the corresponding combination. 
So, after initializing the result data frame and performing the two for-loops, we get a 180x68 data frame.
        
Write the result out to "Data_With_Means.txt" file in current working directory.