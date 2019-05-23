# only read in as needed

library(sqldf)

df <- read.csv.sql("household_power_consumption.txt", 
                   header = TRUE, sep = ";", 
                   sql = "select * from file where Date == '1/2/2007' 
                   or Date == '2/2/2007'")

# convert to Date type
Date <- as.Date(df$Date, format = "%d/%m/%Y")
DateTime <- paste(Date, df$Time)

# convert time type
Time <- strptime(DateTime, format = "%Y-%m-%d %H:%M:%S")

# define plot area and size
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

# create line plot 
plot(Time, df$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")

# close device 
dev.off()