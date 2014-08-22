source('getdatafiles.R')
library(ggplot2)

datasource <-cachedData()
NEI<-datasource$getNEI()

##Create data set for Sum of Emissions for Baltimore City and Los Angeles by Year and fips
##and set name columns respectively
cityNEI<-NEI[which(NEI$fips == "24510" | NEI$fips == "06037"),]
totalCityEmissions<-with(cityNEI, aggregate(Emissions, by = list(year, fips), sum))
colnames(totalCityEmissions)<-c("Year", "fips", "Emissions")

##change fips to a factor so we can change the label from zip code to name of county
totalCityEmissions$fips<-factor(totalCityEmissions$fips)
levels(totalCityEmissions$fips)<-c("Los Angeles County", "Baltimore City")
png(filename = 'plot6.png', width = 500, height = 500, units = 'px')

##Setup ggplot with data frame
g<-ggplot(totalCityEmissions, aes(Year, Emissions))

##Add layers
g<- g + geom_line() + facet_grid(.~fips) + geom_smooth(method="lm") + labs(y="Emissions (in tons)") + labs(title="Total Emissions Between Baltimore City and Los Angeles County")
print(g)
dev.off()

##The resulting plot shows different scales.  Difficult to answer the question due to this
##Thus, creating a plot that shows the difference as a percentage from the 1999 per county
##so the scales should the the same
originalEmissions<-totalCityEmissions[which(totalCityEmissions$Year=="1999"),2:3]
totalEmissionsPercentage<-merge(totalCityEmissions, originalEmissions, by.x = "fips", by.y="fips")
totalEmissionsPercentage$Pct<-(totalEmissionsPercentage$Emissions.x/totalEmissionsPercentage$Emissions.y)*100

png(filename = 'plot6_2.png', width = 500, height = 500, units = 'px')
g<-ggplot(totalEmissionsPercentage, aes(Year, Pct))

##Add layers
g<- g + geom_line() + facet_grid(.~fips) + geom_smooth(method="lm") + labs(y="Percentage of Original Emissions") + labs(title="Total Emissions Between Baltimore City and Los Angeles County")
print(g)
dev.off()