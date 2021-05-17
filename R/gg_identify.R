gg_identify <- function(plotname, size=3, ...){
  print("Click on plot to label points; hit Esc key to exit")
  plot_data <- plotname$data
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
