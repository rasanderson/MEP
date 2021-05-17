# The MEP R package

# Introduction
It is likely that everyone in MEP has a selection of useful R functions for
plotting data, simulation modelling, statistical analyses, data wrangling etc.
The MEP R package provides a central resource for us to pool our R code. If
you are comfortable with coding in R then it should be easy to install the 
package, and contribute your own functions to it.

# Installation
You will need the `devtools` or `remotes` package installed:

```
library(devtools)
install_github("rasanderson/MEP")
```

# Available functions
Most of these functions were created for BIO2020 and NES8010 UG and MSc modules
on quantitative methods.

* `ordi_*()` analysis functions `ordi_pca()`, `ordi_rda()`, `ordi_ca()`,
`ordi_cca()`, `ordi_nmds()`. These are basically "wrapper" functions over the
`vegan` package's `rda`, `cca` and `metaNMDS` functions. Students sometimes
found the syntax of `rda` and `cca` confusing as they can do both unconstrained
and constrained ordinations with the same function.
* `ordi_scores()` This replaces the `vegan` function `scores`, and returns the
scores as a data.frame rather than list. The former is much easier to manipulate
or feed directly into conventional `ggplot2` functions.
* `ordi_plot()` This replaces the default `vegan` plotting routine and creates
a `ggplot2`-compatible graph. You can therefore modify the resulting object in
the usual way with themes, legends, colours etc.
* `ordi_identify()` and `gg_identify()` These provide interactive labelling of
ordination plots or conventional `ggplot2` plots, assuming the latter is a
scatterplot created with `geom_points()`. Neither of these has been easy to
implement, and they still contain bugs. They may not work on MacOS computers.
* `geom_chull()` Surprisingly `ggplot2` does not provide a method to add a
convex polygon (convex hull) to scatterplots. This takes an extra column of
data, typically provided by the `fill=` argument, to create the convex polygon.
It should be able to handle options such as `alpha=` etc. to change colours etc.
* `multi_plot()` This allows you to put 2 or more `ggplot2` graphs into one
plot. It is simple to use, but if you want much better functionality use the
more advanced <https://rpkgs.datanovia.com/ggpubr/> package.

# How to contribute to MEP R package (MEPR ?)
You will need to be familiar with basic commands in git. This will allow you
to 'clone' the MEP repository, create new features, and then add a "pull
request" which will notify me as the repository owner to merge in your new
whizzy functions etc. I'm still learning both git and R package development,
but the basic instructions are:

### Steve
email me your functions

### Everyone else
Start a new R project, but select the "from version control" option, pasting in
the link from my repository. There are a few extra tweaks needed afterwards.
Always create a new branch called `devel` and work from that.



