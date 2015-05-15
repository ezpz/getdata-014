
library (dplyr)
library (tidyr)

#
# Extract the contents of X_test.txt from the provided path
# [path] Relative path to the X_test.txt file
# return: a data.frame converted to a tbl_df
extractData <- function(path) {
    # TODO 
    # NOTE: See  select(contains="...")  for obtaining only mean and std. dev.
}

#
# Maps the values in y_test.txt to a vector of factors. Uses
# data found in activity_labels.txt
# [path] Relative path to the y_test.txt file
# [lables_file] Relative path to the activity_labels.txt file
# return: a vector of factors
extractActivity <- function(path, labels_file) {
    # TODO 
}

#
# Extract the subject ID for the tests.
# [path] Relative path to the subject_test.txt file
# return: A vecotr of numeric IDs
extractSubjects <- function(path) {
    # TODO 
}

# Directory containing the data from the tests.
dataLocation <- 'UCI HAR Dataset'

