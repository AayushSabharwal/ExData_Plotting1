library(lubridate)
# read the data from the text file and get the columns corresponding to date and global active power
all_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")[, c(1, 3)]
# dates were read as numeric fields. Convert them to Date using lubridate's dmy function
all_data[, 1] <- dmy(all_data[, 1])
# subset the data.frame to get the dates we need
req_data <- subset(all_data, Date %in% c(ymd("2007-02-01"), ymd("2007-02-02")))
# make the Global active power variable numeric
req_data[, 2] <- as.numeric(req_data[, 2])
# create a png file to store the graph
png("plot1.png")
# plot a histogram with the appropriate colour, x axis label and title
hist(req_data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
# close the graphics device
dev.off()
