#' Interactive identify
#'
#' Interactive identify ggvegan species
#' @param plotname Name of a plot created with ggvegan autoplot
#' @param ordiname Result of  ordination PCA, RDA, CA, CCA from rda or cca
#' @param display What to label. Currently only accepts "species"
#' @param size Font size of labels
#' @param ... Other parameters to function
#'
#' @details
#' This function is designed to be run interactively. First create a standard
#' ordination using rda() or cca(). Use autoplot to display the results.
#'
#' @return The original ordiname is modified with labels
#'
#' @author Roy Sanderson, School of Natural & Environmental Science, Newcastle
#' University roy.sanderson@newcastle.ac.uk
#'
#' @examples
#' if(interactive()){
#' data(dune)
#' dune_pca <- rda(dune)
#' dune_plt <- ordi_plot(dune_pca, layers="species", geom="point", legend.position="none", arrows=FALSE)
#' dune_plt
#'
#' ordi_identify(dune_plt, dune_pca, "species")
#' }
#' @import grid
#' @import mosaic
#' @import vegan
#' @export
ordi_identify <- function(plotname, ordiname, display, size=3, ...){
  print("Click on plot to label points; hit Esc key to exit")
    plot_data <- fortify(ordiname, display=display)
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
#' @details To be written
#'
#' @export
ordi_pca <- function(spp_data, ...){
  spp_data_pca <- rda(spp_data, ...)
  class(spp_data_pca) <- c("rda", "cca", "pca")
  spp_data_pca
}

#' Redundancy analysis
#'
#' Wrapper function with vegan for RDA
#' @param formula Dataframe of attributes (columns) by samples (rows) as response
#' and one or more explanatory variables from a second dataframe
#' @param ... Other options to function
#'
#' @details To be written
#'
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
#' @details To be written
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
#' @param formula Dataframe of attributes (columns) by samples (rows) as response
#' and one or more explanatory variables from a second dataframe
#' @param ... Other options to function
#'
#' @details To be written
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
#' @details To be written
#'
#' @export
ordi_scores <- function(ordi_object, ...){
  fortify(ordi_object, ...)
}


