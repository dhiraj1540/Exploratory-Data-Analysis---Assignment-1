if(!file.exists("household_power_consumption.txt")) {
      temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
  }

data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
## Filter data for desired dates
date_data<-data[data$Date=="1/2/2007" | data$Date=="2/2/2007", ]

## Extract Global_active_power data from date_data
gap <- as.numeric(as.character(date_data$Global_active_power))

## open png device
png("plot1.png", width=480, height=480, units="px")

## Create the histogram for frequency
hist(gap, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

## Close the png device
dev.off()