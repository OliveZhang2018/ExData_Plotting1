# only read in as needed

library(sqldf)

df <- read.csv.sql("household_power_consumption.txt", 
                   header = TRUE, sep = ";", 
                   sql = "select * from file where Date == '1/2/2007' 
                   or Date == '2/2/2007'")

# convert to Date type
Date <- as.Date(df$Date, format = "%d/%m/%Y")
DateTime <- paste(Date, df$Time)

Time <- strptime(DateTime, format = "%Y-%m-%d %H:%M:%S")

# define plot area and size
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

# panel devision
par(mfrow = c(2,2))

# plot first plot at first row and first column
plot(Time, df$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power")

# add 2nd plot to the second column
plot(Time, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# add 3rd plot to the second row, first column
plot(Time, df$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(Time, df$Sub_metering_2, col = "red")
lines(Time, df$Sub_metering_3, col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, box.lty = 0)

# add 4th plot to the right bottom
plot(Time, df$Global_reactive_power, xlab = "datetime", type = "l")

# close device
dev.off()