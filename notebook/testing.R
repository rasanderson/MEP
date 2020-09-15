# Simple commands to check interactively.
# Need to get this working properly for different geoms
rm(list=ls())
#library(vegan)
library(bio2020)

data("dune")
dune_pca <- ordi_pca(dune)

# Both sites and spp
dune_plt <- ordi_plot(dune_pca, geom="point")
dune_plt
ordi_identify(dune_plt)

# Species
dune_plt <- ordi_plot(dune_pca, display="species", geom="point")
dune_plt
ordi_identify(dune_plt)

# Sites
dune_plt <- ordi_plot(dune_pca, display="sites", geom="point")
dune_plt
ordi_identify(dune_plt)

# Original material used in learnr tutorial
# # Display both on the same plot
# autoplot(dune_pca, geom="text", arrows = FALSE)
#
# # Display quadrat PCA scores for axes 1 and 2
# autoplot(dune_pca, layers="sites", geom="text", legend.position = "none") %>%
#   gf_labs(title="PC1 and PC2 of dune data showing quadrat numbers") %>%
#   gf_lims(x = c(-2,2.85), y=c(-2.4, 2.2))
#
# # Display plant species PCA scores for axes 1 and 2
# autoplot(dune_pca, layers="species", arrows = FALSE, legend.position = "none") %>%
#   gf_labs(title="PC1 and PC2 of dune data showing species codes") %>%
#   gf_lims(x = c(-2,2.85), y=c(-2.4, 2.2))

# Re-written for bio2020 package
# Display both on the same plot
ordi_plot(dune_pca, geom="text")

# Display quadrat PCA scores for axes 1 and 2
ordi_plot(dune_pca, display="sites", geom="text") %>%
  gf_labs(title="PC1 and PC2 of dune data (quadrat numbers)") %>%
  gf_lims(x = c(-2,2.85), y=c(-2.4, 2.2))

# Display plant species PCA scores for axes 1 and 2
ordi_plot(dune_pca, layers="species", geom="text") %>%
  gf_labs(title="PC1 and PC2 of dune data (spp codes)") %>%
  gf_lims(x = c(-2,2.85), y=c(-2.4, 2.2))
