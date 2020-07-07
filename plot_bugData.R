library(ggplot2)
library(dplyr)

rawData <- read.csv("Data/stygian_Observations.csv")
rawData <- rawData[-c(1:3),]
rawData$X8.28.19 <- NULL
rawData[is.na(rawData)] <- 0

rawDate <- list()
rawTime <- list()

obsRaw <- dplyr::select(rawData, -c(X,date))



for(i in 1:length(names(obsRaw))){  #for each column
  curCol <- obsRaw[i]
  #print(NROW(curCol))
  for(j in 1:NROW(curCol)){   #for each row
    nObs <- curCol[j,]
    if(nObs > 0){
      for(k in 1:nObs){
        rawDate <- append(rawDate,names(obsRaw[i]))
        #print(toString(rawData$X[j]))
        rawTime <- append(rawTime,toString(rawData$X[j]))
      }
    }
  }
}


date <- unlist(rawDate)
time <- unlist(rawTime)

cleanDate <- list()
for(i in 1:length(rawDate)){
  date[i] <- sub('X','',date[i])
  subs <- strsplit(date[i],'\\.')
  subs <- unlist(subs)
  subs[3] <- 2019
  for(i in 1:2){
    if(nchar(subs[i]) < 2){
      subs[i] <- paste('0',subs[i],sep='')
      
      #print(subs[i])
    }
  }
  cleanDate <- append(cleanDate,paste(subs[3],'-',subs[1],'-',subs[2],sep=''))

}

#----------------------------------------------------------------------------------------------------

obsData <- data.frame(cbind(unlist(cleanDate),unlist(time)))
names(obsData) <- c("Date","Time")

obsData$Time <- lapply(obsData$Time,toString)

for(i in 1:NROW(obsData$Time)){
  if(nchar(obsData$Time[i]) < 5){
    obsData$Time[i] <- paste('0',obsData$Time[i],sep='')
  }
  obsData$Time[i] <- unlist(paste(obsData$Time[i],'Pm',sep=''))
}

obsData$Time <- gsub(":","",obsData$Time)

obsData$Time <- strptime(x = obsData$Time, format = "%I%M%p")


#------------------------------------------------------

obsData$Time <- as.POSIXct(obsData$Time, format = "%I%M%p")
obsData$Date <- as.POSIXct(obsData$Date)


ggplot() +
  geom_point(obsData, mapping = aes(x=Date, y=Time)) +
  scale_x_datetime(breaks=waiver, date_breaks = "7 days",labels = date_format("%b-%d"))



print(rawDate)
testrawDate <- unlist(rawDate[1])

sub('X','',testrawDate)

obsData <- data.frame(cbind(unlist(rawDate),unlist(rawTime)))
names(obsData) <- c("rawDate","rawTime")



rawTime
names(obsRaw[1])

dim(rawData$X)

dim(obsRaw)
dim(rawData)
