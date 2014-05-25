## Coursera Getting and Cleaning Data Course Project.

## Merge the training and the test sets to create one data set.
## Use descriptive activity names to name the activities in the data set.

## Process Test files.
    ## Read subject file.
    testsubj <- "/users/rsusvilla/documents/coursera/UCI HAR Dataset/test/subject_test.txt"
    dftestsubj <- read.table(testsubj,col.names=c("subject"))
    
    ## Read X data file.
    testx <- "/users/rsusvilla/documents/coursera/UCI HAR Dataset/test/X_test.txt"
    dftestx <- read.table(testx,sep="")
    
    ## Read activity label file.
    actfile <- "/users/rsusvilla/documents/coursera/UCI HAR Dataset/activity_labels.txt"
    activity <- read.table(actfile, sep="", col.names=c("activitycode", "activity"))
    
    ## Read y activity file.
    testy <- "/users/rsusvilla/documents/coursera/UCI HAR Dataset/test/y_test.txt"
    dftesty <- read.table(testy,sep="", col.names=c("activitycode"))
    
    ## Merge activity file with activity label file.
    dftesty <- merge(dftesty,activity,by.x="activitycode",by.y="activitycode")
    
    ## Combine subject, activity and data columns.
    dftestxy <- cbind(dftestsubj,dftesty,dftestx)

## Process Training Files.
    ## Read subject file.
    trainsubj <- "/users/rsusvilla/documents/coursera/UCI HAR Dataset/train/subject_train.txt"
    dftrainsubj <- read.table(trainsubj,col.names=c("subject"))
    
    ## Read X data file.
    trainx <- "/users/rsusvilla/documents/coursera/UCI HAR Dataset/train/X_train.txt"
    dftrainx <- read.table(trainx,sep="")
    
    ## Read activity label file.
    actfile <- "/users/rsusvilla/documents/coursera/UCI HAR Dataset/activity_labels.txt"
    activity <- read.table(actfile, sep="", col.names=c("activitycode", "activity"))
    
    ## Read y activity file.
    trainy <- "/users/rsusvilla/documents/coursera/UCI HAR Dataset/train/y_train.txt"
    dftrainy <- read.table(trainy,sep="", col.names=c("activitycode"))
    
    ## Merge activity file with activity label file.
    dftrainy <- merge(dftrainy,activity,by.x="activitycode",by.y="activitycode")
    
    ## Combine subject, activity and data columns.
    dftrainxy <- cbind(dftrainsubj,dftrainy,dftrainx)

## Combine Test and Training data files.
dfcombined <- rbind(dftestxy, dftrainxy)

## Extract only the measurements on the mean and standard deviation for each measurement. 

    ## Read features file.
    featfile <- "/users/rsusvilla/documents/coursera/UCI HAR Dataset/features.txt"
    dffeatures <- read.table(featfile,sep="")
    ## Extract mean measurement variable names.
    meanx <- grep("mean()",dffeatures$V2,fixed=T)
    ## Extract standard deviation measurement variable names.
    std <- grep("std()",dffeatures$V2,fixed=T)
    ## Combine mean and std variable names, sorted by column number.    
    meanstd <- sort(c(meanx,std))
    ## Filter mean and std columns from combined data files.
    meanstdcol <- paste("V",meanstd,sep="")
    dffiltered <- dfcombined[, c("subject","activitycode", "activity", meanstdcol)]

## Rename variable names with descriptive measurement names.
    
    ## Filter out the measurements for mean and std.
    measvar <- dffeatures[meanstd,]
    ## Replace the first "t" to "time" in the variable name.
    renamedvar <- sub("^t","time",measvar$V2)
    ## Replace the first "f" to "fft" (for Fast Fourier Transform) in the variable name.
    renamedvar <- sub("^f","fft",renamedvar)
    ## Remove "-".
    renamedvar <- gsub("-","",renamedvar)
    ## Remove "()".
    renamedvar <- gsub("()","",renamedvar,fixed=T)
    ## Change all upper caps to lower caps.
    renamedvar <- tolower(renamedvar)
    ## Assign the renamed column names.
    colnames(dffiltered) <- c("subject","activitycode", "activity", renamedvar)
    
## Summarize the dataset with the average of each variable for each activity and each subject.
    
    library(reshape2)
    dfmelt <- melt(dffiltered,id=c("subject", "activitycode", "activity"),measure.vars=renamedvar)
    tidydata <- dcast(dfmelt, subject+activitycode+activity ~ variable, mean)
    write.table(tidydata,"/users/rsusvilla/documents/coursera/tidydata.txt")
