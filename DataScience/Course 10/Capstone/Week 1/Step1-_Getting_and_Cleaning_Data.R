##--------------------------------------Getting Data----------------------

## Load CRAN modules 
library(downloader)
library(plyr);
library(dplyr)
library(knitr)
library(tm)

##Constants
Url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
filePath <- "E:\\datascience\\datasciencecoursera\\DataScience\\Course 10\\Capstone"

## Step 1: Download the dataset and unzip folder
## Check if directory already exists?
if(!file.exists(filePath)){
        dir.create(filePath)
}

#Set to the Project Folder
setwd(filePath)

## Check if zip has already been downloaded in projectData directory?
if(!file.exists("Coursera-SwiftKey.zip")){
        download.file(Url,destfile="Coursera-SwiftKey.zip",mode = "wb")
}

## Check if zip has already been unzipped?
if(file.exists("Coursera-SwiftKey.zip")){
        unzip(zipfile="Coursera-SwiftKey.zip",exdir="./projectData")
}

path <- file.path("./projectData/final" , "en_US")
files<-list.files(path, recursive=TRUE)

# Lets make a file connection of the twitter data set
con <- file("./projectData/final/en_US/en_US.twitter.txt", "r")

#lineTwitter<-readLines(con,encoding = "UTF-8", skipNul = TRUE)
lineTwitter<-readLines(con, skipNul = TRUE)

# Close the connection handle when you are done
close(con)

# Lets make a file connection of the blog data set
con <- file("./projectData/final/en_US/en_US.blogs.txt", "r") 

#lineBlogs<-readLines(con,encoding = "UTF-8", skipNul = TRUE)
lineBlogs<-readLines(con, skipNul = TRUE)

# Close the connection handle when you are done
close(con)

# Lets make a file connection of the news data set
con <- file("./projectData/final/en_US/en_US.news.txt", "r") 

#lineNews<-readLines(con,encoding = "UTF-8", skipNul = TRUE)
lineNews<-readLines(con, skipNul = TRUE)

# Close the connection handle when you are done
close(con)

library(stringi)

# Get file sizes
lineBlogs.size <- file.info("./projectData/final/en_US/en_US.blogs.txt")$size / 1024 ^ 2
lineNews.size <- file.info("./projectData/final/en_US/en_US.news.txt")$size / 1024 ^ 2
lineTwitter.size <- file.info("./projectData/final/en_US/en_US.twitter.txt")$size / 1024 ^ 2

# Get words in files
lineBlogs.words <- stri_count_words(lineBlogs)
lineNews.words <- stri_count_words(lineNews)
lineTwitter.words <- stri_count_words(lineTwitter)

# Summary of the data sets
dataSummary <- data.frame(source = c("blogs", "news", "twitter"),
                   file.size.MB = c(lineBlogs.size, lineNews.size, lineTwitter.size),
                   num.lines = c(length(lineBlogs), length(lineNews), length(lineTwitter)),
                   num.words = c(sum(lineBlogs.words), sum(lineNews.words), sum(lineTwitter.words)),
                   mean.num.words = c(mean(lineBlogs.words), mean(lineNews.words), mean(lineTwitter.words)))

##--------------------------------------Cleaning Data----------------------

library(tm)

# Sample the data
set.seed(5000)
data.sample <- c(sample(lineBlogs, length(lineBlogs) * 0.02),
                 sample(lineNews, length(lineNews) * 0.02),
                 sample(lineTwitter, length(lineTwitter) * 0.02))

# Create corpus and clean the data
corpus <- VCorpus(VectorSource(data.sample))
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
corpus <- tm_map(corpus, toSpace, "(f|ht)tp(s?)://(.*)[.][a-z]+")
corpus <- tm_map(corpus, toSpace, "@[^\\s]+")
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removeWords, stopwords("en"))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, PlainTextDocument)
