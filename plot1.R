source('getdatafiles.R')

datasource <-cachedData()
NEI<-datasource$getNEI()
totalemissions<-tapply(NEI$Emissions, NEI$year, sum)
#png(filename = 'plot1.png', width = 500, height = 500, units = 'px')
plot(names(totalemissions), totalemissions, type="l", xlab="Year", ylab="total PM2.5 emissions (in tons)", main="Total emissions in the United States ")
#dev.off()