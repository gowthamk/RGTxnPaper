all:
	pdflatex -shell-escape popl18
	pdflatex -shell-escape popl18
	bibtex popl18
	bibtex popl18
	pdflatex -shell-escape popl18
	bibtex popl18
	pdflatex -shell-escape popl18

haste:
	pdflatex -shell-escape popl18
	open popl18.pdf

clean:
	rm *.log *.aux *.bbl
