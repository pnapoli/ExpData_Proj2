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

# --------------------------------------------------------
# Plot4 - Answering the question: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# --------------------------------------------------------
# --------------------------------------------------------
# seeking all NEI SCC records with Short.Name (SCC) Coal
# --------------------------------------------------------
coalMatches  <- grepl("coal", NEIplusSCC$Short.Name, ignore.case=TRUE)
subsetNEIplusSCC <- NEIplusSCC[coalMatches, ]

TotalByYearAndType <- aggregate(Emissions ~ year,  subsetNEIplusSCC, sum)

png("plot4.png", width=640, height=480)
graf <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
graf <- graf + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(graf)
dev.off()

    Status API Training Shop Blog About 

    © 2016 GitHub, Inc. Terms Privacy Security Contact Help 



