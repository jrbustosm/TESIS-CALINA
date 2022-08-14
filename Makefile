compile:
	pdflatex tesis.tex
	bibtex tesis
	makeindex tesis.tex
	pdflatex tesis.tex

#presentacion:
#	latex presentacion.tex
#	dvipdf presentacion.dvi

#poster:
#	latex poster_portrait.tex
#	dvipdf poster_portrait.dvi 

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.ilg *.ind *.lof *.lot *.out *.ps *.toc
