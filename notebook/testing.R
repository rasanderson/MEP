# Simple commands to check interactively.
rm(list=ls())
#library(vegan)
library(bio2020)

data("dune")
dune_pca <- rda(dune)
dune_plt <- autoplot(dune_pca, layers="species", geom="point", legend.position="none", arrows=FALSE)
dune_plt


ordi_identify(dune_plt, dune_pca, "species")

