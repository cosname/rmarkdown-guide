import_example_result <- function(file, redo = FALSE, vwidth = 700, vheight = 400, ...){
  file <- xfun::magic_path(file)
  out <- names(yaml::read_yaml(file)$output)
  webshot <- paste0(xfun::with_ext(file, "png"))
  if (xfun::file_exists(webshot)){
    fail <- tryCatch(png::readPNG(file), error = function(x) TRUE)
    outdate <- file.info(file)$mtime > file.info(webshot)$mtime
    if (fail | outdate) redo <- TRUE
  } else {
    redo <- TRUE
  }
  if (redo){
    if (out %in% c("pdf_document","beamer_presentation"))
      pdf = xfun::with_ext(file, "pdf")
      content = magick::image_read_pdf(pdf)
      magick::image_write(content, webshot)

    if (out %in% c("html_document","ioslides_presentation","slidy_presentation"))
      webshot::rmdshot(file, webshot, vwidth = vwidth, vheight = vheight, ...)

  }
  knitr::include_graphics(webshot)
}
