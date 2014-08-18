##Make sure all the raw data files exist.  
##If data files do not yet exists, download the zip file, create the data subdirectory 
##and unzip the raw data files into it
getDataFiles <- function()
{
    ##check if data subdectory exists
    if(!file.exists("./data"))
    {
        dir.create("./data")
    }
    
    ## if zip file does not exist, download it
    if(!file.exists("./data/exdata_data_NEI_data.zip"))
    {
        ## if doesnt exist download file
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "./data/exdata_data_NEI_data.zip")
    }
    
    ##check if files exist and if not extract from zip file
    if(!file.exists("./data/Source_Classification_Code.rds") | !file.exists("./data/summarySCC_PM25.rds"))
    {
        ##extract file from zip.  suppress warnings for files we dont need to overwrite
        suppressWarnings(unzip("./data/exdata_data_NEI_data.zip", overwrite = FALSE, exdir="./data"))
    }            
}

##reads in the data from the NEI and SCC data files if it is not already cached and caches it
cachedData <- function() {
    getDataFiles()
    cachedDataNEI <- attr(cachedData,"cachedDataNEI")
    if(is.null(cachedDataNEI)) {
        cachedDataNEI <-readRDS("./data/summarySCC_PM25.rds")
    }
    NEI<-cachedDataNEI     
    getNEI <- function() NEI 

    cachedDataSCC <- attr(cachedData,"cachedDataSCC")
    if(is.null(cachedDataSCC)) {
        cachedDataSCC <-readRDS("./data/Source_Classification_Code.rds")
    }
    SCC<-cachedDataSCC     
    getSCC <- function() SCC 
        
    attr(cachedData,"cachedDataNEI") <<- cachedDataNEI
    attr(cachedData,"cachedDataSCC") <<- cachedDataSCC
    
    list(getNEI=getNEI,getSCC=getSCC)     
}