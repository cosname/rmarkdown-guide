import_example_result <- function(file, redo = FALSE, vwidth = 700, vheight = 400, ...){
  file <- xfun::magic_path(file)
  webshot <- paste0(xfun::with_ext(file, "png"))
  if (xfun::file_exists(webshot)){
    fail <- tryCatch(png::readPNG(file), error = function(x) TRUE)
    outdate <- file.info(file)$mtime > file.info(webshot)$mtime
    if (fail | outdate) redo <- TRUE
  } else {
    redo <- TRUE
  }
  if (redo){
    webshot::rmdshot(file, webshot, vwidth = vwidth, vheight = vheight, ...)
  }
  knitr::include_graphics(webshot)
}
