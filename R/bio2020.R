#' Interactive identify
#'
#' Interactive identify ggvegan species
#' @param plotname Name of a plot created with ggvegan autoplot
#' @param ordiname Result of  ordination PCA, RDA, CA, CCA from rda or cca
#' @param display What to label. Currently only accepts "species"
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
#' data(dune)
#' dune_pca <- rda(dune)
#' dune_plt <- autoplot(dune_pca, layers="species", geom="point", legend.position="none", arrows=FALSE)
#' dune_plt
#'
#' ordi_identify(dune_plt, dune_pca, "species")
#' @importFrom vegan rda
#' @import ggplot2
#' @import ggrepel
#' @importFrom ggformula gf_refine
#' @import grid
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
