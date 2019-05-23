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
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

# create the first line plot
plot(Time, df$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")

# add the second line 
lines(Time, df$Sub_metering_2, col = "red")

# add the third line 
lines(Time, df$Sub_metering_3, col = "blue")

# put legend box on the topright corner 
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

# close device
dev.off()