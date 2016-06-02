all:
	pdflatex -shell-escape popl16
	pdflatex -shell-escape popl16
	bibtex popl16
	bibtex popl16
	pdflatex -shell-escape popl16
	bibtex popl16
	pdflatex -shell-escape popl16

haste:
	pdflatex -shell-escape popl16

clean:
	rm *.log *.aux *.bbl
