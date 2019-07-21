complete <- function(directory,id =1:332){
  filenames <- list.files(directory) ##list of files in the directory
  ids<- c()
  nobss<-c()
  for(i in id)
  {
    filepath <- paste(directory,"/",filenames[i],sep="")
    data <- read.csv(filepath,header = TRUE)
    completecases <- data[complete.cases(data),]
    ids<-c(ids,i)
    nobss<-c(nobss,nrow(completecases))
  }
  
  data.frame(id=ids,nobs=nobss)
}