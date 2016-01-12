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

## Calculations --------------------------------------------

## Select Month = January on MODIS
MODIS_month <- raster(MODIS, 1)
# MODIS_month <- MODIS@layers[[1]]    ## Both ways work to select a column from a raster package
# plot(MODIS_month)


## Import municipality mask & Apply CRS 
# for country =NLD ;level of detail=2
municipality_mask <- spTransform(raster::getData('GADM',country= "NLD", level= 2), CRS(proj4string(MODIS)))


## Extracting NDVI; calculate mean; for defined mask ---------------------------------------------
paste(" takes some time ...")
raw_NDVI_NL <- extract(MODIS_month, 
                   municipality_mask,
                   sp=TRUE,
                   df=TRUE,
                   fun=mean) ## df=TRUE i.e. return as a data.frame

str(raw_NDVI_NL@data) # to check month-colum header; NDVI-name

## Remove NA values ------! still month in the column header!! ???
NDVI_NL <- raw_NDVI_NL[!is.na(raw_NDVI_NL$January),] ## remove rows with NA

# answer computing --------------------------------------------------------------------------------


df <- NDVI_NL@data # has municip name as " df$NAME_2"  ; NDVI as " month name" 

# xplore data
str(NDVI_NL@data)
df$NAME_2           # municipalityname
df$January          # NDVI values



# select max NDVI ;  and display corresponding Municipality name
answer <- df[which(df$January == max(df$January, na.rm = TRUE)), ]$NAME_2
answer


