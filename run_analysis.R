
library (dplyr)
library (tidyr)

doDebug <- TRUE

#
# Debug trace 
trace <- function(msg) {
    if (doDebug) {
        print(msg)
    }
}

#
# Extract the contents of X_test.txt from the provided path
# [path] Relative path to the X_test.txt file
# [feature_file] Relative path to features.txt
# return: a data.frame converted to a tbl_df
extractData <- function(path, feature_file) {

    trace (sprintf ("Reading features    : '%s'", feature_file))
    f <- read.table (feature_file, header=FALSE)
    f <- tbl_df (f)

    # Select only the rows that represent mean or std. dev values
    f.mean <- filter (f, grepl("mean\\(\\)", V2))
    f.std <- filter (f, grepl("std\\(\\)", V2))

    # Take the indicies and arrange them in order to use in the next select
    ordered <- 
        rbind (f.mean, f.std) %>% 
        select (V1) %>% 
        arrange (V1)
    indicies <- ordered$V1

    trace (sprintf ("Reading test results: '%s'", path))
    d <- read.table (path, header=FALSE)
    d <- tbl_df (d)

    # Extract and return the columns indicated by the previous 
    # feature calculation
    data <- select (d, indicies)
    # FIXME: This may need to use the text names instead of the numbers
    # TODO: 
    names (data) <- indicies
    data
}

#
# Maps the values in y_test.txt to a vector of factors. Uses
# data found in activity_labels.txt
# [path] Relative path to the y_test.txt file
# [lables_file] Relative path to the activity_labels.txt file
# return: a vector of factors
extractActivity <- function(path, labels_file) {

    trace (sprintf ("Reading labels     : '%s'", labels_file))
    lab <- read.table (labels_file, header=FALSE)
    actName <- function (idx) { lab[idx,2] }

    trace (sprintf ("Reading activites  : '%s'", path))
    act <- read.table (path, header=FALSE)
    as.factor (actName (act[,1]))
}

#
# Extract the subject ID for the tests.
# [path] Relative path to the subject_test.txt file
# return: A vecotr of numeric IDs
extractSubjects <- function(path) {
    # TODO mutate the data to add new column (subject) based on these results
}

# Set up the locations of the data we will process
dataLocation <- 'UCI HAR Dataset'
features <- sprintf ("%s/features.txt", dataLocation)
labels <- sprintf ("%s/activity_labels.txt", dataLocation)
data.test <- sprintf ("%s/test/X_test.txt", dataLocation)
data.train <- sprintf ("%s/train/X_test.txt", dataLocation)
activity.test <- sprintf ("%s/test/y_test.txt", dataLocation)
activity.train <- sprintf ("%s/train/y_test.txt", dataLocation)
subject.test <- sprintf ("%s/test/subject_test.txt", dataLocation)
subject.train <- sprintf ("%s/train/subject_test.txt", dataLocation)

# Start with the test data
trace ("Processing test data")
data <- extractData (data.test, features)
activity <- extractActivity (activity.test, labels)
data <- mutate (data, activity = activity)
subjects <- extractSubjects (subject.test)
data <- mutate (data, subject = subjects)

