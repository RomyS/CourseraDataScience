## Exploratory Data Analysis Course Project 1

## Read file and subset
textfile <- "/users/rsusvilla/documents/coursera/household_power_consumption.txt"
initial <- read.table(textfile, nrows=100, sep=";", header=T, na.strings="?", comment.char="")
classes <- sapply(initial, class)
epcdf <- read.table(textfile, sep=";", header=T, na.strings="?", comment.char="", colClasses=classes)
epcdf <- subset(epcdf, Date == "1/2/2007" | Date == "2/2/2007")

## Create new DateTime variable
DateTime <- strptime(paste(epcdf$Date," ",epcdf$Time),"%d/%m/%Y %H:%M:%S")
epcdf <- cbind(DateTime, epcdf)

## Set 2 x 2 plotting area
par(mfrow = c(2, 2))
## Set margins
par(mar=c(4, .5 , .5, .5))

## Plot 1
plot(epcdf$DateTime, epcdf$Global_active_power, type="l", ylab="Global Active Power", xlab="")

## Plot 2
plot(epcdf$DateTime, epcdf$Voltage, type="l", ylab="Voltage", xlab="datetime")

## Plot 3
plot(epcdf$DateTime, epcdf$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(epcdf$DateTime, epcdf$Sub_metering_1, col="black")
lines(epcdf$DateTime, epcdf$Sub_metering_2, col="red")
lines(epcdf$DateTime, epcdf$Sub_metering_3, col="blue")
legend("topright", lty=1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"))

## Plot 4
plot(epcdf$DateTime, epcdf$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
