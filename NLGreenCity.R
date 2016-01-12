## NL greenest city
## Team Puma
## Jason Davis & Lieven Slenders. 
## January 12-1-2015
## Lesson 7
# -------------------------------------------------------

## Create a working directory to maintain input and output data
createFolders <- function() {
  dir.create('data/') -> ifolder
  dir.create('R/') 
  dir.create('output/') -> ofolder
}

# Download 
source('R/downloadData.R')
downloadData("https://github.com/GeoScripting-WUR/VectorRaster/raw/gh-pages/data/MODIS.zip", 
             "data/MODIS")
# Unzip file
source('R/unzipFile.R')
unzipFile('data/MODIS', 'data')

## Reading the grd file
library(sp)
library(raster)
MODIS <- stack("data/MOD13A3.A2014001.h18v03.005.grd")


## Select January
          ## Both ways work to select a column from a raster package
MODIS_jan <- raster(MODIS, 1)
#MODIS_jan <- MODIS@layers[[1]]
#plot(January)

## Import municipality mask & Apply CRS 
municipality_mask <- spTransform(raster::getData('GADM',country= "NLD", level= 2), CRS(proj4string(MODIS)))

## Extracting NDVI for defined mask          
NDVI_NL <- extract(MODIS_jan, municipality_mask, sp=TRUE, df=TRUE, fun=mean) ## df=TRUE i.e. return as a data.frame

str(NDVI_NL@data)

data <- NDVI_NL@data

df$NAME_2
max(df$January)
t <-cbind(df$NAME_2,df$January)

# # Combine the newly created dataframe to the description column 
colMax <- function(data)

sapply(data, max, na.rm = TRUE)




##Remove NA values
NDVI_NL_no_NA <- NDVI_NL[!is.na(NDVI_NL$January),] ## remove rows with NA
# max value 
max(NDVI_NL_no_NA$January)



DF <- list("NDVI" = NDVI_NL_no_NA$January, "Municipalities" = municipality_mask)
 %in% NDVI_NL_no_NA$January

#






# class(NDVI_NL)  ## computation efficiency: Is there more data than shown? 








