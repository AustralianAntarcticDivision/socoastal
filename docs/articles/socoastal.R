## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(socoastal)
library(mapview)
mapview(ibcso_500, color = "dodgerblue") + 
  mapview(gebco_500, color = "firebrick") + 
  mapview(scar_0, color = "black")

