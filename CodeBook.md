# CodeBook
This codebook describes  
1. Current Variables in Analysis_Data.txt  
2. The method run_analysis.R uses to process the UCI HAR dataset into Analysis_Data.txt  

## Analysis_Data.txt Variables  
This dataset contains the averages of the means and standard deviations from the UCI HAR dataset. The full dataset can be found at
[UCI](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  
These averages are sorted by the subject, and the activity they were performing at the time of logging. As all measurements are averages, all columns start with Average.  
More technical details regarding the contents of the final data file are found in the downloaded UCI HAR Dataset under "feature_info"  

## run_analysis.R  
This code uses dplyr for managing dataframes.  
1. First the UCI HAR dataset is downloaded and unzipped into a folder.  
2. The features and activities are loaded into dataframes using read.table().  
3. The training and test sets are loaded and given the features as column names.
4. The subjects and the activity numbers(y_test) are joined to the train/test frames using Mutate. The activity numbers are then used to left join the activities to the frames. Finally the activity numbers are dropped.  
5. Using bind_rows() the train and test sets are combined.  
6. Using grep() on the column names, the mean and standard deviation columns are selected. The subject and activities column are also preserved, and the rest is discarded.  
7. Column names are changed in the following ways using gsub in order:    
  -std to Std  
  -BodyBody to Body, this was a typographical error in the original columns  
  -"^t" with Time
  -Freq with Frequency
  -"^f" with Frequency 
  -mean with Mean
  -Acc with Accelerometer 
  -Gyro with Gyroscope
  -Mag with Magnitude
  -"\\." with "", this removes the extra .s  
8. Finally the variables are grouped by subject and activity, and summarized with means. The output table is then generated. 