# File: plot4.R
# Combined plots (from top-left corner, clockwise):
# 
# NOTE: This script assumes the "household_power_consumption.txt" file resides in the same
# directory.

library(dplyr)

# 1. Read input
epc <- read.table("household_power_consumption.txt", sep = ";", na.strings = c("?"), header = TRUE);
epc$Time <- strptime(paste(epc$Date, epc$Time), format="%d/%m/%Y %H:%M:%S");
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y");
epc$Global_active_power <- as.numeric(epc$Global_active_power);
epc$Sub_metering_1 <- as.numeric(epc$Sub_metering_1);
epc$Sub_metering_2 <- as.numeric(epc$Sub_metering_2);
epc$Sub_metering_3 <- as.numeric(epc$Sub_metering_3);

# 2. Select subset of the data
data <- epc[epc$Date == as.Date("2/2/2007", "%d/%m/%Y") | epc$Date == as.Date("1/2/2007", "%d/%m/%Y"), ];

png("plot4.png");
par(mfrow=c(2,2))

# A, top left: Time vs. Global Active Power
plot(data$Time, data$Global_active_power, type="l", ylab="Global Active Power", xlab="");

# B, top right: Time vs. Voltage
plot(data$Time, data$Voltage, type="l", ylab="Voltage", xlab="datetime");

# C, bottom left: Time vs. Sub Metering 1/2/3
plot(data$Time, data$Sub_metering_1, type ="l", ylab="Energy sub metering", xlab = "");
lines(data$Time, data$Sub_metering_1, col='black');
lines(data$Time, data$Sub_metering_2, col='red');
lines(data$Time, data$Sub_metering_3, col='blue');
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n");

# D, bottom right: Time vs. Global Reactive Power
plot(data$Time, data$Global_reactive_power, type ="l", ylab="Global_reactive_power", xlab="datetime");

dev.off();