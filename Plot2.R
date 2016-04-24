# --------------------------------------------------------
# Setting working directory 
# --------------------------------------------------------
setwd("/Users/pnapoli/Documents/DataScience/ExpDataAnalysis")

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
# Plot2 - Answering the question: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# --------------------------------------------------------
Baltimore <- NEI[NEI$fips=="24510", ]

TotalByYear <- aggregate(Emissions ~ year, Baltimore, sum)

png('plot2.png')
barplot(height=TotalByYear$Emissions, names.arg=TotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))
dev.off()
