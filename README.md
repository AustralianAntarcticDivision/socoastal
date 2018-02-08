
<!-- README.md is generated from README.Rmd. Please edit that file -->
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

See the vignette [socoastal]() for a live example.

``` r
library(socoastal)
library(mapview)
mapview(ibcso_500, color = "dodgerblue") + 
  mapview(gebco_500, color = "firebrick") + 
  mapview(scar_0, color = "black")
```
