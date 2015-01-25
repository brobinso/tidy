## Explanation of run_analysis.r
The script first downloads and unpacks the zip files, then reads in two files: the test dataset "X_test.txt" the train dataset "X_train.txt". The resulting data frames are row-bound together to create a single 10,000+ row dataset. Next, 2 more datasets are created from the "Y_test" and "Y_train" files. These datasets make up a column defining the activity being done during the observation (Walking, Sitting, Walking upstairs, Walking downstairs, Standing, Laying). Finally, a column for which Subject goes with which observation was created by reading the files "Subject_test" and "Subject_train". After massaging the types to coerce subject and activity to type "factor", the 3 dataframes are column-bound together.

The column names come from more dataframe creation and manipulation. "Features.txt" is read in, which has all variable names. I added Subject and Activity, then applied this dataframe as the names of the master dataframe (e.g., "names(dfrm)<-features"). The master data frame (dfrm) is further subsetted to remove any columns not pertaining to "mean" or "std" by using grep.

Analysis of the resulting subset is done in dplyr. First, I grouped the results by activity and summarized with mean, sd. I repeated this grouping by Activity. The results of those to summaries are bound into the final deliverable, a 36x159 dataframe "tidy_df"

## Codebook - tidy_df
### Variable names
Of the original list of 561 variables provided in the test and train datasets, I filtered out those columns not pertaining to "mean" or "stdev" statistics. This left 79 of the original variables, and I added the 36-level factor variable "Category" to capture the 30 different subjects and 6 different activities. Finally, for each each of the original 79 variables I calculated mean and standard deviation, grouped by Category factor, and assigned the results to "tidy_df". For example, row 4 of tidy_df shows the statistics for Subject10, and has the mean and standard deviation of all of Subject10's original mean/sd statistics. To further illustrate,
tidy_df[4,6] displays:

  tBodyAcc-mean()-Z_mean tBodyAcc-std()-X_mean
1             -0.1113015            -0.5378077

The first column is the mean of all the "tBodyAcc-mean()-Z_mean" measurements from the original data for Subject 10, and the second column is the mean of all the "tBodyAcc-std()-X_mean" measurements from the original data for Subject 10. So the original variable "tBodyAcc-std()-X" was a standard deviation statistic calculated from the observed measurements, and I have then taken the mean of all those standard deviations for this subject.

  [1] "Category"                             "tBodyAcc-mean()-X_mean"               "tBodyAcc-mean()-Y_mean"               "tBodyAcc-mean()-Z_mean"              
  [5] "tBodyAcc-std()-X_mean"                "tBodyAcc-std()-Y_mean"                "tBodyAcc-std()-Z_mean"                "tGravityAcc-mean()-X_mean"           
  [9] "tGravityAcc-mean()-Y_mean"            "tGravityAcc-mean()-Z_mean"            "tGravityAcc-std()-X_mean"             "tGravityAcc-std()-Y_mean"            
 [13] "tGravityAcc-std()-Z_mean"             "tBodyAccJerk-mean()-X_mean"           "tBodyAccJerk-mean()-Y_mean"           "tBodyAccJerk-mean()-Z_mean"          
 [17] "tBodyAccJerk-std()-X_mean"            "tBodyAccJerk-std()-Y_mean"            "tBodyAccJerk-std()-Z_mean"            "tBodyGyro-mean()-X_mean"             
 [21] "tBodyGyro-mean()-Y_mean"              "tBodyGyro-mean()-Z_mean"              "tBodyGyro-std()-X_mean"               "tBodyGyro-std()-Y_mean"              
 [25] "tBodyGyro-std()-Z_mean"               "tBodyGyroJerk-mean()-X_mean"          "tBodyGyroJerk-mean()-Y_mean"          "tBodyGyroJerk-mean()-Z_mean"         
 [29] "tBodyGyroJerk-std()-X_mean"           "tBodyGyroJerk-std()-Y_mean"           "tBodyGyroJerk-std()-Z_mean"           "tBodyAccMag-mean()_mean"             
 [33] "tBodyAccMag-std()_mean"               "tGravityAccMag-mean()_mean"           "tGravityAccMag-std()_mean"            "tBodyAccJerkMag-mean()_mean"         
 [37] "tBodyAccJerkMag-std()_mean"           "tBodyGyroMag-mean()_mean"             "tBodyGyroMag-std()_mean"              "tBodyGyroJerkMag-mean()_mean"        
 [41] "tBodyGyroJerkMag-std()_mean"          "fBodyAcc-mean()-X_mean"               "fBodyAcc-mean()-Y_mean"               "fBodyAcc-mean()-Z_mean"              
 [45] "fBodyAcc-std()-X_mean"                "fBodyAcc-std()-Y_mean"                "fBodyAcc-std()-Z_mean"                "fBodyAcc-meanFreq()-X_mean"          
 [49] "fBodyAcc-meanFreq()-Y_mean"           "fBodyAcc-meanFreq()-Z_mean"           "fBodyAccJerk-mean()-X_mean"           "fBodyAccJerk-mean()-Y_mean"          
 [53] "fBodyAccJerk-mean()-Z_mean"           "fBodyAccJerk-std()-X_mean"            "fBodyAccJerk-std()-Y_mean"            "fBodyAccJerk-std()-Z_mean"           
 [57] "fBodyAccJerk-meanFreq()-X_mean"       "fBodyAccJerk-meanFreq()-Y_mean"       "fBodyAccJerk-meanFreq()-Z_mean"       "fBodyGyro-mean()-X_mean"             
 [61] "fBodyGyro-mean()-Y_mean"              "fBodyGyro-mean()-Z_mean"              "fBodyGyro-std()-X_mean"               "fBodyGyro-std()-Y_mean"              
 [65] "fBodyGyro-std()-Z_mean"               "fBodyGyro-meanFreq()-X_mean"          "fBodyGyro-meanFreq()-Y_mean"          "fBodyGyro-meanFreq()-Z_mean"         
 [69] "fBodyAccMag-mean()_mean"              "fBodyAccMag-std()_mean"               "fBodyAccMag-meanFreq()_mean"          "fBodyBodyAccJerkMag-mean()_mean"     
 [73] "fBodyBodyAccJerkMag-std()_mean"       "fBodyBodyAccJerkMag-meanFreq()_mean"  "fBodyBodyGyroMag-mean()_mean"         "fBodyBodyGyroMag-std()_mean"         
 [77] "fBodyBodyGyroMag-meanFreq()_mean"     "fBodyBodyGyroJerkMag-mean()_mean"     "fBodyBodyGyroJerkMag-std()_mean"      "fBodyBodyGyroJerkMag-meanFreq()_mean"
 [81] "tBodyAcc-mean()-X_sd"                 "tBodyAcc-mean()-Y_sd"                 "tBodyAcc-mean()-Z_sd"                 "tBodyAcc-std()-X_sd"                 
 [85] "tBodyAcc-std()-Y_sd"                  "tBodyAcc-std()-Z_sd"                  "tGravityAcc-mean()-X_sd"              "tGravityAcc-mean()-Y_sd"             
 [89] "tGravityAcc-mean()-Z_sd"              "tGravityAcc-std()-X_sd"               "tGravityAcc-std()-Y_sd"               "tGravityAcc-std()-Z_sd"              
 [93] "tBodyAccJerk-mean()-X_sd"             "tBodyAccJerk-mean()-Y_sd"             "tBodyAccJerk-mean()-Z_sd"             "tBodyAccJerk-std()-X_sd"             
 [97] "tBodyAccJerk-std()-Y_sd"              "tBodyAccJerk-std()-Z_sd"              "tBodyGyro-mean()-X_sd"                "tBodyGyro-mean()-Y_sd"               
