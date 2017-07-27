local({
  # fall back on '/' if baseurl is not specified
  baseurl = blogdown:::get_config2('baseurl', '/')
  knitr::opts_knit$set(base.url = baseurl)
  # fall back on 'kramdown' if markdown engine is not specified
  markdown = blogdown:::get_config2('markdown', 'kramdown')
  # see if we need to use the Jekyll renderer in knitr
  if (markdown == 'kramdown') knitr::render_jekyll() else knitr::render_markdown()

  # input/output filenames are passed as two additional arguments to Rscript
  a = commandArgs(TRUE)
  d = gsub('^_|[.][a-zA-Z]+$', '', a[1])
  knitr::opts_chunk$set(
    fig.path   = sprintf('figure/%s/', d),
    cache.path = sprintf('cache/%s/', d)
  )
  # set where you want to host the figures (I store them in my Dropbox folder
  # served via Updog.co, but you might prefer putting them in GIT)
  if (Sys.getenv('USER') == 'yihui') {
    # these settings are only for myself, and they will not apply to you, but
    # you may want to adapt them to your own website
    knitr::opts_chunk$set(fig.path = sprintf('%s/', gsub('^.+/', '', d)))
    knitr::opts_knit$set(
      base.dir = '~/Dropbox/Apps/updog/drop/jekyll/',
      base.url = 'https://db.yihui.name/jekyll/'
    )
  }
  options(digits = 4)
  knitr::opts_knit$set(width = 70)
  knitr::knit(a[1], a[2], quiet = TRUE, encoding = 'UTF-8', envir = .GlobalEnv)
})
