##Course 3 Week-3 Quiz
##Question 1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv","ACS.csv",method="curl")
acs<- read.csv("ACS.csv")
agricultureLogical<- acs$ACR==3 & acs$AGS==6
head(which(agricultureLogical),3)
##Question 2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg","inst.jpg",method="curl")
inst_jpg <- readJPEG("inst.jpg",native=TRUE)
quantile(inst_jpg,c(0.3,0.8))
##Question 3
grossProduct<- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                                 , skip=4
                                 , nrows = 190
                                 , select = c(1, 2, 4, 5)
                                 , col.names=c("CountryCode", "Rank", "Economy", "Total")
)
eduData<- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
)
mergedData<-merge(grossProduct,eduData,by="CountryCode")
nrow(mergedData)
arrangedDt<-arrange(mergedData,desc(Rank))
arrangedDt[13,]
##Question 4
highIncomeOecd<-mergedData[`Income Group` == "High income: OECD"
                         , lapply(.SD, mean)
                         , .SDcols = c("Rank")
                         , by = "Income Group"]
highncomenonOecd<-mergedData[`Income Group` == "High income: nonOECD"
                           , lapply(.SD, mean)
                           , .SDcols = c("Rank")
                           , by = "Income Group"]
##Question 5
breaks <- quantile(mergedData[, Rank], probs = seq(0, 1, 0.2), na.rm = TRUE)
mergedData$quantileGDP <- cut(mergedData[, Rank], breaks = breaks)
mergedData[`Income Group` == "Lower middle income", .N, by = c("Income Group", "quantileGDP")]
