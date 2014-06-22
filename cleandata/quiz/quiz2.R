library(httr)
library(jsonlite)
myapp <- oauth_app("github", "3b8da1a1663e0a2383c3", secret = "586fc8ec9c1a42099e3254fbd0011921d73c454e")
#When defining the app in github, callback URL should be "http://localhost:1410"
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
j1 <- content(req)
j2 <- toJSON(j1)
c <- fromJSON(j2)
print(c[c$name == "datasharing",]$created_at)
#
#
library(sqldf)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "pid.csv", method="curl")
acs <- read.csv("pid.csv")
sr <- sqldf("select pwgtp1 from acs where AGEP < 50")
print(summary(sr))
r1 <- acs[acs$AGEP < 50,]$pwgtp1
print(summary(r1))

con <-  url("http://biostat.jhsph.edu/~jleek/contact.html")
h <- readLines(con)
print(nchar(h[c(10,20,30,100)]))

x <- read.fwf("wksst810.for", widths=c(-2,8,-5,4,4,-5,4,4,  -5,4,4,-5,4,4), skip=4)
print(sum(x[,4]))
