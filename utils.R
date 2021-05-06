import_example_result <- function(file, redo = TRUE, vwidth = 700, vheight = 400, ...){
  file <- xfun::magic_path(file)
  out <- rmarkdown::all_output_formats(file)
  if (is.null(out)) out = "html_document"
  if (length(out) == 1){
    webshot <- xfun::with_ext(file, "png")
  }
  if (length(out) > 1){
    webshot = xfun::with_ext(file, paste0(out,".png"))
  }

  if (all(xfun::file_exists(webshot))){ # if all output is exist
    fail <- tryCatch(png::readPNG(file), error = function(x) TRUE)
    outdate <- file.info(file)$mtime > file.info(webshot)$mtime
    if (fail | outdate) redo <- TRUE
  } else {
    redo <- TRUE
  }
  if (redo){
    for (i in 1:length(out)){
      fmt = out[[i]]
      outfile = webshot[[i]]

      if (fmt %in% c("pdf_document","beamer_presentation"))
        tryCatch(rmd_pdf_screenshot(file, fmt, outfile),
                 error = function(e)paste0("Failed to process ", file))

      if (fmt %in% c("html_document","ioslides_presentation","slidy_presentation"))
        tryCatch(rmd_html_screenshot(file, fmt, outfile, vwidth=vwidth, vheight=vheight),
                 error = function(e)paste0("Failed to process ", file))

    }
  }
  tryCatch(knitr::include_graphics(webshot), error = function(e) paste0("unable to load png: ", webshot))
}

rmd_html_screenshot <- function(file, fmt = "html_document", outfile = xfun::with_ext(file, "png"), ...){
  cmd <- sprintf("rmarkdown::render('%s', '%s', quiet = TRUE)", file, fmt)
  ret <- xfun::Rscript(c("-e", shQuote(cmd)))
  if (ret != 0) stop(simpleError("Knit to HTML failed for document: ", file))
  url = xfun::with_ext(file, "html")
  html_screenshot(url, outfile, ...)
}

html_screenshot <- function(url, outfile = xfun::with_ext(url,"png"), ...){
  webshot::webshot(url, outfile, ...)
  return(outfile)
}

rmd_pdf_screenshot <- function(file, fmt = "pdf_document", outfile = xfun::with_ext(file, "png")){
  cmd <- sprintf("rmarkdown::render('%s', '%s', quiet = TRUE)", file, fmt)
  ret <- xfun::Rscript(c("-e", shQuote(cmd)))
  if (ret != 0) stop(simpleError("Knit to PDF failed for document: ", file))

  pdf = xfun::with_ext(file, "pdf")
  pdf_screenshot(pdf, outfile)

}

pdf_screenshot <- function(pdf, outfile = xfun::with_ext(pdf, "png")){
  content = magick::image_read_pdf(pdf, pages = 1)
  magick::image_write(content, outfile)
  return(outfile)
}
