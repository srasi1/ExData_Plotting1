#############################################################################
### Function to plot house hold power consumption explororatory data ########
###                                                                  ########
#############################################################################
plot3 <- function() {
	### Creating directory data if it doesn't exist
	### Down load the zip file and unzip it under data

	if(!file.exists("./data"))  {dir.create("./data")}
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(fileUrl, destfile = "./data/HHPowCons.zip", method = "curl")
	zipF <- "./data/HHPowCons.zip"
	outDir<-"./data"
	unzip(zipF,exdir=outDir)

        ### Reading the data  and then converting the column types 

	hpcdata <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE)
	names(hpcdata)[1] <- "date"
	hpcdata$date <- as.Date(hpcdata$date, "%d/%m/%Y")
	hpcdata$date <- as.Date(hpcdata$date, format = "%Y-%m-%d")
	hpcdata_dt <- hpcdata[(hpcdata$date == "2007-02-01" | hpcdata$date == "2007-02-02"),]
	temp <- strptime((paste(hpcdata_dt$date, hpcdata_dt$Time, sep = " ")), format = "%Y-%m-%d %H:%M:%S")
	hpcdata_dt$datetime <- temp
	hpcdata_dt$Global_active_power <- as.numeric(hpcdata_dt$Global_active_power)
	hpcdata_dt$Global_reactive_power <- as.numeric(hpcdata_dt$Global_reactive_power)
	hpcdata_dt$Voltage <- as.numeric(hpcdata_dt$Voltage)
	hpcdata_dt$Sub_metering_1 <- as.numeric(hpcdata_dt$Sub_metering_1)
	hpcdata_dt$Sub_metering_2 <- as.numeric(hpcdata_dt$Sub_metering_2)
	hpcdata_dt$Sub_metering_3 <- as.numeric(hpcdata_dt$Sub_metering_3)
        
	## Plot for Global Active power 

	png(filename="./figure/plot3.png", height=480, width=480)
	plot(hpcdata_dt$datetime, hpcdata_dt$Sub_metering_1, xlab = "", ylab = "Energy sub metering", ylim = c(0, 35), type = "l")
	lines(hpcdata_dt$datetime, hpcdata_dt$Sub_metering_2, type="l", col= "red")
	lines(hpcdata_dt$datetime, hpcdata_dt$Sub_metering_3, type="l", col= "blue")
	legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd=2, bty="l")
	dev.off()
}
