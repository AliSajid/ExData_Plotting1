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


## Make Plot 2

with(data,
     plot(Timestamp, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

## Make the PNG file too.

png(filename = "plot2.png", height = 480, width = 480)
with(data, plot(Timestamp, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()