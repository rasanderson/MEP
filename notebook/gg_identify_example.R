library(tidyverse)
library(vegan)
source("R/gg_identify.R")

mtcars_plt <- ggplot(mtcars, aes(x=mpg, y=hp)) +
  geom_point()

mtcars_plt
gg_identify(mtcars_plt, rownames(mtcars))


