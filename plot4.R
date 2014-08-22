source('getdatafiles.R')

datasource <-cachedData()
NEI<-datasource$getNEI()
SCC<-datasource$getSCC()

##Get data for all records in SCC data set with '- [Cc]oal' in the EI.Sector column
coalSCC<-SCC[grep(" - [Cc]oal", SCC$EI.Sector), ]

##Get all records in NEI data set where the SCC is in the set obtained from the step executed above 
coalNEI<-NEI[which(NEI$SCC %in% coalSCC$SCC),]


##Create data set for Sum of Coal Combustion Emissions by Year and name columns respectively
totalCoalEmissions<-with(coalNEI, aggregate(Emissions, by = list(year), sum))
colnames(totalCoalEmissions)<-c("Year", "Emissions")

##Plot the data with a basic plot and linear regression line
png(filename = 'plot4.png', width = 500, height = 500, units = 'px')
plot(totalCoalEmissions, type="l", xlab="Year", ylab="Emissions (in tons)", main="Total Coal Combustion-related Emissions in the United States ")
fit<-lm(totalCoalEmissions$Emissions~totalCoalEmissions$Year)
abline(fit, lwd=3, col="blue")
dev.off()