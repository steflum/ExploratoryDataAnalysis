plot1() <- function() {
     
      # Check to see if the file exists. If false, download and unzip the file
      if (!file.exists("Emissions_Data.zip")) {
            FileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
            download.file(FileURL, destfile = "Emissions_Data.zip")
            unzip("Emissions_Data.zip")
      }
      
      # Read the RDS files
      NEI <- readRDS("summarySCC_PM25.rds")
      SCC <- readRDS("Source_Classification_Code.rds")
      
      # Find the total PM2.5 emissions for the years 1999, 2002, 2005, and 2008
      emissions <- with(NEI, tapply(Emissions, year, sum))
      
      # Create Plot 1 in PNG format
      png(filename = "plot1.png")
      plot(names(emissions), emissions, type = "l",
           main = expression(paste("Total ", PM[2.5], " Emissions in the United States from 1999 to 2008")),
           xlab = "Year", ylab = expression(paste("Total ", PM[2.5], " Emissions (tons)")))
      dev.off()
      
}