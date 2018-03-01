## difference in area with GEBCO vs IBCSO

library(silicate)  ## devtools::install_github("hypertidy/silicate")
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

library(units)
set_units(area_ibcso_500, "km^2")
set_units(area_gebco_500, "km^2")


