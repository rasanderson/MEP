.onLoad <- function(libname, pkgname) {
  packageStartupMessage("\n\nWelcome to the BIO2020 package to support teaching")
  # Check if dependencies installed and if not add them
  packages <- c("mosaic", "vegan", "car")
  if (length(setdiff(packages, rownames(utils::installed.packages()))) > 0) {
    utils::install.packages(setdiff(packages, rownames(utils::installed.packages())), repos = "https://cloud.r-project.org")
  }
  suppressPackageStartupMessages(
    c(library(mosaic, quietly = TRUE, warn.conflicts = FALSE),
      library(car, quietyly = TRUE),
      library(vegan, quietly = TRUE))
  )
}

