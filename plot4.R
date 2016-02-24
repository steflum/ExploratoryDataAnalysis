plot4 <- function() {
      
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
      
      # Subset out only the coal combustion data
      coal_data <- subset(SCC, grepl("Coal", Short.Name) & !grepl("Mining", EI.Sector))
      mergedata <- merge(NEI, coal_data, by = "SCC", all.y = TRUE)
      emissions <- aggregate(Emissions ~ year, mergedata, sum)
      
      # Create Plot 4 in PNG format
      png(filename = "plot4.png")
      g <- ggplot(emissions, aes(x = year, y = Emissions)) +
            geom_line() +
            ylab(expression(paste("Total ", PM[2.5], " Emissions (tons)"))) +
            xlab("Year") +
            ggtitle(expression(paste("Coal Combustion ", PM[2.5], " Emissions in the US (1999 - 2008)")))
      print(g)
      dev.off()
}