all:
	pdflatex -shell-escape popl17
	pdflatex -shell-escape popl17
	bibtex popl17
	bibtex popl17
	pdflatex -shell-escape popl17
	bibtex popl17
	pdflatex -shell-escape popl17

haste:
	pdflatex -shell-escape popl17

clean:
	rm *.log *.aux *.bbl
