## TODO
## get bathy lines
## IBCSO
## GEBCO_14
## just get main line (drop depressions)
## fix dateline bs
library(raadtools)
topo <- readAll(readtopo('ibcso'))
cl <- rasterToContour(topo, levels = -500)

library(sf)
library(lwgeom)
ibcso_500 <- st_as_sf(raadtools:::keepOnlyMostComplexLine(cl))
st_wrap_dateline(ibcso_500)
splitline <- st_buffer(st_transform(st_sfc(st_linestring(cbind(180, c(-30, -80))), crs = 4326), st_crs(ibcso_500)), 1)
x <- st_difference(ibcso_500, splitline)
ibcso_500 <- st_union(st_transform(x, 4326))
usethis::use_data(ibcso_500)


topo <- crop(readtopo('gebco_14'), extent(-180, 180, -90, -40))
cl <- rasterToContour(topo, levels = -500)
gebco_500 <- st_cast(st_geometry(st_as_sf(raadtools:::keepOnlyMostComplexLine(cl))), "MULTILINESTRING")
usethis::use_data(gebco_500)
##get hires coastline available and aceeco regions

library(CCAMLRGIS)
#library(help = "CCAMLRGIS")
Coast <- load_Coastline("RDATA")

scar_0 <- st_cast(st_as_sf(subset(Coast, gid == 1213)), "LINESTRING")
splitline <- st_buffer(st_transform(st_sfc(st_linestring(cbind(-180, c(-60, -88))), crs = 4326), st_crs(scar_0)), 1)
x <- st_difference(scar_0, splitline)
scar_0 <- st_union(st_transform(x, 4326))
usethis::use_data(scar_0)

scar_poly <- st_as_sf(subset(Coast, gid == 1213))
usethis::use_data(scar_poly)
