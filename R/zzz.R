# Modify this file if you decide that you want to automatically install and/or
# load various packages automatically when the MEP library is loaded.
.onLoad <- function(libname, pkgname) {
  # packageStartupMessage("\n\nWelcome to the MEP R package")
  # # Check if dependencies installed and if not add them
  # # packages <- c("mosaic", "vegan", "car")
  # # if (length(setdiff(packages, rownames(utils::installed.packages()))) > 0) {
  # #   utils::install.packages(setdiff(packages, rownames(utils::installed.packages())), repos = "https://cloud.r-project.org")
  # # }
  # suppressPackageStartupMessages(
  #   c(library(mosaic, quietly = TRUE, warn.conflicts = FALSE),
  #     library(car, quietly = TRUE),
  #     library(vegan, quietly = TRUE))
  # )
}

