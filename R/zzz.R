.onLoad <- function(libname, pkgname) {
  packageStartupMessage("\n\nWelcome to the BIO2020 package to support teaching")
  # Check if dependencies installed and if not add them
  packages <- c("mosaic", "vegan")
  if (length(setdiff(packages, rownames(utils::installed.packages()))) > 0) {
    utils::install.packages(setdiff(packages, rownames(utils::installed.packages())), repos = "https://cloud.r-project.org")
  }
  library(mosaic)
  library(vegan)
  # requireNamespace("mosaic")
  # requireNamespace("vegan")
}
