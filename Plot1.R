# --------------------------------------------------------
# Setting working directory and font
# --------------------------------------------------------
setwd("/Users/pnapoli/Documents/DataScience/ExpDataAnalysis")
library(extrafont)
loadfonts()

# --------------------------------------------------------
# Reading the data from files
# --------------------------------------------------------
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# --------------------------------------------------------
# Plot1 - Answering the question: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.
# --------------------------------------------------------
TotalByYear <- aggregate(Emissions ~ year, NEI, sum)

png(filename='plot1.png', family="Garamond", size=14)
barplot(height=TotalByYear$Emissions, names.arg=TotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))
dev.off()
