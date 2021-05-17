#' Interactive labelling of ggplot2 plot
#'
#' Interactively add labels to generic ggplot2 scatterplot
#' @param plotname Name of a plot created with \code{\link{ggplot}}
#' @param labels Vector of character names to add to plot
#' @param size Font size of labels (default = 3)
#' @param ... Other optional parameters
#'
#' @details
#' This function is designed to be run interactively. First create a standard
#' ggplot2 plot \code{\link{ggplot}} with a \code{\link{geom_point}} geometry to create
#' a scatterplot. Ensure that the plot results are#' stored in an R object. Then apply
#' this function to that object, and hit the \emph{Esc} key to exit function.
#' \strong{Note:} In RStudio only the most recently displayed plot can be
#' labelled with this function, so avoid using the back arrow keys in the
#' RStudio plot window. Labelling usually requires a double-click, and is not
#' 100% reliable yet.
#'
#' @return The original plotname is modified with labels
#'
#' @author Roy Sanderson, School of Natural & Environmental Science, Newcastle
#' University roy.sanderson@newcastle.ac.uk
#'
#' @examples
#' \dontrun{
#' if(interactive()){
#'
#' mtcars_plt <- ggplot(mtcars, aes(x=mpg, y=hp)) +
#'   geom_point()
#'
#' mtcars_plt # Displays the plot
#' gg_identify(mtcars_plt, rownames(mtcars)) # Add the labels
#' }
#' }
#' @import grid
#' @import ggplot2
#' @export
#'
gg_identify <- function(plotname, labels, size=3, ...){
  if(is.null(labels)){
    # Triggers error if labels argument not given
  }
  print("Double-click on plot to label points; hit Esc key to exit")
  plot_data <- plotname$data
  depth <- downViewport('panel.7-5-7-5')
  xvar <- as.character(rlang::quo_get_expr(plotname$mapping$x))
  yvar <- as.character(rlang::quo_get_expr(plotname$mapping$y))
  x <- plotname$data[,xvar]
  y <- plotname$data[,yvar]
  labels <- labels
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
