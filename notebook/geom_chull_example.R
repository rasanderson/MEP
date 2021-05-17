library(tidyverse)
library(vegan)

source("R/geom_chull.R")

data(dune)
data(dune.env)

dune.pca <- ordi_pca(dune)

dune_sco <- ordi_scores(dune.pca, display="sites")

dune_sco <- mutate(dune_sco, Use = dune.env$Use)

ggplot(dune_sco, aes(x=PC1, y=PC2, fill=Use)) +
  geom_point() +
  geom_chull(alpha=0.5) + # What do you think alpha does??
  theme_classic()  # Add this if you don't like the grey background!
