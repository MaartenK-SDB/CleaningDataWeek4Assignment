# Getting and Cleaning Data Course Project

This repository is my submission(MR K) for the Getting and Cleaning Data
Course Project. The data originates from
[UCI](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The researchers attempt to recognize human activities as logged by a
smartphones (Samsung Galaxy S II) placed on participants waists using
the phones embedded accelerometer and gyroscope. For further
information, visit the link above.

Included in this repository are:  
## Files

1.  run_analysis.R  

-   Contains the code that downloads - and processes the data  
-   Merges the training and test datasets  
-   Extracts the relevant columns  
-   Renames the columns with more explicit variable names  
-   Produces a tidy dataset “Analysis_Data.txt”  

2.  README.md  

-   You’re reading this right now!  

3.  CodeBook.md  

-   Describes the new variables found in Analysis_Data.txt, which is
    the result from run_analysis.R

4.  Analysis_Data.txt  

-   The resulting table from run_analysis.R. When loading in R, use
    read.table().
