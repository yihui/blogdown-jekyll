This is a minimal example of a Jekyll-based website using [**knitr**](https://yihui.name/knitr/), [**blogdown**](https://github.com/rstudio/blogdown), and R Markdown, briefly documented at <https://bookdown.org/yihui/blogdown/jekyll.html>.

You can actually serve the Jekyll website locally with R, and R Markdown posts can be compiled automatically, with the web pages being automatically refreshed in your web browser as well. To build the serve the website locally, you need to install **blogdown** (and Jekyll, of course) and call the `serve_site()` function:

```r
devtools::install_github("rstudio/blogdown")
blogdown::serve_site()
```

After you are satisfied with the local preview, you can either just push the Markdown blog posts to your Github repo (e.g. the `gh-pages` branch), and let Github generate the website for you, or host the HTML files generated under the `_site/` directory on your own server.

The original website was created from `jekyll new .` under the root directory, which was part of the [official Jekyll repo](https://github.com/jekyll/jekyll). The additional code (mainly R code) in this repo is under the MIT License, and the [blog post](https://jekyll.yihui.name/2014/09/jekyll-with-knitr.html) I wrote is under the [CC-BY 4.0](http://creativecommons.org/licenses/by/4.0/) International License.

The support for Jekyll is limitted in **blogdown**, and you may want to switch to Hugo, which is much better supported in **blogdown**.
