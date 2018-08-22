#set working directory
setwd("C:/Coursera/John Hopkins Data Science/Getting and Cleaning Data/Week 4/R Code")
getwd()

#set nbr of rows to read for testing and final (-1 all rows)
readRows <- -1

#read header
features <- read.table("./data/UCI HAR Dataset/features.txt", sep = "")

Xtestdata <- read.table("./data/UCI HAR Dataset/test/X_test.txt", sep = "", nrows = readRows)
Xtraindata <- read.table("./data/UCI HAR Dataset/train/X_train.txt", sep = "", nrows = readRows)

#merge the test and training data for X
Xtestdata <- rbind(Xtestdata, Xtraindata)

#parse header col2
charFeatures <- as.character(features$V2)

#transpose matrix to vector format
tcharFeatures <- t(charFeatures)

#lables for Xtestdata input
names(Xtestdata) <- as.vector(tcharFeatures)
View(Xtestdata)

#determine indicies for columns with std or mean in name
gstdidx <- grep("std()", tcharFeatures[1, 1:ncol(tcharFeatures)])
gmeanidx <- grep("mean()", tcharFeatures[1, 1:ncol(tcharFeatures)])

idx <- append(gmeanidx, gstdidx)
idxSorted <- sort(idx)

stdmeanColData <- data.frame(check.names = FALSE)
stdmeanTestData <- data.frame(check.names = FALSE)
firstEntry <- TRUE
firstRow <- TRUE

#parse the std and mean data columns 
for (i in 1:nrow(Xtestdata)) {
  for (j in 1:NROW(idxSorted)) {
    if (firstEntry == TRUE) {
      stdmeanColData <- Xtestdata[i, idxSorted[j]]
      firstEntry <- FALSE
    }
    else {
      stdmeanColData <- cbind(stdmeanColData, Xtestdata[i, idxSorted[j]])
    }
  } #end for j
  if (firstRow == TRUE) {
    stdmeanTestData <- stdmeanColData
    firstRow <- FALSE
    rm(stdmeanColData)
    stdmeanColData <- data.frame(check.names = FALSE)
    firstEntry <- TRUE
  }
  else {
    stdmeanTestData <- rbind(stdmeanTestData, stdmeanColData)
    rm(stdmeanColData)
    stdmeanColData <- data.frame(check.names = FALSE)
    firstEntry <- TRUE
  }
}

stdmeanTestData <- as.data.frame((stdmeanTestData))

#lables for std and mean columns
stdmeanNames <- t(tcharFeatures[1, idxSorted])
names(stdmeanTestData) <- as.vector(stdmeanNames)
View(stdmeanTestData)

Ytestdata <- read.table("./data/UCI HAR Dataset/test/y_test.txt", sep = "", nrows = readRows)
Ytraindata <- read.table("./data/UCI HAR Dataset/train/y_train.txt", sep = "", nrows = readRows)

#merge Y data test and train
Ytestdata <- rbind(Ytestdata, Ytraindata)

names(Ytestdata) <- c("Classification")

#Add activity label to Y data
Activity <- as.character(c(1:nrow(Ytestdata)))
for (i in 1:nrow(Ytestdata)) {
  if (Ytestdata[i, 1] == 1) {
    Activity[i] <- "Walking"
  }
  else if (Ytestdata[i, 1] == 2) {
    Activity[i] <- "Walking Upstairs"
  }
  else if (Ytestdata[i, 1] == 3) {
    Activity[i] <- "Walking Down Stairs"
  }
  else if (Ytestdata[i, 1] == 4) {
    Activity[i] <- "Sitting"
  }
  else if (Ytestdata[i, 1] == 5) {
    Activity[i] <- "Standing"
  }
  else if (Ytestdata[i, 1] == 6) {
    Activity[i] <- "Laying"
  }
}

Ytestdata <- cbind(Ytestdata, Activity)

#read and label individual subject id data
SubjTestdata <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", sep = "", nrows = readRows)
SubjTraindata <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", sep = "", nrows = readRows)

#merge Subject data test and train
SubjTestdata <- rbind(SubjTestdata, SubjTraindata)

names(SubjTestdata) <- c("individualSubjectId")

#bind the results
resultsData <- cbind(SubjTestdata, Ytestdata)

#bind the final results with only std and mean cols from Xdata input
resultsData <- cbind(resultsData, stdmeanTestData)






#end of run_analysis.R Script



















