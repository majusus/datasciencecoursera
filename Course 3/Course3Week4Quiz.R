##Course 3 Week 4 Quiz

##Question 1
library("data.table")
communities<- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
nameSplit<- strsplit(names(communities),"wgtp")
nameSplit[[123]]

##Question 2
gdpRank<- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                            , skip=5
                            , nrows=190
                            , select = c(1, 2, 4, 5)
                            , col.names=c("CountryCode", "Rank", "Country", "GDP")
)
gdpRank[,mean(as.integer(gsub(pattern = ",",replacement = "",x = GDP)))]

##Question 3

grep("^United",countryNames), 3



##Question 4
gdpRank<- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                            , skip=5
                            , nrows=190
                            , select = c(1, 2, 4, 5)
                            , col.names=c("CountryCode", "Rank", "Country", "GDP")
)
eduData<-data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')
mergedDT <- merge(gdpRank, eduData, by = 'CountryCode')
mergedDT[grepl(pattern = "Fiscal year end: June 30;", mergedDT[, `Special Notes`]), .N]

##Question 5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
timeDT <- data.table::data.table(timeCol = sampleTimes)

timeDT[(timeCol >= "2012-01-01") & (timeCol) < "2013-01-01", .N ]

timeDT[((timeCol >= "2012-01-01") & (timeCol < "2013-01-01")) & (weekdays(timeCol) == "Monday"), .N ]
