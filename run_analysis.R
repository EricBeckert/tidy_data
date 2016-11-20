# --------------------------------------
# run_analysis.R
# --------------------------------------
# This script reads a set of data files from an experiment on human actvitity recognition
# by smartphone accelerometers. The script transforms the data into a tidy set with the averages
# of all mean() and std() computation variables.
# --------------------------------------

# --------------------------------------
# 0. Initialization
# --------------------------------------
library(reshape2)
library(dplyr)
# set working directory
setwd("C:/Users/Eric/Coursera/DataScience/3. Get_clean_data/UCI HAR Dataset")

# --------------------------------------
# 1. Read column headers and convert to appropriate descriptive names
# --------------------------------------

df_hdr_names <- read.table("./features.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)

# convert to lowercase and convert dashes, parentheses and commas to underscores
hdr_names <- tolower(gsub("[-(),]", "_", df_hdr_names[, 2])) # keep 2nd column only
# convert multiple underscores to one
hdr_names <- gsub("_{2,}", "_", hdr_names)
# and remove trailing underscores
hdr_names <- gsub("_$", "", hdr_names)

# --------------------------------------
# 2. Process train data set
# --------------------------------------

# read train set activity numbers
y_train <- read.table("./train/y_train.txt", col.names = c("activity_nr")) # activity numbers

# read train set with headers
df_train_src <- read.table("./train/X_train.txt", sep = "", header = FALSE, col.names = hdr_names)
# keep mean and std columns only
df_train <- df_train_src[, grep("(_mean|_std)$", hdr_names)]
# can also be done in one statement
#df_train <- read.table("./train/X_train.txt", sep = "", header = FALSE, col.names = hdr_names)[, grep("(_mean|_std)$", hdr_names)]

# read train subjects
subject_train <- read.table("./train/subject_train.txt", col.names = c("subject_nr"))

# add subject and activity numbers to train set
df_train <- cbind(subject_train, y_train, df_train)

# --------------------------------------
# 3. Process test data set
# --------------------------------------

# read test set activity numbers
y_test <- read.table("./test/y_test.txt", col.names = c("activity_nr")) # activity numbers

# read test set with headers, keep mean and std columns only
df_test <- read.table("./test/X_test.txt", sep = "", header = FALSE, col.names = hdr_names)[, grep("(_mean|_std)$", hdr_names)]

# read test subjects
subject_test <- read.table("./test/subject_test.txt", col.names = c("subject_nr"))

# add subject and activity numbers to test set
df_test <- cbind(subject_test, y_test, df_test)

# --------------------------------------
# 4. Merge train and test set
# --------------------------------------

df_result <- rbind(df_train, df_test)

# add descriptive activity names
act_labels <- read.table("./activity_labels.txt", col.names = c("activity_nr", "activity_name"), stringsAsFactors = FALSE)
df_result <- merge(df_result, act_labels)


# --------------------------------------
# 5. Construct tidy set with averages
# --------------------------------------
# transpose variable columns to rows
df_melt <- melt(df_result, id.vars = c("activity_nr", "activity_name", "subject_nr")) # rest of vars are measures
# compute the mean for every combination of activity_name, subject_nr, variable
df_tidy <- summarise(group_by(df_melt, activity_name, subject_nr, variable), mean_value = mean(value))
# write df to file
write.table(df_tidy, file = "tidy_set_week4.txt", row.name = FALSE)
