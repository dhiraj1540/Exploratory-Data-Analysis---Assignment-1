if(!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
## Filter data for desired dates
date_data<-data[data$Date=="1/2/2007" | data$Date=="2/2/2007", ]
date_data <- transform(date_data, timestamp=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
date_data$Global_active_power <- as.numeric(as.character(date_data$Global_active_power))
## open png device
png("plot2.png", width=480, height=480, units="px")

plot(date_data$timestamp, date_data$Global_active_power,  type="l", col="red", xlab=" ",ylab="Global Active Power (kilowatts)")

## Close the png device
dev.off()