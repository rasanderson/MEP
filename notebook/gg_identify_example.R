library(tidyverse)
library(vegan)
source("R/gg_identify.R")

mtcars_plt <- ggplot(mtcars, aes(x=mpg, y=hp)) +
  geom_point()



# iris_plt <- ggplot(dune_sco, aes(x=PC1, y=PC2, fill=Use)) +
#   geom_point() +
#   geom_chull(alpha=0.5) + # What do you think alpha does??
#   theme_classic()  # Add this if you don't like the grey background!
#
# dune_pca_plt
#
# gg_identify(dune_pca_plt)


