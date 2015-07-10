######################################################################
########                EXPLORATORY DATA ANALYSIS           ##########
########                    COURSE PROJECT 1                ##########
######################################################################

                        ############
                        #  PLOT 4  #
                        ############

###--- Download and unzip the data file

fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./household_power_consumption.zip", method = "curl")
dateDownloaded <- date()

unzip("household_power_consumption.zip")

###--- Read and subset the file
DT <- fread("household_power_consumption.txt", sep=";", header=TRUE, 
            na.strings = "?", colClasses = "character")
DT2d <- DT[DT$Date %in% c("1/2/2007","2/2/2007"),]

###--- Conversion of date and time to Data/Time classes
DT2d$Time <- as.POSIXct(strptime(paste(DT2d$Date,DT2d$Time), 
                                 "%d/%m/%Y %H:%M:%S"), origin="2007-02-01", tz="GMT")
DT2d$Date <- as.Date(strptime(DT2d$Date, "%d/%m/%Y"))


# PLOT 4
#--------
png(file="plot4.png")
par(mfrow = c(2, 2))

plot(DT2d$Time, as.numeric(DT2d$Global_active_power),
     type="l",
     xlab="",
     ylab="Global active power")

plot(DT2d$Time, as.numeric(DT2d$Voltage),
     type="l",
     xlab="datetime",
     ylab="Voltage")

with (DT2d, {
      plot(Time, as.numeric(Sub_metering_1),
           col="black", 
           type="l",
           xlab="",
           ylab="Energy sub metering")
      lines(Time, as.numeric(Sub_metering_2),
            col="red")
      lines(Time, as.numeric(Sub_metering_3),
            col="blue")
      legend("topright", col = c("black", "red", "blue"), lty=1,
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

plot(DT2d$Time, as.numeric(DT2d$Global_reactive_power),
     type="l",
     xlab="datetime",
     ylab="Global reactive power")

dev.off()
