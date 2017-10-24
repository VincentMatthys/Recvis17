all: A1_MATTHYS_Vincent

A1_MATTHYS_Vincent: main.tex
	latexmk -pdf $< -jobname=$@
	# xdg-open $@.pdf &
	latexmk -c -f $(wildcard $@*)
