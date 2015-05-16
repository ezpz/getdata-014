
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
    # TODO mutate the data to add new column (activity) based on these results
}

#
# Extract the subject ID for the tests.
# [path] Relative path to the subject_test.txt file
# return: A vecotr of numeric IDs
extractSubjects <- function(path) {
    # TODO mutate the data to add new column (subject) based on these results
}

# Directory containing the data from the tests.
dataLocation <- 'UCI HAR Dataset'

