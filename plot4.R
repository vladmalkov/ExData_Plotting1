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

## The forth plot
png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
plot(dat$datetime,dat$Global_acti,type="l" ,xlab="",ylab="Global Active Power")

with(dat,plot(datetime,Voltage,type="l")) 

plot(rep(dat$datetime,3),with(dat,c(Sub_metering_1,Sub_metering_2,Sub_metering_3)),type="n",ylab="Energy sub metering",xlab="") 
lines(dat$datetime, dat$Sub_metering_1,col="black")
lines(dat$datetime, dat$Sub_metering_2,col="red")
lines(dat$datetime, dat$Sub_metering_3,col="blue")
#bty="n" kills border of legend box
legend("topright",col=c("black","red","blue"),lwd=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n") 

with(dat,plot(datetime,Global_reactive_power,type="l")) 

dev.off()