
## preparation
library(aceecostats)
library(raster)
library(dplyr)
library(ggplot2)

library(tidyr)
library(DT)
#db <- src_sqlite("/mnt/acebulk/habitat_assessment_output.sqlite3")
dp <- "/home/acebulk/data"
db <- dplyr::src_sqlite(file.path(dp, "habitat_assessment.sqlite3"))

dens <- tbl(db, "ice_days_density_tab") %>% dplyr::filter(Zone == "Continent")
d <- dens %>% dplyr::collect(n = Inf)
 icegrid <- raster(extent(-3950000, 3950000, -3950000, 4350000), 
                   crs = "+proj=stere +lat_0=-90 +lat_ts=-70 +lon_0=0 +k=1 +x_0=0 +y_0=0 +a=6378273 +b=6356889.449 +units=m +no_defs", 
                   res = 25000)
 

## get depth
topo <- readAll(raadtools::readtopo("ibcso"))
uxy <- distinct(d, cell_) %>% dplyr::mutate(x = xFromCell(icegrid, cell_), y = yFromCell(icegrid, cell_))
uxy$depth <- raster::extract(topo, 
                             rgdal::project(
                             rgdal::project(as.matrix(uxy[c("x", "y")]), projection(icegrid), inv = TRUE), 
                             projection(topo)))

d <- d %>% dplyr::inner_join(uxy[c("cell_", "depth")])
op <- options(warn = -1)
ggplot(d %>% dplyr::filter(depth >= -500) %>% 
         dplyr::filter(days < 365 ), aes(x = days, group = decade, weight = area, colour = decade)) + geom_density() + facet_wrap(SectorName ~ season)

ggplot(d %>% dplyr::filter(depth >= -250) %>% 
         dplyr::filter(days < 365 ), aes(x = days, group = decade, weight = area, colour = decade)) + geom_density() + facet_wrap(SectorName ~ season)

ggplot(d %>% dplyr::filter(depth >= -100) %>% 
         dplyr::filter(days < 365 ), aes(x = days, group = decade, weight = area, colour = decade)) + geom_density() + facet_wrap(SectorName ~ season)

options(op)
