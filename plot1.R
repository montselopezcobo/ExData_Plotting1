######################################################################
########                EXPLORATORY DATA ANALYSIS           ##########
########                    COURSE PROJECT 1                ##########
######################################################################

                        ############
                        #  PLOT 1  #
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


# PLOT 1
#--------
png(file="plot1.png")
hist(as.numeric(DT2d$Global_active_power), 
     col = "red", 
     main="Global active power",
     xlab="Global active power (kilowatts)") 
dev.off()
