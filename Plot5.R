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
# Plot5 - How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
# --------------------------------------------------------
# --------------------------------------------------------
# seeking ON-ROAD type in NEI
# --------------------------------------------------------
OnRoadNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD", ]

TotalByYear <- aggregate(Emissions ~ year,  OnRoadNEI, sum)

png("plot5.png", width=840, height=480)
graf <- ggplot(TotalByYear, aes(factor(year), Emissions))
graf <- graf + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(graf)
dev.off()
