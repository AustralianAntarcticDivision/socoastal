
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis build status](https://travis-ci.org/AustralianAntarcticDivision/socoastal.svg?branch=master&env=BUILD_NAME=trusty_release&label=trusty_release)](https://travis-ci.org/AustralianAntarcticDivision/socoastal) [![Travis build status](https://travis-ci.org/AustralianAntarcticDivision/socoastal.svg?branch=master&env=BUILD_NAME=osx_release&label=osx_release)](https://travis-ci.org/AustralianAntarcticDivision/socoastal) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/AustralianAntarcticDivision/socoastal?branch=master&svg=true)](https://ci.appveyor.com/project/AustralianAntarcticDivision/socoastal)

socoastal
=========

The goal of socoastal is to explore the relatively shallow regions around Antarctica.

Installation
============

Install the package from Github.

``` r
devtools::install_github("AustralianAntarcticDivision/socoastal")
```

Example
-------

This shows loading the package and creating an interactive map, with some available data layers.

See the vignette [socoastal](https://australianantarcticdivision.github.io/socoastal/articles/socoastal.html) for a live example.

``` r
library(socoastal)
library(mapview)
library(sf)
layers <- st_sf(name = c("ibcso", "gebco", "scar"), type = c("bathymetry", "bathymetry", "coastline"), 
                geometry = c(ibcso_500, gebco_500, scar_0))
m <- mapview(layers, zcol = "name", 
             color = c("#440154FF", "#21908CFF", "#000000FF"),
             legend = TRUE,
             ## http://leaflet-extras.github.io/leaflet-providers/preview/
             map.types = c("Esri.NatGeoWorldMap", "Esri.OceanBasemap", "Esri.WorldPhysical", "CartoDB.DarkMatter", "OpenStreetMap",      "Esri.WorldImagery" ))
m
```
