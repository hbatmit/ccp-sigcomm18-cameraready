##

TARGETS = ccp-sigcomm18

TEXFILES = $(wildcard *.tex)
PDFS = $(addsuffix .pdf,$(TARGETS))

all: $(PDFS)

%.pdf: %.tex $(TEXFILES)
	pdflatex -shell-escape -shell-escape $*.tex
	bibtex $*
	pdflatex -shell-escape -shell-escape $*.tex
	pdflatex -shell-escape -shell-escape $*.tex

clean:
	/bin/rm -f $(PDFS) *.dvi *.aux *.ps *~ *.log *.out *.lot *.lof *.toc *.blg *.bbl url.sty

evince:
	pdflatex -shell-escape $(TARGETS).tex
	evince $(PDFS) &

acro:
	pdflatex -shell-escape $(TARGETS).tex
	acroread $(PDFS) &

osx:
	pdflatex -shell-escape $(TARGETS).tex
	open $(PDFS)

windows:
	pdflatex -shell-escape $(TARGETS).tex
	explorer.exe $(PDFS) &

home: osx

check:
	pdflatex -shell-escape $(TARGETS).tex | grep -i -e "undefined" -e "multiply"

