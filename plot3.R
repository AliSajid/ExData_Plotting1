## Adding the script for the first plot.

## Check if the data alread exists. If not, then download it.

datafile <- "uci-data.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datadir <- "data"
mainfile <- "household_power_consumption.txt"

if(!dir.exists(datadir)) {dir.create(datadir)}

if(!file.exists(file.path(datadir, datafile))) {
  download.file(url, destfile = file.path(datadir, datafile))
}

if(!file.exists(file.path(datadir, mainfile))) {
  unzip(file.path(datadir, datafile), exdir = datadir)
}

## Read all the data

data <- read.table("data/household_power_consumption.txt", header = T, sep = ";", na.strings = "?")

## Subset the data and then fix the timestamps

data <- data %>%
          subset(Date %in% c("1/2/2007","2/2/2007")) %>%
          mutate(Timestamp = as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))) %>%
          select(-Date, -Time)


## Make Plot 3
plot3 <- function() {
  par(mfrow = c(1,1), mar = c(5.1, 4.1, 4.1, 2.1))
  line.colors = c("black", "red", "blue")
  line.labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  with(data, plot(Timestamp, Sub_metering_1, type = "l", col = line.colors[1], xlab = "", ylab = "Energy sub metering"))
  with(data, lines(Timestamp, Sub_metering_2, type = "l", col = line.colors[2]))
  with(data, lines(Timestamp, Sub_metering_3, type = "l", col = line.colors[3]))
  legend("topright", legend = line.labels, col = line.colors, lty = "solid")
}

plot3()
## Make the PNG file too.

png(filename = "plot3.png", height = 480, width = 480)
plot3()
dev.off()