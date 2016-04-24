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
# Plot3 - Answering the questions: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008?
# --------------------------------------------------------
Baltimore <- NEI[NEI$fips=="24510", ]

TotalByYearAndType <- aggregate(Emissions ~ year + type, Baltimore, sum)

png('plot3.png', width=640, height=480)
graf <- ggplot(TotalByYearAndType, aes(year, Emissions, color = type))
graf <- graf + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
print(graf)
dev.off()
