dir = "specdata"

source("pollutantmean.R")
pollutantmean(dir, "sulfate", 1:10)
pollutantmean(dir, "nitrate", 70:72)
pollutantmean(dir, "nitrate", 23)

source("complete.R")
complete(dir, 1)
complete(dir, c(2, 4, 8, 10, 12))
complete(dir, 30:25)
complete(dir, 3)

source("corr.R")

cr <- corr(dir, 150)
head(cr)
summary(cr)

cr <- corr(dir, 400)
head(cr)
summary(cr)

cr <- corr(dir, 5000)
head(cr)
summary(cr)

cr <- corr(dir)
summary(cr)
length(cr)
