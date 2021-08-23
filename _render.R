quiet = "--quiet" %in% commandArgs(FALSE)
formats = commandArgs(TRUE)

# provide default formats if necessary
if (length(formats) == 0) formats = c('bookdown::pdf_book', 'bookdown::gitbook')
# render the book to all formats unless they are specified via command-line args
for (fmt in formats) {
  cmd = sprintf("bookdown::render_book('index.Rmd', '%s', quiet = %s)", fmt, quiet)
  res = bookdown:::Rscript(c('-e', shQuote(cmd)))
  if (res != 0) stop('Failed to compile the book to ', fmt)
}
unlink('rmarkdown-guide.log')


redirect = function(from, to) {
  to = paste0('https://cosname.github.io', to)
  writeLines(sprintf(
    '<html><head><meta http-equiv="refresh" content="0; URL=\'%s\'" /></head><body><script>window.location = "%s";</script></html>', to, to
  ), paste0('_book/', from))
}
# 重定向更名的网页，如：
# redirect('r-markdown-components.html', 'rmarkdown-process.html')
