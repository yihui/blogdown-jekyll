---
layout: post
title:  "Build Jekyll Websites with knitr and blogdown"
categories: [jekyll, rstats]
tags: [blogdown, knitr, servr, httpuv, websocket]
---

The R package [**blogdown**](https://github.com/rstudio/blogdown) was designed mainly for the static site generator [Hugo](https://gohugo.io), but it can also be used to build websites based on Jekyll and R Markdown. The main features are:

1. R Markdown source files are re-compiled through [**knitr**](https://yihui.name/knitr/) when their corresponding Markdown output files become older[^1] than source files;
1. The web page will refresh itself automatically in the above case as well;

[^1]: Determined by the modification time of files, i.e., `file.info(x)[, 'mtime']`.

As a result, all you need to do is write your blog posts (R Markdown documents). You do not need to explicitly re-build the website or call **knitr** commands. Whenever you save a blog post in your text editor, the web page will be updated on the fly. This is particularly handy in the [RStudio IDE](https://www.rstudio.com), because after you run `blogdown::serve_site()` in the console, you can start writing or editing your R Markdown posts, and the HTML output, displayed in the RStudio viewer pane, will be in sync with your source post in the source panel (see the screenshot below).

[![Jekyll with servr and knitr](//i.imgur.com/gKVGhiP.png)](//i.imgur.com/gKVGhiP.png)

## Prerequisites

You must have installed the packages **blogdown** (>= 0.0.55).


{% highlight r %}
devtools::install_github("rstudio/blogdown")
{% endhighlight %}

Of course, you have to install [Jekyll](http://jekyllrb.com) as well. For Windows users, you have to make sure `jekyll` can be found from your environment variable `PATH`, i.e., R can call it via `system('jekyll')`. This is normally not an issue for Linux or macOS users (`gem install jekyll` is enough).

## R code chunks

Now we write some R code chunks in this post. For example,


{% highlight r %}
options(digits = 3)
cat("hello world!")
{% endhighlight %}



{% highlight text %}
## hello world!
{% endhighlight %}



{% highlight r %}
set.seed(123)
(x = rnorm(40) + 10)
{% endhighlight %}



{% highlight text %}
##  [1]  9.44  9.77 11.56 10.07 10.13 11.72 10.46  8.73  9.31  9.55 11.22
## [12] 10.36 10.40 10.11  9.44 11.79 10.50  8.03 10.70  9.53  8.93  9.78
## [23]  8.97  9.27  9.37  8.31 10.84 10.15  8.86 11.25 10.43  9.70 10.90
## [34] 10.88 10.82 10.69 10.55  9.94  9.69  9.62
{% endhighlight %}



{% highlight r %}
# generate a table
knitr::kable(head(mtcars))
{% endhighlight %}



|                  |  mpg| cyl| disp|  hp| drat|   wt| qsec| vs| am| gear| carb|
|:-----------------|----:|---:|----:|---:|----:|----:|----:|--:|--:|----:|----:|
|Mazda RX4         | 21.0|   6|  160| 110| 3.90| 2.62| 16.5|  0|  1|    4|    4|
|Mazda RX4 Wag     | 21.0|   6|  160| 110| 3.90| 2.88| 17.0|  0|  1|    4|    4|
|Datsun 710        | 22.8|   4|  108|  93| 3.85| 2.32| 18.6|  1|  1|    4|    1|
|Hornet 4 Drive    | 21.4|   6|  258| 110| 3.08| 3.21| 19.4|  1|  0|    3|    1|
|Hornet Sportabout | 18.7|   8|  360| 175| 3.15| 3.44| 17.0|  0|  0|    3|    2|
|Valiant           | 18.1|   6|  225| 105| 2.76| 3.46| 20.2|  1|  0|    3|    1|



{% highlight r %}
(function() {
    if (TRUE) 
        1 + 1  # a boring comment
})()
{% endhighlight %}



{% highlight text %}
## [1] 2
{% endhighlight %}



{% highlight r %}
names(formals(servr::jekyll))  # arguments of the jekyll() function
{% endhighlight %}



{% highlight text %}
## [1] "dir"     "input"   "output"  "script"  "serve"   "command"
## [7] "..."
{% endhighlight %}

Just to test inline R expressions[^2] in **knitr**, we know the first element in `x` (created in the code chunk above) is 9.44. You can certainly draw some graphs as well:

[^2]: The syntax in R Markdown for inline expressions is `` `r code` ``, where `code` is the R expression that you want to evaluate, e.g. `x[1]`.


{% highlight r %}
par(mar = c(4, 4, 0.1, 0.1))
plot(cars, pch = 19, col = "red")  # a scatterplot
{% endhighlight %}

![A scatterplot of the cars data](https://db.yihui.name/jekyll/2014-09-28-jekyll-with-knitr/cars-1.png)

## The build script

You can define all your **knitr** options and any other options in an R script. See the script [`R/build.R`](https://github.com/yihui/knitr-jekyll/blob/gh-pages/R/build.R) in the knitr-jekyll repository for an example: it calls the script [`R/build_one.R`](https://github.com/yihui/knitr-jekyll/blob/gh-pages/R/build_one.R) that will automatically set up the output renderers for **knitr**, e.g., when the Jekyll Markdown engine is `kramdown`, this script will call `knitr::render_jekyll()` so that the code chunk output will be put inside the Liquid tag `{% raw %}{% highlight lang %} {% endhighlight %}{% endraw %}`; it also sets up some **knitr** chunk and package options so that figures can be displayed correctly. For those who do not wish to store images in GIT (because normally they are binary files), you may check out how I host my images in Dropbox for this repository (see the code below `Sys.getenv('USER') == 'yihui'`).

## On the Markdown renderers

Jekyll supports a number of Markdown renderers, such as kramdown, redcarpet, rdiscount, and so on. At the moment, it is a little annoying that kramdown supports LaTeX math expressions via `$$ math $$`[^4], but does not support syntax highlighting of code blocks using the three backticks syntax (you must write the awkward Liquid tags); on the other hand, redcarpet does not support LaTeX math but does support three backticks. In my opinion, all the different flavors and implementations of Markdown is the biggest problem of Markdown, since there is not an unambiguous spec for Markdown. [CommonMark](http://commonmark.org) looks like a promising project to set up a common spec for Markdown, and [Pandoc](http://pandoc.org) is a great implementation that has brought almost all the features that you may ever need in Markdown. You may find some Pandoc plugins for Jekyll by searching online. However, GitHub Pages does not support arbitrary Jekyll plugins, so you cannot just use a Pandoc plugin there, but that does not mean you cannot use Pandoc locally, nor does it mean you cannot push locally compiled HTML pages to GitHub Pages[^5].

[^4]: Unfortunately, kramdown does not support math expressions in single dollars, e.g. `$ \alpha $`.

[^5]: If you choose to generate your Jekyll website locally, and push the HTML files to GitHub, you will need the file [`.nojekyll`](https://help.github.com/articles/using-jekyll-with-pages) in the root directory of your website.

I'd love you to [fork](https://github.com/yihui/knitr-jekyll) this repository, make some (hopefully minor) changes, and [let me know](https://github.com/yihui/knitr-jekyll/issues) your success of using Pandoc with Jekyll. Happy hacking, and good luck!
