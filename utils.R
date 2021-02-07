import_example_result <- function(file, redo = FALSE, vwidth = 600, vheight = 400, ...){
  file <- file.path("examples",file)
  webshot <- paste0(xfun::with_ext(file, "png"))
  if (xfun::file_exists(webshot)){
    webshot_time <- file.info(webshot)$mtime
    source_time <- file.info(file)$mtime
    if (source_time > webshot_time) redo <- TRUE
  }
  if (redo){
    suppressMessages( output <- rmarkdown::render(file) )
    webshot::webshot(url = output, file = webshot, vwidth = vwidth, vheight = vheight, ...)
  }
  knitr::include_graphics(webshot)
}
