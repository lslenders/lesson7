## NL greenest city
## Team Puma
## Jason Davis & Lieven Slenders. 
## January 12-1-2015
## Lesson 7
# -------------------------------------------------------
getwd()
setwd("D:/workspace/geoscripting/lesson7")
createFolders <- function() {
  dir.create('data/')
  dir.create('R/')
  dir.create('output/')
}

# Download 
source('R/downloadData.R')
downloadData("https://github.com/GeoScripting-WUR/VectorRaster/raw/gh-pages/data/MODIS.zip", 
             "data/MODIS")
# Unzip file
source('R/unzipFile.R')
unzipFile('data/MODIS', 'data')


