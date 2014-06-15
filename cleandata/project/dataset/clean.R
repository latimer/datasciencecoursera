# Read data from one directory
readData <- function (dirname, colNames) {
    suffix <- paste(dirname, ".txt", sep = "")
    # The readings
    measurements <- read.table(paste(dirname, "/X_", suffix, sep = ""))
    # Poor shmuck who is doing the exercise
    subject <- read.table(paste(dirname, "/subject_", suffix, sep = ""))
    # Exercise type
    exType <- read.table(paste(dirname, "/y_", suffix, sep = ""))
    if (nrow(subject) != nrow(exType)) {
      sprintf("Found subjects %d != exercises %d", nrow(subject), nrow(exType))
      return
    }
    if (nrow(subject) != nrow(measurements)) {
      sprintf("Found subjects %d != exercises %d", nrow(subject), nrow(measurements))
      return     
    }
    data <- cbind.data.frame(subject, exType, measurements)
    names(data) <- colNames
    exDescriptions <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
                        "SITTING", "STANDING", "LAYING")
    data[,][[2]] <- exDescriptions[as.numeric(data[,][[2]])]
    return(data)
}

features <- read.table("features.txt", colClasses="character")
colNames <- c("Subject", "ExerciseType", features[[2]])
testData <- readData("test", colNames)
trainData <- readData("train", colNames)
testSubjects <- unique(sort(testData$Subject))
trainSubjects <- unique(sort(trainData$Subject))
commonSubjects <- intersect(testSubjects, trainSubjects)
if (length(commonSubjects) != 0) {
  print("The following subjects are in training as well as testing")
  print(commonSubjects)
}

#Combine testing and training
allData <- rbind.data.frame(testData, trainData)

#Get all mean and std deviation columns
meanAndStd <- sort(c(1, 2,
                    grep(".*mean", colNames),
                    grep(".*std", colNames)))

#Filter out the rest
meanAndStdData <- allData[,meanAndStd]

write.csv(meanAndStdData, "meanAndStdData.csv", row.names = FALSE)

readings <- meanAndStdData[,c(-1,-2)]
groupData <- aggregate(zd, by=list(meanAndStdData$Subject,  meanAndStdData$ExerciseType), FUN=mean)
names(ag)[1] <- "Subject"
names(ag)[2] <- "ExerciseType"

write.csv(ag, "aggregate.csv", row.names = FALSE)
