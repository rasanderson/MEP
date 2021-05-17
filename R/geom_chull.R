#' Convex hulls on ggplot2
#'
#' Adds convex hulls (chulls) to a ggplot2 scatterplot
#' @param mapping ggplot2 aesthetics mapping
#' @param data data.frame or tibble of data for use in chull
#' @param geom defaults to creating a polygon
#' @param position defaults to identity (no change to original)
#' @param na.rm defaults to FALSE
#' @param show.legend defaults to NA
#' @param inherit.aes defaults to TRUE (e.g. from aes in main ggplot call)
#' @param ... Other standard ggplot2 plotting options
#'
#' @details
#' Overlays convex polygons, often called convex hulls, onto a scatterplot of
#' points. Typically this will be a geom_point() graph, of x and y, where you
#' want to colour separate polygons based on outermost points for two or more
#' groups. The grouping variable is generally defined by the use of the `fill`
#' argument in a call to the `aes` function, typically in the first line of a
#' ggplot call. This function should (theoretically!) work with any ggplot
#' scatterplot on x and y axes, but its use is particularly common in
#' multivariate ordination methods.
#'
#' @return Adds convex hull to ggplot object
#'
#' @examples
#' # Classic dune vegetation example
#' require(dplyr)
#'
#' data(dune)
#' data(dune.env)
#'
#' dune.pca <- ordi_pca(dune)
#'
#' dune_sco <- ordi_scores(dune.pca, display="sites")
#'
#' dune_sco <- mutate(dune_sco, Use = dune.env$Use)
#'
#' ggplot(dune_sco, aes(x=PC1, y=PC2, fill=Use)) +
#'   geom_point() +
#'   geom_chull(alpha = 0.5) +
#'   theme_classic()
#'
#' @export
geom_chull <- function(mapping = NULL, data = NULL, geom = "polygon",
                       position = "identity", na.rm = FALSE, show.legend = NA,
                       inherit.aes = TRUE, ...) {
  layer(
    stat = StatChull, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
# Function for convex hull
StatChull <- ggproto("StatChull", Stat,
                     compute_group = function(data, scales) {
                       data[chull(data$x, data$y), , drop = FALSE]
                     },

                     required_aes = c("x", "y")
)
