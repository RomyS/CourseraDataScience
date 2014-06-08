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

## Create line plot
plot(epcdf$DateTime, epcdf$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")