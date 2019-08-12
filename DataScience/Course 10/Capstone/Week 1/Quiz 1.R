
setwd("E:/datascience/datasciencecoursera/DataScience/Course 10/Capstone")

#Question - 1

#The 𝚎𝚗_𝚄𝚂.𝚋𝚕𝚘𝚐𝚜.𝚝𝚡𝚝 file is how many megabyte?

#ANSWER

size<-file.info("./projectData/final/en_US/en_US.blogs.txt")
kb<-size$size/1024
mb<-kb/1024
mb



#Question - 2

#The 𝚎𝚗_𝚄𝚂.𝚝𝚠𝚒𝚝𝚝𝚎𝚛.𝚝𝚡𝚝 has how many lines of text?
        
#ANSWER

twitter <- readLines(con <- file("./projectData/final/en_US/en_US.twitter.txt"),encoding = "UTF-8", skipNul = TRUE)
length(twitter)



#Question - 3

##What is the length of the longest line seen in any of the three en_US data sets?
        
#ANSWER

# Blogs file
blogs<-file("./projectData/final/en_US/en_US.blogs.txt","r")
blogs_lines<-readLines(blogs)
close(blogs)
summary(nchar(blogs_lines))



# News file
news<-file("./projectData/final/en_US/en_US.news.txt","r")
news_lines<-readLines(news)
close(news)
summary(nchar(news_lines))


# Twitter file
twitter<-file("./projectData/final/en_US/en_US.twitter.txt","r")
twitter_lines<-readLines(twitter)
close(twitter)
summary(nchar(twitter_lines))


#Question - 4

#In the en_US twitter data set, if you divide the number of lines where the word “love” (all lowercase) occurs by the number of lines the word “hate” (all lowercase) occurs, about what do you get?
        
#ANSWER

love<-length(grep("love", twitter_lines))
hate<-length(grep("hate", twitter_lines))
love/hate



#Question - 5

#The one tweet in the en_US twitter data set that matches the word “biostats” says what?
        
#ANSWER

grep("biostats", twitter_lines, value = T)



#Question - 6

#How many tweets have the exact characters "A computer once beat me at chess, but it was no match for me at kickboxing". (I.e. the line matches those characters exactly.)

#ANSWER

grep("A computer once beat me at chess, but it was no match for me at kickboxing", twitter_lines)


#------------------------------------------GIT BASH Solutions--------------------------

#in Git Bash in the directory containing all the .txt files

#Q1 : ls-alh
#Q2 : wc -l en_US.twitter.txt
#Q3 : wc-L*.txt
#Q4 : love=$(grep"love"en_US.twitter.txtwc−l)
        #hate=$(grep"hate"en_US.twitter.txtwc−l)
        #letm=love/hate
        #echo $m
