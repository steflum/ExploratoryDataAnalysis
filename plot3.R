plot3 <- function() {
      
      # Load the required packages
      library(plyr)
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
      Baltimore <- subset(NEI, fips == "24510")
      
      data <- ddply(Baltimore, c("type", "year"), summarize, Emissions = sum(Emissions))
      
      # Create Plot 3 in PNG format
      png(filename = "plot3.png")
      g <- ggplot(data, aes(year, Emissions, color = type)) +
            geom_line() +
            xlab("Year") +
            ylab(expression(paste("Total ", PM[2.5], " Emissions (ton)" ))) +
            ggtitle(expression(paste(PM[2.5], " Emissions in Baltimore City Separated by Type"))) +
            scale_color_discrete(name = "Type")
      print(g)
      dev.off()
      
}