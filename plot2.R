source('getdatafiles.R')

datasource <-cachedData()
NEI<-datasource$getNEI()
baltimoreCityNEI<-NEI[which(NEI$fips == "24510"),]
totalemissions<-tapply(baltimoreCityNEI$Emissions, baltimoreCityNEI$year, sum)
#png(filename = 'plot1.png', width = 500, height = 500, units = 'px')
plot(names(totalemissions), totalemissions, type="l", xlab="Year", ylab="total PM2.5 emissions (in tons)", main="Total emissions in Baltimore City")
#dev.off()