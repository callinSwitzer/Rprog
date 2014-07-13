######
## Project 1

## read in data
bin <- getBinaryURL("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                    ssl.verifypeer=FALSE)
con <- file("exdata_data_household_power_consumption.zip", open = "wb")
writeBin(bin, con)
close(con)

pwr <- read.table(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), 
                  sep = ";", header = T, stringsAsFactors = F)

## convert time and date to useful format
pwr$Date <- as.Date(pwr$Date, format = "%d/%m/%Y")
pwr$dateTime <- paste(pwr$Date, pwr$Time, sep = " ")
pwr$dateTime1 <- strptime(pwr$dateTime, format = "%Y-%m-%d %H:%M:%S")


## subset data
pw <- pwr[pwr$Date == "2007-02-01" | pwr$Date ==  "2007-02-02", ]

## make plots
png("~/Documents/Rprog/plot3.png", width = 480, height = 480)

plot(as.numeric(pw$Sub_metering_1) ~ as.POSIXct(pw$dateTime), type = "l", 
     xlab = "", ylab = "Energy Sub Metering")
lines(as.numeric(pw$Sub_metering_2) ~ as.POSIXct(pw$dateTime), type = "l", 
      xlab = "", ylab = "Energy Sub Metering", col = "red")
lines(as.numeric(pw$Sub_metering_3) ~ as.POSIXct(pw$dateTime), type = "l", 
      xlab = "", ylab = "Energy Sub Metering", col = "blue")
legend("topright", colnames(pw)[7:9], lty=c(1,1,1), col = c("black", "red", "blue"))

dev.off()
