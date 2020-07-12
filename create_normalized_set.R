library(ggplot2)
library(dplyr)
library(scales)
library(suncalc)
library(lubridate)

rawObs <- read.csv("Data/cleaned_Stygian.csv")

min <- as.POSIXct("2019-01-01") %>%
  as.numeric()
max <- as.POSIXct("2019-12-31") %>%
  as.numeric()

datesPosix <- seq(min, max, length.out = 365) %>%
  as.POSIXct(origin = "1970-01-01")

datesChar <- unlist(lapply(datesPosix, toString))

for(i in 1:dates){
  
}



# obsData$Time <- as.POSIXct(obsData$Time, origin="1970-01-01")
# obsData$Date <- as.POSIXct(obsData$Date, origin="1970-01-01")
# 
# minTime <- min(obsData$Time) %>%
#   as.POSIXct()
# maxTime <- max(obsData$Time) %>%
#   as.POSIXct()
# 
# yMin <- as.numeric(minTime)
# yMax <- as.numeric(maxTime)  
# 
# numBreaks <- seq(from = yMin, to = yMax, length.out = 20)#1+abs(2 * difftime(maxTime, minTime)[[1]])