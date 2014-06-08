## Exploratory Data Analysis Course Project 1

## Read file and subset
textfile <- "/users/rsusvilla/documents/coursera/household_power_consumption.txt"
initial <- read.table(textfile, nrows=100, sep=";", header=T, na.strings="?", comment.char="")
classes <- sapply(initial, class)
epcdf <- read.table(textfile, sep=";", header=T, na.strings="?", comment.char="", colClasses=classes)
epcdf <- subset(epcdf, Date == "1/2/2007" | Date == "2/2/2007")

## Create a new DateTime variable
DateTime <- strptime(paste(epcdf$Date," ",epcdf$Time),"%d/%m/%Y %H:%M:%S")
epcdf <- cbind(DateTime, epcdf)

## Create histogram
par(mar=c(6, 4 , 2, 2))
hist(epcdf$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")

## Create png file
dev.copy(png, "/Users/rsusvilla/CourseraDataScience/plot1.png")
dev.off()