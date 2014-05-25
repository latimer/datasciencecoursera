corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files

    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0

    filePaths <- list.files(directory, full.names = TRUE)
    cor = vector("numeric")
    for(filePath in  filePaths) {
        fileData <- read.csv(filePath)
        c <- fileData[complete.cases(fileData) == TRUE,]
        if (nrow(c) > 0 && nrow(c) >= threshold) {
            cor1 <- cor(c$sulfate, c$nitrate, use = "pairwise.complete.obs") 
            cor <- append(cor, cor1)
        }
    }
    cor
}
