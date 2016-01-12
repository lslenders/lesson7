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





# # Download municipality boundaries - TUTORIAL
# nlCity <- raster::getData('GADM',country='NLD', level=2)
# class(nlCity)
# # Investigate the structure of the object
# head(nlCity@data)
