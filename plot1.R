# only read in as needed

library(sqldf)

df <- read.csv.sql("household_power_consumption.txt", 
                   header = TRUE, sep = ";", 
                   sql = "select * from file where Date == '1/2/2007' 
                   or Date == '2/2/2007'")

# define the plot area and size
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")

# create a histogram 
hist(df$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

# close device
dev.off()