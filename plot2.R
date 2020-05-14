# following code to read and process data from file is similar to plot1.R

library(lubridate)
# read the data from the text file and get the required columns
all_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")[, c(1, 2, 3)]
# dates were read as numeric fields. Convert them to Date using lubridate's dmy function
all_data[, 1] <- dmy(all_data[, 1])
# subset the data.frame to get the dates we need
req_data <- subset(all_data, Date %in% c(ymd("2007-02-01"), ymd("2007-02-02")))
# use lubridate to read the time fields
req_data[, 2] <- hms(req_data[, 2])
# make the Global active power variable numeric
req_data[, 3] <- as.numeric(req_data[, 3])

# open the png graphics device
png("plot2.png")
# plot the global active power as a function of the time specifying type = "l" creates a line graph
with(req_data, plot(Date + Time, Global_active_power, type = "l", xlab = "",
                    ylab = "Global Active Power (kilowatts)"))
# close the graphics device
dev.off()