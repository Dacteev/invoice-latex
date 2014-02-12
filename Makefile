
install:
	@echo "Not implemented."

demo: clean
	@mkdir -p build
	@cp src/* build/
	@cp -r demo/* build/
	@cd build/; pdflatex invoice_french.tex
	@cd build/; pdflatex invoice_english.tex
clean:
	@rm -rf build
