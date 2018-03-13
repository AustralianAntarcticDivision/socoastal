## difference in area with GEBCO vs IBCSO
library(socoastal)
library(silicate)  ## devtools::install_github
library(sf)
xy_ibcso <- sc_coord(st_transform(st_cast(ibcso_500, "LINESTRING"), st_crs(scar_poly))) %>% 
  dplyr::distinct()
head1 <- function(x) {
  rbind(x, head(x, 1L))
}
ibcso_500_poly <- st_sfc(st_polygon(list(as.matrix(head1(xy_ibcso)))), 
                         crs = st_crs(scar_poly))

xy_gebco <- sc_coord(st_transform(st_cast(gebco_500, "LINESTRING"), st_crs(scar_poly))) %>% 
  dplyr::distinct()
gebco_500_poly <- st_sfc(st_polygon(list(as.matrix(head1(xy_gebco)))), 
                         crs = st_crs(scar_poly))

area_ibcso_500 <- st_area(st_difference(ibcso_500_poly, scar_poly))
area_gebco_500 <- st_area(st_difference(gebco_500_poly, scar_poly))

xy_ibcso <- sc_coord(st_transform(st_cast(ibcso_250, "LINESTRING"), st_crs(scar_poly))) %>% 
  dplyr::distinct()
head1 <- function(x) {
  rbind(x, head(x, 1L))
}
ibcso_250_poly <- st_sfc(st_polygon(list(as.matrix(head1(xy_ibcso)))), 
                         crs = st_crs(scar_poly))

xy_gebco <- sc_coord(st_transform(st_cast(gebco_250, "LINESTRING"), st_crs(scar_poly))) %>% 
  dplyr::distinct()
gebco_250_poly <- st_sfc(st_polygon(list(as.matrix(head1(xy_gebco)))), 
                         crs = st_crs(scar_poly))


xy_ibcso <- sc_coord(st_transform(st_cast(ibcso_100, "LINESTRING"), st_crs(scar_poly))) %>% 
  dplyr::distinct()
head1 <- function(x) {
  rbind(x, head(x, 1L))
}
ibcso_100_poly <- st_sfc(st_polygon(list(as.matrix(head1(xy_ibcso)))), 
                         crs = st_crs(scar_poly))

xy_gebco <- sc_coord(st_transform(st_cast(gebco_100, "LINESTRING"), st_crs(scar_poly))) %>% 
  dplyr::distinct()
gebco_100_poly <- st_sfc(st_polygon(list(as.matrix(head1(xy_gebco)))), 
                         crs = st_crs(scar_poly))

area_ibcso_500 <- st_area(st_difference(ibcso_500_poly, scar_poly))
area_gebco_500 <- st_area(st_difference(gebco_500_poly, scar_poly))

area_ibcso_250 <- st_area(st_difference(ibcso_250_poly, scar_poly))
area_gebco_250 <- st_area(st_difference(gebco_250_poly, scar_poly))


area_ibcso_100 <- st_area(st_difference(ibcso_100_poly, scar_poly))
area_gebco_100 <- st_area(st_difference(gebco_100_poly, scar_poly))




library(units)
set_units(area_ibcso_500, "km^2")
set_units(area_gebco_500, "km^2")

set_units(area_ibcso_250, "km^2")
set_units(area_gebco_250, "km^2")

set_units(area_ibcso_100, "km^2")
set_units(area_gebco_100, "km^2")



library(raadtools)

ice <- readice()
cell100 <- cellFromPolygon(ice, as(st_transform(st_difference(ibcso_100_poly, scar_poly), projection(ice)), "Spatial"))
plot(xyFromCell(ice, cell100[[1]]), pch = ".", asp = 1)
length(cell100[[1]])
cell250 <- cellFromPolygon(ice, as(st_transform(st_difference(ibcso_250_poly, scar_poly), projection(ice)), "Spatial"))
plot(xyFromCell(ice, cell250[[1]]), pch = ".", asp = 1)
length(cell250[[1]])
cell500 <- cellFromPolygon(ice, as(st_transform(st_difference(ibcso_500_poly, scar_poly), projection(ice)), "Spatial"))
plot(xyFromCell(ice, cell500[[1]]), pch = ".", asp = 1)
length(cell500[[1]])