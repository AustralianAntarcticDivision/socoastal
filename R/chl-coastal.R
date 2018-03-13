
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

dens <- tbl(db, "chl_johnson_tab") %>% dplyr::filter(Zone == "Continent")
d <- dens %>% dplyr::collect(n = Inf)
#d <- as.data.frame(roc::bin2lonlat(dens$bin_num, 4320))


## get depth
topo <- readAll(raadtools::readtopo("ibcso"))
uxy <- distinct(d, bin_num) 
uxy[c("depth")] <- raster::extract(topo, as.matrix(as.data.frame(roc::bin2lonlat(uxy$bin_num, 4320))))

d <- d %>% dplyr::inner_join(uxy[c("bin_num", "depth")])
op <- options(warn = -1)
ggplot(d %>% dplyr::filter(depth >= -500),  aes(x = chla_johnson, group = decade, weight = 25, colour = decade)) + 
  geom_density() + facet_wrap(SectorName ~ season) + scale_x_log10()

ggplot(d %>% dplyr::filter(depth >= -250),  aes(x = chla_johnson, group = decade, weight = 25, colour = decade)) + 
  geom_density() + facet_wrap(SectorName ~ season) +  scale_x_log10()

ggplot(d %>% dplyr::filter(depth >= -100), aes(x = chla_johnson, group = decade, weight = 25, colour = decade)) + 
  geom_density() + facet_wrap(SectorName ~ season) + scale_x_log10()

options(op)
