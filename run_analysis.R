## Loads libraries
library(dplyr)


## MERGES TRAINING & TEST SETS TO CREATE ONE DATA SET

## Initializes file path
path2data <- "./Data/UCI HAR Dataset"
numfiles <- 3
testfiles <- c("test/subject_test.txt", "test/X_test.txt", "test/Y_test.txt")
trainfiles <- c("train/subject_train.txt", "train/X_train.txt", "train/Y_train.txt")

## Initializes vars
test.data <- NULL
train.data <- NULL

## Reads test and train data
for (i in 1:3) {
  test.data[[i]] <- read.table(paste(path2data, testfiles[i], sep = "/"), header = FALSE)
  train.data[[i]] <- read.table(paste(path2data, trainfiles[i], sep = "/"), header = FALSE)
}

## Merges test.df and train.df
test.data <- as.data.frame(test.data)
train.data <- as.data.frame(train.data)
df.infocus <- rbind(test.data, train.data)


## EXTRACTS ONLY MEASUREMENTS ON THE MEAN AND SD FOR EACH MEASUREMENT

## Determines feature names from features.txt
featurefile <- "features.txt"
feature.names <- read.table(paste(path2data, featurefile, sep = "/"), header = FALSE, na.strings = NA, stringsAsFactors = FALSE)

## Adds col names onto testtrain.data
colnames(df.infocus)[1] <- "subject"
colnames(df.infocus)[2:562] <- c(feature.names[1:561, 2])
colnames(df.infocus)[563] <- "activity"

## Forces unique column names with syntactically valid names
valid.names <- make.names(names=names(df.infocus), unique=TRUE, allow_ = TRUE)
names(df.infocus) <- valid.names

## Keeps only mean & sd for each measurement
df.infocus <- select(df.infocus, matches("subject|activity|mean|std"))


## REPLACES ACTIVITY NUMBERS WITH DESCRIPTIVE ACTIVITY NAMES

## Determines activity names from activity_labels.txt
activityfile <- "activity_labels.txt"
activity.names <- read.table(paste(path2data, activityfile, sep = "/"), header = FALSE, na.strings = NA, stringsAsFactors = FALSE)

## Describes activity by names
## Defines a function that replaces activity with names from activity.names
replace.fn <- function(x) {
  if(x == 1) { activity.names[, 2][1] }
  else if(x == 2) { activity.names[, 2][2] }
  else if(x == 3) { activity.names[, 2][3] }
  else if(x == 4) { activity.names[, 2][4] }
  else if(x == 5) { activity.names[, 2][5] }
  else { activity.names[, 2][6] }
}
## Performs replace.fn on the activity col in testtrain.data
## Replaces activity numbers with descriptive names
df.infocus$activity <- apply(df.infocus[, "activity", drop = FALSE], 1, replace.fn)  # Note that drop = FALSE is used to retain dimensionality of the matrix


## LABEL DATA SET WITH DESCRIPTIVE NAMES
## This step has been addressed already
names(df.infocus)


## CREATES A 2ND TIDY DATA SET WITH AVERAGE OF EACH VAR FOR EACH ACTIVITY & SUBJECT
df.infocus %>%
  group_by(subject, activity) %>%
  summarize_each(funs(mean), -c(subject, activity)) -> averages

write.table(averages, "./Data/output.txt", row.names = FALSE)
