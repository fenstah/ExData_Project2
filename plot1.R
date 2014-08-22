source('getdatafiles.R')

datasource <-cachedData()
NEI<-datasource$getNEI()

##Create data set for Sum of Emissions by Year and name columns respectively
totalemissions<-with(NEI, aggregate(Emissions, by = list(year), sum))
colnames(totalemissions)<-c("Year", "Emissions")

##Plot the data with a basic plot and linear regression line
png(filename = 'plot1.png', width = 500, height = 500, units = 'px')
plot(totalemissions, type="l", xlab="Year", ylab="Emissions (in tons)", main="Total Emissions in the United States ")
fit<-lm(totalemissions$Emissions~totalemissions$Year)
abline(fit, lwd=3, col="blue")
dev.off()