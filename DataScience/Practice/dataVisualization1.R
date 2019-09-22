

# Reading the data 

movies<-read.csv("../input/Movie Ratings.csv",header=TRUE)

#Structure and summary of dataset

str(movies)

summary(movies)

# To see abstract of dataset

head(movies)  # top 6 rows

tail(movies)  # last 6 rows

#change the column names

colnames(movies)<-c('name','genre','criticsratings','audienceratings','budgetmillions','releaseyear')

# To see the types of genre

levels(movies$genre)

head(movies)

# changing the numeric column to categorical

movies$releaseyear<-as.factor(movies$releaseyear)

levels(movies$releaseyear)

# install ggplot2 package

library(ggplot2)

ggplot(data=movies,aes(x=criticsratings,y=audienceratings)) + geom_point()

# color and size setting 

#ggplot(data=movies,aes(x=criticsratings,y=audienceratings,color=genre,size=budgetmillions))

r<-ggplot(data=movies,aes(x=criticsratings,y=audienceratings))+geom_point(color='red',size=3)

r

#Color and Size mapping

r+geom_point(aes(color='yellow'))

r+geom_point(aes(size=budgetmillions))

# changing the graph type

ggplot(data=movies,aes(x=budgetmillions))+
        
        geom_histogram(binwidth=10,color='blue',fill='green')

# genre mappig

ggplot(data=movies,aes(x=budgetmillions))+
        
        geom_histogram(binwidth=10,color='black',aes(fill=genre))

#Using facet grid to divide the graph according to genre

ggplot(data=movies,aes(x=criticsratings,y=audienceratings))+geom_point(color='red',size=3)+
        
        facet_grid(.~genre)

d <- ggplot(data=movies,aes(x=budgetmillions))+
        
        geom_density(color='black',stack=10,aes(fill=genre))

d

# Adding new layer for limiting the yscale

ggplot(data=movies,aes(x=budgetmillions))+
        
        geom_histogram(binwidth=10,color='black',aes(fill=genre))+
        
        coord_cartesian(ylim=c(0,50))

# histograms with facet grid

ggplot(data=movies,aes(x=budgetmillions))+
        
        geom_histogram(binwidth=10,color='black',aes(fill=genre))+
        
        facet_grid(genre~.,scales='free')

# Scaling x and y coordinates

t <- ggplot(data=movies,aes(x=criticsratings,y=audienceratings,color=genre))+geom_point(size=3)+
        
        facet_grid(genre~releaseyear)+xlim(0,100)+ylim(0,50)

t

# Ignore the missing value. Here our major focus on learning ggplot2 

# adding themes to plots

# install ggthemes package

library(ggthemes)

#help(ggthemes)

d + theme_economist()

# see the difference between d & d + theme_economist()

# r is already available in working environment

r + theme_wsj()

# you can apply different themes for more details type help(ggthemes) in RStudio

d + theme_fivethirtyeight()

# Now including all the layers in ggplot to make the graph more interactive

o<-ggplot(data=movies,aes(x=budgetmillions))

p<- o+geom_histogram(binwidth=10,color='black',aes(fill=genre))

p

p+xlab("money axis")+ylab("no of movies")+
        
        theme(axis.title.x=element_text(color="red",size=25),
              
              axis.title.y=element_text(color="blue",size=25),
              
              axis.text.x=element_text(color="red",size=15),
              
              axis.text.y=element_text(color="blue",size=15),
              
              legend.title=element_text(color="black",size=10),
              
              legend.text=element_text(color="black",size=10),
              
              legend.position = c(1,1),
              
              legend.justification = c(1,1),
              
              plot.title = element_text(color='red',size=15,family="roman"))+
        
        ggtitle("movies budget distribution")

