#' Interactive identify
#'
#' Interactive identify ggvegan species
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
#' labelled with this function, so avoid using the back arrow keys in the RStudio
#' plot window. Labelling may not always occur on first click, and is more
#' difficult on constrained ordination plots.
#'
#' @return The original ordiname is modified with labels
#'
#' @author Roy Sanderson, School of Natural & Environmental Science, Newcastle
#' University roy.sanderson@newcastle.ac.uk
#'
#' @examples
#' if(interactive()){
#'
#' # Unconstrained ordination
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
#' @import grid
#' @import mosaic
#' @import vegan
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

#' Stepwise selection of constrained ordination
#'
#' Wrapper function with vegan for ordistep
#' @param ordi_object Either a cca or rda object
#' @param ... Other options to function
#'
#' @details To be written
#'
#' @export
ordi_step <- function(ordi_object, ...){
  ordistep(ordi_object, ...)
}

#' Multiple plot function
#'
#' Display plot objects in multiple columns, rows, or other combinations
#' @param ... ggplot (or gf_ plot) objects
#' @param plotlist alternative input as a list of ggplot objects
#' @param cols Number of columns in layout
#' @param layout A matrix specifying the layout. If present, 'cols' is ignored.
#'
#' @details
#' If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
#' then plot 1 will go in the upper left, 2 will go in the upper right, and
#' 3 will go all the way across the bottom.
#'
#' @return Displays multi-way plot, but returns NULL
#'
#' @examples
#' # Create a couple of normal distributions of different sample sizes
#' small_normal <- rnorm(25)
#' medium_normal   <- rnorm(100)
#' big_normal   <- rnorm(100000)
#'
#' # Plot their frequency histograms, but store rather than display
#' small_normal_plt <- gf_histogram(~ small_normal)
#' medium_normal_plt <- gf_histogram(~ medium_normal)
#' big_normal_plt   <- gf_histogram(~ big_normal)
#'
#' # Display two plots side-by-side
#' multi_plot(small_normal_plt, big_normal_plt, cols=2)
#'
#' # Display two plots one above the other
#' multi_plot(small_normal_plt, big_normal_plt, cols=1)
#'
#' # Display three plots in a grid
#' # Note use of layout 1, 2, 3, 3 coding to put
#' # the big_normal_plt (third named one) across the bottom
#' multi_plot(small_normal_plt, medium_normal_plt, big_normal_plt,
#'            layout=matrix(c(1,2,3,3), nrow=2, byrow=TRUE))
#'
#' @import grid
#' @import mosaic
#' @export
multi_plot <- function(..., plotlist=NULL, cols=1, layout=NULL) {

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }

  if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

#' Type 3 Sums of squares
#'
#' Wrapper function with car for Anova
#' @param lm_mod Results of lm function
#' @param ... Other options to function
#'
#' @details To be written
#'
#' @export
anova3 <- function(lm_mod, ...){
  Anova(lm_mod, ...)
}
