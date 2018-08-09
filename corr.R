corr<- function(directory,threshold=0){
  corrfilenames <- list.files(directory) ##list of files in the directory
  corrcompletes <- complete(directory,1:332)
  aboveThreshold <- subset(corrcompletes,nobs>threshold)
  correlations<- vector()
  for (i in aboveThreshold$id) {
    filepath <- paste(directory,"/",corrfilenames[i],sep="")
    data <- read.csv(filepath,header = TRUE)
    completecases <- data[complete.cases(data),]
    counts<- nrow(completecases)
    if(counts >= threshold)
    {
      correlations<-c(correlations,cor(completecases$nitrate,completecases$sulfate))
    }
  }
  correlations
}