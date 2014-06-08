rm(list=ls())

############################## Download in R  #####################################
classes<-c("factor","factor",rep("numeric",times=7))

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
dat <- read.table(unz(temp, "household_power_consumption.txt"), sep=";",header=T,colClass=classes,na.strings="?")
unlink(temp)
rm(list=c("temp","classes"))

############################## Data frame preparation #####################################

#Converting Date variable into Date format
dat$Date=as.Date(dat$Date,format="%d/%m/%Y")

#Subsetting only desired dates
dat<-dat[dat$Date %in% as.Date(c("2007-02-01","2007-02-02") ),]

#New variable combining complete date and time
dat$datetime<-as.POSIXct(paste(as.character(dat$Date),as.character(dat$Time)))
# Sorting by datetime variable
dat<-dat[order(dat$datetime),]

############################## PLOTS #####################################

## The first plot
png("plot1.png", width = 480, height = 480, units = "px")
par(mfrow=c(1,1))
hist(dat$Global_acti,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()