source('getdatafiles.R')
library(ggplot2)

datasource <-cachedData()
NEI<-datasource$getNEI()
baltimoreCityNEI<-NEI[which(NEI$fips == "24510"),]
totalemissions<-with(baltimoreCityNEI, aggregate(Emissions, by = list(year, type), sum))
colnames(totalemissions)<-c("Year", "Type", "Emissions")

#png(filename = 'plot3.png', width = 500, height = 500, units = 'px')
#qplot(Year, Emissions, data=totalemissions, facets = .~Type, geom=c("point", "smooth"), method="lm")

##Setup ggplot with data frame
g<-ggplot(totalemissions, aes(Year, Emissions))

##Add layers
g + geom_line() + facet_grid(.~Type) + geom_smooth(method="lm") + labs(y="Emissions (in tons)") + labs(title="Total Emissions in Baltimore City by Type")

#dev.off()