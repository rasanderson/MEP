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
#' require(ggformula)
#' require(ggrepel)
#'
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
