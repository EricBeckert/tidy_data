# Analysis explanation
The UCI Machine Learning Repository contains data from an experiment on human activity recognition using a smartphone accelerometer. The data is divided into a train set and a test set, plus several text files for labelling and desciption of the data. 

Information about this experiment and its data can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The object of the current analysis is to:
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

# Script
All processing is done in 1 single R script:
run_analysis.R

Before running the script, the experiment data should be downloaded from the above mentioned website and unzipped to a local folder. In the initialization block the working directory should be set to the root directory of the downloaded experiment data set ("UCI HAR Dataset"). 

After running the script, the workingdirectory will contain a text file "tidy_set_week4.txt". This is a tidy data set of a "long" form, as described in the CODEBOOK.md file in this repository.
