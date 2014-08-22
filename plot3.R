source('getdatafiles.R')
library(ggplot2)

datasource <-cachedData()
NEI<-datasource$getNEI()

##Create data set for Sum of Emissions for Baltimore City by Year and name columns respectively
baltimoreCityNEI<-NEI[which(NEI$fips == "24510"),]
totalemissions<-with(baltimoreCityNEI, aggregate(Emissions, by = list(year, type), sum))
colnames(totalemissions)<-c("Year", "Type", "Emissions")

##Plot the data with a ggplot plot with facets for 'type' and smoothed with 'lm'
png(filename = 'plot3.png', width = 500, height = 500, units = 'px')

##Setup ggplot with data frame
g<-ggplot(totalemissions, aes(Year, Emissions))

##Add layers
g<-g + geom_line() + facet_grid(.~Type) + geom_smooth(method="lm") + labs(y="Emissions (in tons)") + labs(title="Total Emissions in Baltimore City by Type")
print(g)
dev.off()