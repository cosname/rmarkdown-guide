import_example_result <- function(file, redo = FALSE, vwidth = 700, vheight = 400, ...){
  file <- xfun::magic_path(file)
  out <- rmarkdown::all_output_formats(file)[[1]]
  webshot <- paste0(xfun::with_ext(file, "png"))
  if (xfun::file_exists(webshot)){
    fail <- tryCatch(png::readPNG(file), error = function(x) TRUE)
    outdate <- file.info(file)$mtime > file.info(webshot)$mtime
    if (fail | outdate) redo <- TRUE
  } else {
    redo <- TRUE
  }
  if (redo){
    if (out %in% c("pdf_document","beamer_presentation")){
      cmd <- sprintf("rmarkdown::render('%s', quiet = TRUE)", file)
      ret <- xfun::Rscript(c("-e", shQuote(cmd)))
      if (ret == 0){
        pdf = xfun::with_ext(file, "pdf")
        content = magick::image_read_pdf(pdf)
        magick::image_write(content, webshot)
      } else {
        stop(simpleError("Knit to PDF failed for document: ", file))
      }
    }

    if (out %in% c("html_document","ioslides_presentation","slidy_presentation"))
      webshot::rmdshot(file, webshot, vwidth = vwidth, vheight = vheight, ...)

  }
  knitr::include_graphics(webshot)
}
