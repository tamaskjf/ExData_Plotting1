library(dplyr)

## Unzipping the file and subset the data set for 2007.02.01 - 2007.02.02.
all_consumption <- read.table(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), sep=";")
colnames(all_consumption) = all_consumption[1,]
all_consumption <- all_consumption[-1,]
consumption <- subset(all_consumption, all_consumption$Date == "1/2/2007" | all_consumption$Date == "2/2/2007")

## Converting the variables
consumption <- mutate(consumption, Date_Time = paste(consumption$Date, consumption$Time))
consumption$Date_Time <- strptime(consumption$Date_Time, format = "%d/%m/%Y %H:%M:%S")
consumption <- select(consumption, "Global_active_power":"Date_Time")

consumption$Global_active_power <- as.numeric(as.character(consumption$Global_active_power))
consumption$Global_reactive_power <- as.numeric(as.character(consumption$Global_reactive_power))
consumption$Voltage <- as.numeric(as.character(consumption$Voltage))
consumption$Global_intensity <- as.numeric(as.character(consumption$Global_intensity))
consumption$Sub_metering_1 <- as.numeric(as.character(consumption$Sub_metering_1))
consumption$Sub_metering_2 <- as.numeric(as.character(consumption$Sub_metering_2))
consumption$Sub_metering_3 <- as.numeric(as.character(consumption$Sub_metering_3))

## Constructing the second plot
plot(consumption$Date_Time, consumption$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Saving the second plot
dev.copy(png, filename = "plot2.png", width = 480, height = 480)
dev.off()
