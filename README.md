# Getting-and-Cleaning-Data-Course-Project
# Readme

# This code consists of 5 parts, similar to that outlined in course project instructions.
# 1. MERGES TRAINING & TEST SETS TO CREATE ONE DATA SET
# 2. EXTRACTS ONLY MEASUREMENTS ON THE MEAN AND SD FOR EACH MEASUREMENT
# 3. REPLACES ACTIVITY NUMBERS WITH DESCRIPTIVE ACTIVITY NAMES
# 4. LABEL DATA SET WITH DESCRIPTIVE NAMES
# 5. CREATES A 2ND TIDY DATA SET WITH AVERAGE OF EACH VAR FOR EACH ACTIVITY & SUBJECT

# PART 1.
# This part reads in training and test data sets, then merges them into a single data set, df.infocus.

# PART 2.
# This part first determines feature sets as outlined in features.txt, then renames columns with corresponding feature name.
# Because some feature names are unacceptable syntactically, column names are renamed using make.name() so that they are syntatically acceptable and unique.
# From the feature names, the code keeps only features that contain the word "mean" and "sd", as well as "subject", and "activity".

# PART 3.
# This part reads in activity labels from activity_labels.txt, then replaces coresonding activity numbers.

# PART 4.
# This part has been addressed in Part 2.

# PART 5.
# This part groups df.infocus by subjects and activities.
# Then it produces means of each column (ie. measurement, except "subject" and "activity"), and assigns them to "averages"

# Finally, "averages" is written to a space-delimited text file.