[101] "tBodyGyro-mean()-Z_sd"                "tBodyGyro-std()-X_sd"                 "tBodyGyro-std()-Y_sd"                 "tBodyGyro-std()-Z_sd"                
[105] "tBodyGyroJerk-mean()-X_sd"            "tBodyGyroJerk-mean()-Y_sd"            "tBodyGyroJerk-mean()-Z_sd"            "tBodyGyroJerk-std()-X_sd"            
[109] "tBodyGyroJerk-std()-Y_sd"             "tBodyGyroJerk-std()-Z_sd"             "tBodyAccMag-mean()_sd"                "tBodyAccMag-std()_sd"                
[113] "tGravityAccMag-mean()_sd"             "tGravityAccMag-std()_sd"              "tBodyAccJerkMag-mean()_sd"            "tBodyAccJerkMag-std()_sd"            
[117] "tBodyGyroMag-mean()_sd"               "tBodyGyroMag-std()_sd"                "tBodyGyroJerkMag-mean()_sd"           "tBodyGyroJerkMag-std()_sd"           
[121] "fBodyAcc-mean()-X_sd"                 "fBodyAcc-mean()-Y_sd"                 "fBodyAcc-mean()-Z_sd"                 "fBodyAcc-std()-X_sd"                 
[125] "fBodyAcc-std()-Y_sd"                  "fBodyAcc-std()-Z_sd"                  "fBodyAcc-meanFreq()-X_sd"             "fBodyAcc-meanFreq()-Y_sd"            
[129] "fBodyAcc-meanFreq()-Z_sd"             "fBodyAccJerk-mean()-X_sd"             "fBodyAccJerk-mean()-Y_sd"             "fBodyAccJerk-mean()-Z_sd"            
[133] "fBodyAccJerk-std()-X_sd"              "fBodyAccJerk-std()-Y_sd"              "fBodyAccJerk-std()-Z_sd"              "fBodyAccJerk-meanFreq()-X_sd"        
[137] "fBodyAccJerk-meanFreq()-Y_sd"         "fBodyAccJerk-meanFreq()-Z_sd"         "fBodyGyro-mean()-X_sd"                "fBodyGyro-mean()-Y_sd"               
[141] "fBodyGyro-mean()-Z_sd"                "fBodyGyro-std()-X_sd"                 "fBodyGyro-std()-Y_sd"                 "fBodyGyro-std()-Z_sd"                
[145] "fBodyGyro-meanFreq()-X_sd"            "fBodyGyro-meanFreq()-Y_sd"            "fBodyGyro-meanFreq()-Z_sd"            "fBodyAccMag-mean()_sd"               
[149] "fBodyAccMag-std()_sd"                 "fBodyAccMag-meanFreq()_sd"            "fBodyBodyAccJerkMag-mean()_sd"        "fBodyBodyAccJerkMag-std()_sd"        
[153] "fBodyBodyAccJerkMag-meanFreq()_sd"    "fBodyBodyGyroMag-mean()_sd"           "fBodyBodyGyroMag-std()_sd"            "fBodyBodyGyroMag-meanFreq()_sd"      
[157] "fBodyBodyGyroJerkMag-mean()_sd"       "fBodyBodyGyroJerkMag-std()_sd"        "fBodyBodyGyroJerkMag-meanFreq()_sd" 