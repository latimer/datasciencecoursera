download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "hid.csv", method="curl")
hid <- read.csv("hid.csv")
lv <- hid$ACR == 3 & hid$AGS == 6
print(head(which(lv), 3))

library("jpeg")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "jeff.jpg", method = "curl")
r <- readJPEG("jeff.jpg", TRUE)

gdp <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "gdp.csv", method = "curl")
edu <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "edu.csv", method = "curl")
gdp <- read.table("gdp.csv", header = FALSE, skip = 5, nrows = 190, sep = ",",  quote = "\"", na.strings="")
names(gdp)[c(1,2)] <- c("CountryCode", "Rank")
edu <- read.table("ed.csv", header = TRUE, sep = ",", quote = "\"")
m <- merge(gdp, edu, by.x = "CountryCode", by.y = "CountryCode")
print(m[with(m, order(-Rank)),][13,])

q <- cut(m$Rank, breaks = quantile(m$Rank, seq(0, 1, 0.2), type = 3))
levels(q) <- c("q1", "q2", "q3", "q4", "q5")
