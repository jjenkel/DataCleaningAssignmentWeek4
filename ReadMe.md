---
title: "Getting And Cleaning Data - Week 4 Assignment"
author: "jjenkel"
date: "December 21, 2016"
output: html_document
---

##Human Activity Recognition Using Smartphones Dataset
###Version 1.0  

##ReadMe Addendum 

This 'ReadMe' Addendum supplements the original ReadMe.txt file that accompanies the dataset named above and used for the Getting And Cleaning Data Course - Week 4 Assignment. The text of the original document has been pasted into this document below (at the end) for easy reference.

The GitHub repository associated with this work can be found at: [Link To GitHub](https://github.com/jjenkel/DataCleaningAssignmentWeek4)

###Overview
The script 'run_analysis' prepares two datasets by reading in and joining together the original motion data collected via Samsung cellphones.  At the end of the loading and joining process the data are in a dataset named 'AllData' (an R data.frame).  The data are then restricted to the measures 'mean' and 'std' as directed by the assignment instructions.  Column names were added and made (more) tidy than in the initial data, but not dramatically to preserve the variable naming conventions used by the original researchers.  The final dataset, named 'AllData' had 10299 observations and 76 variables.  

At the end of the script, averages of the remaining measures by Subject and Activity are calculated and stored to a dataset named 'ResultsData'.  This dataset is also written to a text file in the working directory. The 'ResultsData' dataset contains 180 observations and 75 variables.

###Data Cleaning Details
As instructed for the Getting and Cleaning Data Week 4 Assignment:

* Beginning with the training data
    + the Y variable dataset ("./UCI HAR Dataset/train/Y_train.txt") was loaded along with the activity labels
    + Moving to the X variables for the training data, the X variable dataset was loaded from "./UCI HAR Dataset/train/X_train.txt"
    + The X variable Names (called features here) were loaded and added to the X Variable data frame
    + Then the Subject ID was loaded from: "./UCI HAR Dataset/train/subject_train.txt" and added to the X variable dataset.
    + the Y variables dataset and X variables dataset were joined using cbind() to become the complete training dataset
    + using select() and grepl() a subset of columns was retained that had either the characters: "Subject", "mean", or "Std" in their name.       *NOTE*: the instructions were vague on this point whether or not it was any mention of "Mean" or "Std", or just those where this text comes at the end of the variable name.  I included them all.  Columns with the text 'MeanFreq' included becaues they have "Mean" in them were subsequently dropped to arrive at the final set of measure to take forward.

* The exact same steps outlined in the above 6 steps were conducted on the test data, changing filenames, paths, and dataset names as needed to create the complete test dataset.
    
* The training dataset and test dataset were appended together to create the complete dataset, 'AllData'.
    
* As the final step, the Activity labels were loaded and matched to their coded values using merge(). The label was named "ActivityDesc".
    
* To preserve much of the original variable naming structure not many changes to variable names were made. 
*NOTE*: my personal preference is to use TitleCasing, so variable names were changed to be more like that style.  The list of variable name transformations follows:
    + '-mean' changed with gsub() to 'Mean'
    + '-std' changed with gsub() to 'Std'
    + 'angle' changed with gsub() to 'Angle'
    + 'gravity' changed with gsub() to 'Gravity'
    + str_replace_all(tmpNames,"[:punct:]|[:space:]","") was used to replace all whitespace and punctuation

* A new dataset containing the summarized data (average for each variable) by subject and activity was created and written to file (ResultsData.txt)  

###Codebook
With regard to the full dataset (AllData) the only changes were the dropping or renaming of columns.  With that in mind the original codebook is still applicable to that data.  The changes in variable names were not so severe as to prevent mapping the variables here back to those contributed by the original researchers.  The original variable definitions can be found in the 'UCI HAR Dataset' sub-folder of the GitHub repository [(here)](https://github.com/jjenkel/DataCleaningAssignmentWeek4/tree/master/UCI%20HAR%20Dataset) in the files named features.txt and features_info.txt.

The new Results dataset can be simply described as a mean within Subject and Activity for each of the 73 measures remaining in the 'AllData' dataset.  Those 73 measures can be mapped back to the original data definitions as well.



###THE ORIGINAL README FILE  

Human Activity Recognition Using Smartphones Dataset  
Version 1.0  
========================================  
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  
Smartlab - Non Linear Complex Systems Laboratory  
DITEN - Universit? degli Studi di Genova.  
Via Opera Pia 11A, I-16145, Genoa, Italy.  
activityrecognition@smartlab.ws  
www.smartlab.ws  
========================================  

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.  

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======  
- Features are normalized and bounded within [-1,1].  
- Each feature vector is a row on the text file.  

For more information about this dataset contact: activityrecognition@smartlab.ws  

License:  
========  
Use of this dataset in publications must be acknowledged by referencing the following publication [1]   

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
