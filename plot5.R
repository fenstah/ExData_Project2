source('getdatafiles.R')

datasource <-cachedData()
NEI<-datasource$getNEI()

##Get data for all records in SCC data set that end with 'Vehicles' in the EI.Sector column
vehicleSCC<-SCC[grep("Vehicles$", SCC$EI.Sector), ]

##Get all records in NEI data set for Baltimore City and where the SCC is in the set obtained from the step executed above 
baltimoreCityNEI<-NEI[which(NEI$fips == "24510" & NEI$SCC %in% vehicleSCC$SCC),]
totalVehicleEmissions<-with(baltimoreCityNEI, aggregate(Emissions, by = list(year), sum))
colnames(totalVehicleEmissions)<-c("Year", "Emissions")

##Plot the data with a basic plot and linear regression line
png(filename = 'plot5.png', width = 500, height = 500, units = 'px')
plot(totalVehicleEmissions, type="l", xlab="Year", ylab="Emissions (in tons)", main="Total Motor Vehicle Emissions in Baltimore City")
fit<-lm(totalVehicleEmissions$Emissions~totalVehicleEmissions$Year)
abline(fit, lwd=3, col="blue")
dev.off()