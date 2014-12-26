This is a minimal example of a Jekyll-based website using **knitr** and R
Markdown. The interesting bit of this repo is that you can actually serve the
Jekyll website locally with R, and R Markdown posts can be compiled
automatically, with the web pages automatically refreshed as well.

After you are satisfied with the local preview, you can either just push the
Markdown blog posts to your Github repo (e.g. the `gh-pages` branch), and let
Github generate the website for you, or host the HTML files generated under the
`_site/` directory on your own server.

The original website was created from `jekyll new .` under the root directory,
which was part of the [official Jekyll repo](https://github.com/jekyll/jekyll).
The additional code (R, Makefile) in this repo is under the MIT License, and the
[blog post](http://yihui.name/knitr-jekyll/2014/09/jekyll-with-knitr.html) I
wrote is under the [CC-BY 4.0](http://creativecommons.org/licenses/by/4.0/)
International License.
