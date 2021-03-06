# File: plot2.R
# Plots Time vs. Global Active Power (kilowatts)
# This script assumes the "household_power_consumption.txt" file resides in the same
# directory.

library(dplyr)

# 1. Read input
epc <- read.table("household_power_consumption.txt", sep = ";", na.strings = c("?"), header = TRUE);
epc$Time <- strptime(paste(epc$Date, epc$Time), format="%d/%m/%Y %H:%M:%S");
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y");
epc$Global_active_power <- as.numeric(epc$Global_active_power);

# 2. Select subset of the data
data <- epc[epc$Date == as.Date("2/2/2007", "%d/%m/%Y") | epc$Date == as.Date("1/2/2007", "%d/%m/%Y"), ];

png("plot2.png");
histinfo <- plot(data$Time, data$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)");
dev.off();