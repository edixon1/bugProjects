library(ggplot2)
library(dplyr)
library(scales)
library(suncalc)
library(lubridate)

obsData <- read.csv("Data/cleaned_Stygian.csv")

obsData <- select(obsData, Date,Time,nObs)

names(obsData) <- c("Date","Time","nObservations")

sunsetTimes <- getSunlightTimes(date=as.Date(obsData$Date),lat=35.929086, lon=-82.881060,
                 keep="sunset", tz="America/New_York")$sunset %>%
  as.POSIXct(origin="1970-01-01", tz="America/New_York")


sunsetTimes_char <- unlist(lapply(sunsetTimes, toString))


sunsetTimes_mod <- list()
for(i in 1:length(sunsetTimes_char)){
  curTime <- strsplit(sunsetTimes_char[i]," ")[[1]][2]
  sunsetTimes_mod[[i]] <- curTime
}

sunsetTimes <- as.POSIXct(unlist(sunsetTimes_mod), origin="1970-01-01",tz="America/New_York",format="%H:%M:%OS")

# x <- strptime(sunsetTimes, format="%d/%m/%Y %H:%M:%S")
# format(x, "%H:%M:%S")




obsData$Time <- as.POSIXct(obsData$Time, origin="1970-01-01")
obsData$Date <- as.POSIXct(obsData$Date, origin="1970-01-01")

minTime <- min(obsData$Time) %>%
  as.POSIXct()
maxTime <- max(obsData$Time) %>%
  as.POSIXct()

yMin <- as.numeric(minTime)
yMax <- as.numeric(maxTime)  

numBreaks <- seq(from = yMin, to = yMax, length.out = 20)#1+abs(2 * difftime(maxTime, minTime)[[1]])

labels <- as.POSIXct(numBreaks, origin = "1970-01-01", tz = "America/New_York") %>% format("%H:%M")

#scatter plot
ggplot() +
  geom_point(obsData, pch=21, size=2, mapping = aes(x=Date, y=Time, fill=nObservations)) +
  geom_line(obsData, mapping=aes(x=Date, y=sunsetTimes, color="Sunset Time"),size=1) +
  scale_x_datetime(breaks=waiver, date_breaks="5 days",labels = date_format("%b-%d")) +
  scale_y_datetime(breaks=as.POSIXct(numBreaks, origin="1970-01-01"),
                   labels=labels, limits = c(minTime, maxTime))

#first draft hex plot
ggplot() +
  geom_hex(obsData, mapping=aes(x=Date, y=Time), bins=15)+
  # geom_point(obsData, pch=21, size=2, mapping = aes(x=Date, y=Time, fill=nObservations)) +
  geom_line(obsData, mapping=aes(x=Date, y=sunsetTimes, color="Sunset Time"),size=1) +
  scale_x_datetime(breaks=waiver, date_breaks="5 days",labels = date_format("%b-%d")) +
  scale_y_datetime(breaks=as.POSIXct(numBreaks, origin="1970-01-01"),
                   labels=labels, limits = c(minTime, maxTime))
#35.929086, -82.881060



as.date
Sys.timezone()


#8/28/19 14, 13, 8

#8:03, 8:08, 8:09