rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    usData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    ocColumnNames = c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                      "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                      "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")

    for (n in 1:3) {
        usData[,ocColumnNames[n]] = as.numeric(usData[,ocColumnNames[n]])
    }

    ## Check that state and outcome are valid
    validStates <- levels(factor(usData$State))
    if (!state %in% validStates) {
        stop("invalid state")
    }
 
    validOutcomes <- c("heart attack", "heart failure", "pneumonia")
    if (!outcome %in% validOutcomes) {
        stop("invalid outcome")
    }
    ocDf <- data.frame(ocColumnNames, row.names = validOutcomes)

    ## Return hospital name in that state with the given rank
    colName = as.character(ocDf[outcome, 1])
    stateData = usData[usData$State == state & !is.na(usData[[colName]]),]
    colName = as.character(ocDf[outcome, 1])
    ordered <- stateData[order(stateData[[colName]], stateData$Hospital.Name),]
    index = getRankIndex(num, nrow(ordered))
    if (index > nrow(ordered)) {
      return(NA)
    }
    ordered[index, "Hospital.Name"]
}

  getRankIndex <- function(num, nrow) {
    if (num == "best") {
      result = 1
    } else if (num == "worst") {
      result = nrow
    } else {
      result = num
    }
    result
  }
