# following code to read and process data from file is similar to plot1.R

library(lubridate)
# read the data from the text file and get the required columns
all_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")[, c(1, 2, 7, 8, 9)]
# dates were read as numeric fields. Convert them to Date using lubridate's dmy function
all_data[, 1] <- dmy(all_data[, 1])
# subset the data.frame to get the dates we need
req_data <- subset(all_data, Date %in% c(ymd("2007-02-01"), ymd("2007-02-02")))
# use lubridate to read the time fields
req_data[, 2] <- hms(req_data[, 2])
# make the sub metering fields numeric
req_data[, 3] <- as.numeric(req_data[, 3])
req_data[, 4] <- as.numeric(req_data[, 4])
req_data[, 5] <- as.numeric(req_data[, 5])

# open the png graphics device
png("plot3.png")
# plot sub_metering_1 variable as a function of time, using type = "l" to create a line graph and
# specifying appropriate x and y axis labels
with(req_data, plot(Date + Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
# plot other two sub_metering fields using points function and specifying appropriate colour
with(req_data, points(Date + Time, Sub_metering_2, col = "red", type = "l"))
with(req_data, points(Date + Time, Sub_metering_3, col = "blue", type = "l"))
# add a legend, at the top right corner of the graph, and specifying lwd so that lines would be drawn of
# appropriate colour specified in col
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd = 1)
# close the graphics device
dev.off()