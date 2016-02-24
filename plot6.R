plot6 <- function() {
      
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
      subsetdata <- subset(NEI, fips == "24510"| fips == "06037")
      vehicle_data <- subset(SCC, grepl("Vehicle", EI.Sector))
      mergedata <- merge(subsetdata, vehicle_data, by = "SCC", all.y = TRUE)
      emissions <- aggregate(Emissions ~ year + fips, mergedata, sum)
      
      # Create Plot 6 in PNG format
      png(filename = "plot6.png")
      g <- ggplot(emissions, aes(x = year, y = Emissions, color = fips)) +
            geom_line() +
            ylab(expression(paste("Total ", PM[2.5], " Emissions (tons)"))) +
            xlab("Year") +
            ggtitle(expression(paste("Motor Vehicle ", PM[2.5], " Emissions by City (1999 - 2008)"))) +
            scale_color_discrete(name = "City", breaks = c("06037", "24510"), labels = c("Los Angeles County", "Baltimore City"))
      print(g)
      dev.off()
}