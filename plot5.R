plot5 <- function() {
      
      # Load the required packages
      library(ggplot2)
      
      # Check to see if the file exists. If false, download and unzip the file
      if (!file.exists("Emissions_Data.zip")) {
            FileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
            download.file(FileURL, destfile = "Emissions_Data.zip")
            unzip("Emissions_Data.zip")
      }
      
      # Read the RDS files
      NEI <- readRDS("summarySCC_PM25.rds")
      SCC <- readRDS("Source_Classification_Code.rds")
      
      # Create a relevant data set
      Baltimore <- subset(NEI, fips == "24510")
      vehicle_data <- subset(SCC, grepl("Vehicle", EI.Sector))
      mergedata <- merge(Baltimore, vehicle_data, by = "SCC", all.y = TRUE)
      emissions <- aggregate(Emissions ~ year, mergedata, sum)
      
      # Create Plot 5 in PNG format
      png(filename = "plot5.png")
      g <- ggplot(emissions, aes(x = year, y = Emissions)) +
            geom_line() +
            ylab(expression(paste("Total ", PM[2.5], " Emissions (tons)"))) +
            xlab("Year") +
            ggtitle(expression(paste("Motor Vehicle ", PM[2.5], " Emissions in Baltimore City (1999 - 2008)")))
      print(g)
      dev.off()
}