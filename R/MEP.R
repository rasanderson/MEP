#' Interactive identify an ordination plot
#'
#' Interactive identify a species (attributes) and sites (samples) plot
#' @param plotname Name of a plot created with \code{\link{ordi_plot}}
#' @param size Font size of labels (default = 3)
#' @param ... Other optional parameters
#'
#' @details
#' This function is designed to be run interactively. First create a standard
#' ordination using \code{\link{ordi_pca}}, \code{\link{ordi_rda}},
#' \code{\link{ordi_ca}}, \code{\link{ordi_cca}} or \code{\link{ordi_nmds}}.
#' Then call \code{\link{ordi_plot}} but make sure that the plot results is
#' stored in an R object. Then apply this function to that object, and hit the
#' \emph{Esc} key to exit function.
#' \strong{Note:} In RStudio only the most recently displayed plot can be
#' labelled with this function, so avoid using the back arrow keys in the
#' RStudio plot window. Labelling may not always occur on first click, and is
#' more difficult on constrained ordination plots.
#'
#' @return The original ordiname is modified with labels
#'
#' @author Roy Sanderson, School of Natural & Environmental Science, Newcastle
#' University roy.sanderson@newcastle.ac.uk
#'
#' @examples
#' \dontrun{
#' if(interactive()){
#'
#' # Unconstrained ordination
#' require(ggrepel)
#' require(ggformula)
#' require(vegan)
#'
#' data(dune)
#' data(dune.env)
#' dune_pca <- ordi_pca(dune)
#' dune_plt <- ordi_plot(dune_pca, layers="species", geom="point") # defaults to sites and species
#' dune_plt  # Display the plot
#' ordi_identify(dune_plt) # Hit Esc key to exit
#'
#' # Constrained ordination
#' dune_rda <- ordi_rda(dune ~ A1 + Management, data=dune.env)
#' # displays spp and constraints.
#' # Constraints are "biplot" for continuous and "centroids" for categorical
#' dune_plt <- ordi_plot(dune_rda, layers=c("species", "biplot", "centroids"), geom="point")
#' dune_plt  # Display the plot
#' ordi_identify(dune_plt) # Hit Esc key to exit
#'
#' }
#' }
#' @import grid
#' @import vegan
#' @import ggplot2
#' @export
ordi_identify <- function(plotname, size=3, ...){
    print("Click on plot to label points; hit Esc key to exit")
    plot_data <- plotname[["layers"]][[1]]$data
    depth <- downViewport('panel.7-5-7-5')
    x <- plot_data[,3]
    y <- plot_data[,4]
    labels <- plot_data[,2]
    pushViewport(dataViewport(x,y))
    pick <- grid.locator('in')
    while(!is.null(pick)){
      tmp <- grid.locator('in')
      tmp.n <- as.numeric(tmp)
      tmp2.x <- as.numeric(convertX( unit(x,'native'), 'in' ))
      tmp2.y <- as.numeric(convertY( unit(y,'native'), 'in' ))

      w <- which.min( (tmp2.x-tmp.n[1])^2 + (tmp2.y-tmp.n[2])^2 )
      popViewport(n=1)
      upViewport(depth)
      print(last_plot() + annotate("text", label=labels[w], x = x[w], y = y[w],
                                   size = size, hjust=0.5, vjust=-0.5))
      depth <- downViewport('panel.7-5-7-5')
      pushViewport(dataViewport(x,y))
      pick <- grid.locator('in')
    }
    return(last_plot())
}

#' Principal components analysis
#'
#' Wrapper function with vegan for PCA
#' @param spp_data Dataframe of attributes (columns) by samples (rows)
#' @param ... Other options to function
#'
#' @details This is linear unconstrained ordination. It actually calls the
#' \code{\link{rda}} function from `vegan`, so is a wrapper function. It simply
#' provides a more consistent naming convention.
#'
#' @return A vegan rda object
#' @examples
#' # Unconstrained ordination with PCA
#' require(vegan)
#'
#' data(dune)
#' data(dune.env)
#' dune_pca <- ordi_pca(dune)
#'
#' @author Roy Sanderson, School of Natural & Environmental Science, Newcastle
#' University roy.sanderson@newcastle.ac.uk
#'
#' @import vegan
#' @importFrom stats setNames
#' @export
ordi_pca <- function(spp_data, ...){
  spp_data_pca <- rda(spp_data, ...)
  class(spp_data_pca) <- c("rda", "cca", "pca")
  spp_data_pca
}

#' Redundancy analysis
#'
#' Wrapper function with vegan for RDA
#' @param ... Other options to function
#'
#' @details This acts as a wrapper to the standard \code{\link{rda}} function
#' from the `vegan` package, which you should study for detailed documentation.
#' This version is for constrained linear ordination via redundancy analysis.
#'
#' @author Roy Sanderson, School of Natural & Environmental Science, Newcastle
#' University roy.sanderson@newcastle.ac.uk
#'
#' @import vegan
#' @export
ordi_rda <- {
  rda
}

#' Correspondence analysis
#'
#' Wrapper function with vegan for CA
#' @param spp_data Dataframe of attributes (columns) by samples (rows)
#' @param ... Other options to function
#'
#' @details This acts as a wrapper to the standard \code{\link{cca}} function
#' from the `vegan` package, which you should study for detailed documentation.
#' This version is designed for unconstrained unimodal correspondence analysis.
#'
#' @export
ordi_ca <- function(spp_data, ...){
  spp_data_ca <- cca(spp_data, ...)
  class(spp_data_ca) <- c("rda", "cca", "ca")
  spp_data_ca
}

#' Canonical correspondence analysis
#'
#' Wrapper function with vegan for CCA
#' @param ... Other options to function
#'
#' @details This acts as a wrapper to the standard \code{\link{cca}} function
#' from the `vegan` package, which you should study for detailed documentation.
#' This version is for constrained unimodal ordination via canonical
#' correspondence analysis.
#'
#' @export
ordi_cca <- {
  cca
}

#' Non-metric multidimensional analysis
#'
#' Wrapper function with vegan for metaMDS
#' @param spp_data Dataframe of attributes (columns) by samples (rows)
#' @param ... Other options to function
#'
#' @details To be written
#'
#' @export
ordi_nmds <- function(spp_data, ...){
  spp_data_ca <- metaMDS(spp_data, ...)
}

#' Ordination scores from constrained or unconstrained ordination
#'
#' Wrapper function with ggvegan for fortify
#' @param ordi_object Result of ordination
#' @param ... Other options to function
#'
#' @details This is a wrapper function for \code{\link{cca}} in the `vegan`
#' package. It differs in that the returned object is a data.frame rather
#' than a list. This makes it much simpler to use in `ggplot2`, linear models
#' and subsequent analyses. By default sites (samples), species (attributes)
#' and (where applicable) constraining variable scores are returned for both
#' axes 1 and axes 2 of the ordination.
#'
#' @export
ordi_scores <- function(ordi_object, ...){
  fortify(ordi_object, ...)
}

#' Stepwise selection of constrained ordination
#'
#' Wrapper function with vegan for ordistep
#' @param ordi_object Either a cca or rda object
#' @param ... Other options to function
#'
#' @details Wrapper function for the \code{\link{ordistep}} function in `vegan`
#' and its usage is identical
#'
#' @export
ordi_step <- function(ordi_object, ...){
  ordistep(ordi_object, ...)
}

