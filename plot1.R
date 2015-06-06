################################################################################
# To create the targeted_power.txt, I did the following on the terminal:
#
# $ grep -n "^[12]/2/2007" household_power_consumption.txt | head -2
#
# 66638:1/2/2007;00:00:00;0.326;0.128;243.150;1.400;0.000;0.000;0.000
# 66639:1/2/2007;00:01:00;0.326;0.130;243.320;1.400;0.000;0.000;0.000
#
# $ grep -n "^[12]/2/2007" household_power_consumption.txt | tail -2
#
# 69516:2/2/2007;23:58:00;3.658;0.220;239.610;15.200;0.000;1.000;17.000
# 69517:2/2/2007;23:59:00;3.680;0.224;240.370;15.200;0.000;2.000;18.000
#
# $ sed -n '66638,69517p' household_power_consumption.txt > targeted_power.txt
#
################################################################################

# load data.table
library(data.table)

# Convert targeted_power.txt to a table format
data = read.table("targeted_power.txt", header = TRUE, sep = ";", dec = ".",
                  col.names = c("Date", "Time", "Global_active_power", 
                                "Global_reactive_power",
                                "Voltage", "Global_intensity", "Sub_metering_1", 
                                "Sub_metering_2", "Sub_metering_3"), 
                  na.strings = "?")

dt = data.table(data)

# Create the graph on Rstudio first, then create a PNG copy of the file
# Plot the histogram of Global_active_power 
hist(dt$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

# Create a PNG file of the histogram
dev.copy(png, file = "plot1.png")
dev.off()

