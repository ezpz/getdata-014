# getdata-014: Course Project

## Assumptions
1. The `run_analysis.R` script expects a subdirectory named `USCI HAR Dataset`. This is the case if you download the ZIP file linked to in the assignment page and unzip it in the same directory as the `run_analysis.R` script.
2. A recent version of `dplyr` and `R` are required. Specifically, this script was tested with `R` version 3.2.0 and `dplyr` version 0.4.1. A version of `dplyr` that supports `summarise_each` is required.

## Included Files
1. `run_analysis.R`: The main script that parses and processes the target dataset.
2. `CodeBook.md`: Description of the data output of `run_analysis.R`.
3. `README.md`: This file.


## Details
The `run_analysis.R` script can be run standalone or sourced from within `R` istelf. It is likely more useful to source the script so that the resulting tidy data remains in the environment for further manipulation and/or examination. 

For example, in the following example, the variable `tidy` remains in the current environment:

    $ /usr/bin/R
    > source ('run_analysis.R')
    ... snip ...
    

One could now execute the following to get the entire table written to file:

    > write.table (tidy, file='tidy.txt', row.names=FALSE)

## Notes
There is a debug flag the enables/disables debugging output of `run_analysis.R`. The variable `doDebug` can be set to `TRUE` or `FALSE` to enable or disable debugging output, respecitively.

### Processing Notes

In either of the {test|train} directories these are the data:

    X_{test|train}.txt:
        Each row is a 561 element vector representing the features listed
        in features.txt. 
        According to the assignment, we only need information related to the 
        mean and std. dev. (columns that contain 'mean()' or 'std()' 
        as described in features_info.txt)
        A quick grep shows 33 of each type in features.txt.

    y_{test|train}.txt:
        Each row represents the type of activity for each entry in 
        X_{test|train}.txt.
        These numeric values are explained (i.e. mapped to text) in 
        activity_labels.txt

    subject_{test|train}.txt:
        The ID of the test subject for each entry in X_{test|train}.txt.

    Inertial Signals/*:
        The original unprocessed data. I believe this is informational only
        and can be excluded from the processing. R on a 32-bit system will 
        not be capable of loading all this data @ nine 6M and nine 15M files 
        for the test and training data, respectively.
        
