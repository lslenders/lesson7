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

## Preprocessing ----------------------------------------
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
MODIS
## Calculations --------------------------------------------

## Import municipality mask & Apply CRS 
# for country =NLD ;level of detail=2
municipality_mask <- spTransform(raster::getData('GADM',country= "NLD", level= 2), CRS(proj4string(MODIS)))

## Extracting NDVI; calculate mean; for defined mask ---------------------------------------------
paste(" takes some time ...")

NDVI_NL <- extract(MODIS, 
                   municipality_mask,
                   sp=TRUE,
                   df=TRUE,
                   fun=mean) ## df=TRUE i.e. return as a data.frame


## Define dataframe as variable to make easier to work with
df <- NDVI_NL@data # has municip name as " df$NAME_2"  ; NDVI as " month name" 

## Add column for yearly average of NDVI values to dataframe
df$yearMean <- rowMeans(df[16:27], na.rm = TRUE)


# answer computing --------------------------------------------------------------------------------
##  ! Still; in progress; confirm nnew deadline !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## function to take max value of NDVI for a given time period
findGreenestCity <- function() {
  ## will add flow control 
    # nered to make it more generic still
  greenestCityJanuary <- c(df[which(df$January == max(df$January, na.rm = TRUE)), ]$NAME_2,
                                     df[which(df$January == max(df$January, na.rm = TRUE)), ]$January)
  greenestCityAugust <- c(df[which(df$August == max(df$August, na.rm = TRUE)), ]$NAME_2,
                                     df[which(df$August == max(df$August, na.rm = TRUE)), ]$August)
  greenestCityYear <- c(df[which(df$yearMean == max(df$yearMean, na.rm = TRUE)), ]$NAME_2,
                                    df[which(df$yearMean == max(df$yearMean, na.rm = TRUE)), ]$yearMean)
  return(c(greenestCityJanuary,greenestCityAugust,greenestCityYear))
  
  ## with correct IF- requisite it will plot the outcome
  # in order to plot first match df return to NDVI_NL
  # plot()
}


findGreenestCity()


