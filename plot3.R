# File: plot3.R
# Plots Time vs. Energy sub metering
# This script assumes the "household_power_consumption.txt" file resides in the same
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

png("plot3.png");
plot(data$Time, data$Sub_metering_1, type ="l", ylab="Energy sub metering", xlab = "");
lines(data$Time, data$Sub_metering_1, col='black');
lines(data$Time, data$Sub_metering_2, col='red');
lines(data$Time, data$Sub_metering_3, col='blue');
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1);
dev.off();