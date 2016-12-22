# Coursera Data Science - Getting And Cleaning Data
# Assignment Week Four
# Program to prep data for analysis
# 2016/12/17

# load libraries
library(dplyr)
library(dtplyr)
library(stringr)

### load datasets - Begin with train data, Y variables
# read in train Y vars & name them something intuitive
srcfile <- "./UCI HAR Dataset/train/Y_train.txt"
trainYData <- read.table(srcfile, header = FALSE)
names(trainYData) <- "ActivityCode"

### load datasets - next, train data, X variables
# read in train X vars (NOTE: they have a name file loaded later)
srcfile <- "./UCI HAR Dataset/train/X_train.txt"
trainXData <- read.table(srcfile, header = FALSE)

# read in train X Var names
srcfile <- "./UCI HAR Dataset/features.txt"
trainXNames <- read.table(srcfile,header = FALSE)
names(trainXNames) <- c("ColNum","VarName")
trainXNames <- select(trainXNames,VarName)
# add names to trainXData
names(trainXData) <- trainXNames$VarName

# read train subject data
srcfile <- "./UCI HAR Dataset/train/subject_train.txt"
trainXSubj <- read.table(srcfile,header = FALSE)
names(trainXSubj) <- c("Subject")
# merge train subject data to other train data
trainXData <- cbind(trainXSubj,trainXData)

# Select only pertinent variables from trainXData
trainXData <- trainXData[,grepl("Subject",names(trainXData))|grepl("[Mm]ean()",names(trainXData))|grepl("[Ss]td()",names(trainXData))]
trainXData <- trainXData[,!grepl("meanFreq",names(trainXData))]
trainData <- cbind(trainYData,trainXData)





### load datasets - Begin with test data, Y variables
# read in test Y vars & name them something intuitive
srcfile <- "./UCI HAR Dataset/test/Y_test.txt"
testYData <- read.table(srcfile, header = FALSE)
names(testYData) <- "ActivityCode"

### load datasets - next, test data, X variables
# read in test X vars (NOTE: they have a name file loaded later)
srcfile <- "./UCI HAR Dataset/test/X_test.txt"
testXData <- read.table(srcfile, header = FALSE)

# read in test X Var names
srcfile <- "./UCI HAR Dataset/features.txt"
testXNames <- read.table(srcfile,header = FALSE)
names(testXNames) <- c("ColNum","VarName")
testXNames <- select(testXNames,VarName)
# add names to testXData
names(testXData) <- testXNames$VarName

# read test subject data
srcfile <- "./UCI HAR Dataset/test/subject_test.txt"
testXSubj <- read.table(srcfile,header = FALSE)
names(testXSubj) <- c("Subject")
# merge test subject data to other test data
testXData <- cbind(testXSubj,testXData)

# Select only pertinent variables from testXData
testXData <- testXData[,grepl("Subject",names(testXData))|grepl("[Mm]ean()",names(testXData))|grepl("[Ss]td()",names(testXData))]
testXData <- testXData[,!grepl("meanFreq",names(testXData))]
testData <- cbind(testYData,testXData)

# Merge Test and Train datasets together
AllData <- rbind(testData,trainData)

# Final step - add activity labels
srcfile <- "./UCI HAR Dataset/activity_labels.txt"
ActivityLabels <- read.table(srcfile, header = FALSE,sep = " ",stringsAsFactors = TRUE)
names(ActivityLabels) <- c("ActivityCode","ActivityDesc")
# merge labels and data into one set for Y variables
AllData <- merge(ActivityLabels,AllData,by = intersect(names(ActivityLabels),names(AllData)))

# remove intermediate tables to avoid confusion later
rm(trainYData)
rm(trainXData)
rm(trainXNames)
rm(trainXSubj)
rm(testYData)
rm(testXData)
rm(testXNames)
rm(testXSubj)
rm(testData)
rm(trainData)
rm(ActivityLabels)


# Clean up variable names
# NOTE: contrary to other advice, I prefer Title case, so the 
# following conversions move toward that style.

tmpNames <- names(AllData)
tmpNames <- gsub("-mean","Mean",tmpNames,fixed = TRUE)
tmpNames <- gsub("-std","Std",tmpNames,fixed = TRUE)
tmpNames <- gsub("angle","Angle",tmpNames,fixed = TRUE)
tmpNames <- gsub("gravity","Gravity",tmpNames,fixed = TRUE)
tmpNames <- str_replace_all(tmpNames,"[:punct:]|[:space:]","")
names(AllData) <- tmpNames

# create tidy 'averages' dataset
ResultsData <- aggregate(AllData[,4:76],list(AllData$ActivityDesc,AllData$Subject),mean)
# rename the 'group_by' variables
new_names <- c("ActivityDesc","Subject")
colnames(ResultsData)[1:2] <- new_names

# Write out the new dataset
srcfile <- "./AveragesDataset.txt"
write.table(ResultsData,srcfile,row.name = FALSE)

