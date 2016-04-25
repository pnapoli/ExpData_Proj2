# --------------------------------------------------------
# Setting working directory and libraries
# --------------------------------------------------------
setwd("/Users/pnapoli/Documents/DataScience/ExpDataAnalysis")
library(ggplot2)

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
# Merging the datasets
# --------------------------------------------------------
if(!exists("NEIplusSCC")){
  NEIplusSCC <- merge(NEI, SCC, by="SCC")
}

# --------------------------------------------------------
# Plot6 - Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
# --------------------------------------------------------
# --------------------------------------------------------
# seeking ON-ROAD type in NEI - Baltimore = 24510 and Los Angeles 06037
# --------------------------------------------------------
OnRoadNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD", ]

TotalByYearAndFips <- aggregate(Emissions ~ year + fips,  OnRoadNEI, sum)
TotalByYearAndFips$fips[TotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
TotalByYearAndFips$fips[TotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
graf <- ggplot(TotalByYearAndFips, aes(factor(year), Emissions))
graf <- graf + facet_grid(. ~fips)
graf <- graf + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(graf)
dev.off()
