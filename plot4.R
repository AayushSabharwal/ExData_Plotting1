# following code to read and process data from file is similar to plot1.R

library(lubridate)
# read the data from the text file and get the required columns
all_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")[,-6]
# dates were read as numeric fields. Convert them to Date using lubridate's dmy function
all_data[, 1] <- dmy(all_data[, 1])
# subset the data.frame to get the dates we need
req_data <- subset(all_data, Date %in% c(ymd("2007-02-01"), ymd("2007-02-02")))
# use lubridate to read the time fields
req_data[, 2] <- hms(req_data[, 2])
# make the appropriate fields numeric
for(i in 3:8)
    req_data[, i] <- as.numeric(req_data[, i])

# open the png graphics device
png("plot4.png")
# use par and specify mfrow to create a 2x2 grid of plots
par(mfrow = c(2, 2))
# plot the first graph, as in plot2
with(req_data, plot(Date + Time, Global_active_power, type = "l", xlab = "",
                    ylab = "Global Active Power (kilowatts)"))

# plot the second graph
with(req_data, plot(Date + Time, Voltage, type = "l", xlab = "datetime", 
                    ylab = "Voltage"))

# plot the third graph, as in plot3
with(req_data, plot(Date + Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(req_data, points(Date + Time, Sub_metering_2, col = "red", type = "l"))
with(req_data, points(Date + Time, Sub_metering_3, col = "blue", type = "l"))
# legend is same as in plot3, except we specify bty = "n" so that the box has no border
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd = 1, bty = "n")

# plot the fourth graph
with(req_data, plot(Date + Time, Global_reactive_power, type = "l", xlab = "datetime"))

# close the graphics device
dev.off()