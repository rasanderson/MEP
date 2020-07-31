#' Interactive identify
#'
#' Interactive identify ggvegan species
#' @param plotname Name of a plot created with ggvegan autoplot
#' @param ordiname Result of ordination PCA, RDA, CA, CCA from rda or cca
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
#' @import ggvegan
#' @import ggrepel
#' @importFrom ggformula gf_refine
#' @import grid
ordi_identify <- function(plotname, ordiname, display){

  plot_data <- fortify(ordiname, display=display)
  #downViewport('panel-7-5-7-5')
  #pushViewport(dataViewport(x,y))
  x <- plot_data[,3]
  y <- plot_data[,4]
  pushViewport(dataViewport(x,y))

  tmp <- c(0,0)
  labelled_points <- NULL
  while(!is.null(tmp)){
    tmp <- grid.locator('in')
    tmp.n <- as.numeric(tmp)
    tmp2.x <- as.numeric(convertX( unit(x,'native'), 'in' ))
    tmp2.y <- as.numeric(convertY( unit(y,'native'), 'in' ))

    w <- which.min( (tmp2.x-tmp.n[1])^2 + (tmp2.y-tmp.n[2])^2 )
    #cat("w is", w, " and labelled_points is ", labelled_points, "\n")
    if(is.null(labelled_points)){
      print("initialising labelled points")
      labelled_points <- c(labelled_points, w)
    }else if(length(w)==1){
      if(w %in% labelled_points){
        print("Point already labelled")

      }else{
        #print("adding label to list of labelled points")
        labelled_points <- c(labelled_points, w)
      }}
    cat("labelled points: ", labelled_points, "\n")

    #grid.text(w, tmp$x, tmp$y )
    #xy <- mydata[w,]
    #xy <- mydata[labelled_points,]
    xy <- plot_data[labelled_points,]
    print(xy)
  }

  if(nrow(xy) >= 1){
    print("About to update plot")
    for(i in 1:length(labelled_points)){
      plotname <- plotname +
        gf_refine(geom_text_repel(aes(x=PC1, y=PC2, label=Label), data=xy[i,]))
    }
  }
  return(plotname)
}
