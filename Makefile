all:
	make pdf &&\
	rm -f _book/*.html &&\
	Rscript --quiet _render.R

pdf:
	Rscript --quiet _render.R "bookdown::pdf_book" &&\
	open _book/rmarkdown-guide.pdf

gitbook:
	Rscript --quiet _render.R "bookdown::gitbook"
