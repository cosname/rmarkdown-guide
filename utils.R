import_example_result <- function(file, redo = FALSE, vwidth = 700, vheight = 400, ...){
  file <- file.path("examples",file)
  webshot <- paste0(xfun::with_ext(file, "png"))
  if (xfun::file_exists(webshot)){
    fail <- tryCatch(png::readPNG(file), error = function(x) TRUE)
    outdate <- file.info(file)$mtime > file.info(webshot)$mtime
    if (fail | outdate) redo <- TRUE
  } else {
    redo <- TRUE
  }
  if (redo){
    cmd <- sprintf("rmarkdown::render('%s', quiet = TRUE)", file)
    ret <- xfun::Rscript(c("-e", shQuote(cmd)))
    if (ret == 0) url <- xfun::with_ext(file,"html")
    webshot::webshot(url = url, file = webshot, vwidth = vwidth, vheight = vheight, ...)
  }
  knitr::include_graphics(webshot)
}
