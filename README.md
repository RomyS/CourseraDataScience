======================================================
Getting and Cleaning Data Course Project by R Susvilla
Version 1.0
======================================================

The data source for this project is the Human Activity Recognition Using Smartphones Dataset downloaded
from this website - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The script to tidy up the data is in run_analysis.R.

The output dataset is tidydata.txt with documentation in CodeBook.md.

Here's a summary of the extraction and transformation process done on the input data to come up with the
the tidy data set.

1. Merged the training and the test data sets to create one data set.  Used the the subject, X, and y text
   files from the test and train folders.  The activity labels were added using the activity_labels.txt file.
  
2. Extracted only the variables that are measurements for mean and standard deviations.  This was done by 
   selecting only those variables with mean or std in the features.txt file.  Those variables with meanFreq
   were excluded.
   
3. Renamed the mean and std variable names to descriptive names. All variables starting with "t" were renamed with
   prefix of "time".  All variables starting with "f" were renamed with a prefix of "fft" for Fast Fourier Transform.
   All "-" and "()" were removed.  All upper caps were changed to lower caps.
   
4. A summary with the average of each variable for each activity and subject was created.


