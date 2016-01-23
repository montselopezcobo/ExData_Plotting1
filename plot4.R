######################################################################
########                EXPLORATORY DATA ANALYSIS           ##########
########                    COURSE PROJECT 1                ##########
######################################################################

                        ############
                        #  PLOT 4  #
                        ############

### --- Libraries ----

require(data.table)
require(lubridate)

### --- Download and unzip the data file ----

fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./household_power_consumption.zip", method = "curl")
unzip("household_power_consumption.zip")

### --- Read and subset the file ----
DT <- fread("household_power_consumption.txt", sep=";", header=TRUE, 
            na.strings = "?", colClasses = "character")
DT2d <- DT[DT$Date %in% c("1/2/2007","2/2/2007"),]

### --- Conversion of date and time to Data/Time classes (using lubridate) ----
DT2d$Date <- dmy_hms(paste(DT2d$Date,DT2d$Time))


# -- PLOT 4 ----
#---------------
png(file="plot4.png")
par(mfrow = c(2, 2))

plot(DT2d$Date, as.numeric(DT2d$Global_active_power),
     type="l",
     xlab="",
     ylab="Global active power")

plot(DT2d$Date, as.numeric(DT2d$Voltage),
     type="l",
     xlab="datetime",
     ylab="Voltage")

with (DT2d, {
      plot(Date, as.numeric(Sub_metering_1),
           col="black", 
           type="l",
           xlab="",
           ylab="Energy sub metering")
      lines(Date, as.numeric(Sub_metering_2),
            col="red")
      lines(Date, as.numeric(Sub_metering_3),
            col="blue")
      legend("topright", col = c("black", "red", "blue"), lty=1,
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

plot(DT2d$Date, as.numeric(DT2d$Global_reactive_power),
     type="l",
     xlab="datetime",
     ylab="Global reactive power")

dev.off()


#------------------
