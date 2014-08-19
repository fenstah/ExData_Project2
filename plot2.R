source('getdatafiles.R')

datasource <-cachedData()
NEI<-datasource$getNEI()
baltimoreCityNEI<-NEI[which(NEI$fips == "24510"),]
totalemissions<-with(baltimoreCityNEI, aggregate(Emissions, by = list(year), sum))
colnames(totalemissions)<-c("Year", "Emissions")

#png(filename = 'plot2.png', width = 500, height = 500, units = 'px')
plot(totalemissions, type="l", xlab="Year", ylab="Emissions (in tons)", main="Total Emissions in Baltimore City")
fit<-lm(totalemissions$Emissions~totalemissions$Year)
abline(fit, lwd=3, col="blue")
#dev.off()