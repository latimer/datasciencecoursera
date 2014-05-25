pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    
    #specdata = lapply(list.files(directory, full.names = TRUE),
    #                    read.csv)
    filePaths <- list.files(directory, full.names = TRUE)
    validData = vector()
#     for(filePath in  filePaths) {
#         fileData <- read.csv(filePath)
#         idData <- fileData[fileData$ID %in% id,]
#         validData <- append(validData,idData[,pollutant])
#     }
    
    for (monitor in id) {
        idString = formatC(monitor, flag = "0", width = 3)
        filePath = paste(directory, "/", idString, ".csv", sep="")
        fileData <- read.csv(filePath)
        validData <- append(validData,fileData[,pollutant])
    }
    mean(validData, na.rm = TRUE)
}
