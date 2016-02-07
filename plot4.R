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
date_data$Global_reactive_power <- as.numeric(as.character(date_data$Global_reactive_power))
date_data$Voltage <- as.numeric(as.character(date_data$Voltage))

date_data$Sub_metering_1 <- as.numeric(as.character(date_data$Sub_metering_1))
date_data$Sub_metering_2 <- as.numeric(as.character(date_data$Sub_metering_2))
date_data$Sub_metering_3 <- as.numeric(as.character(date_data$Sub_metering_3))


## open png device
png("plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))

plot(date_data$timestamp, date_data$Global_active_power,  type="l", 
     col="black", xlab="datetime",ylab="Gloal Active Power")

plot(date_data$timestamp, date_data$Voltage,  type="l", 
     col="black", xlab="datetime",ylab="Voltage")

plot(date_data$timestamp, date_data$Sub_metering_1,  type="l", 
     col="black", xlab="datetime",ylab="Energy Sub Metering")
lines(date_data$timestamp, date_data$Sub_metering_2,  type="l", col="red")
lines(date_data$timestamp, date_data$Sub_metering_3,  type="l", col="blue")
legend("topright", legend=c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"),
       col=c("black", "red", "blue"),   lty=c(1,1,1), lwd=0.005, cex=0.5)

plot(date_data$timestamp, date_data$Global_reactive_power,  type="l", 
     col="black", xlab="datetime",ylab="Gloal Reactive Power")
## Close the png device
dev.off()