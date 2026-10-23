TECTONIC ?= tectonic
REPORTS := midterm

.PHONY: all $(REPORTS) watch-% clean

all: $(REPORTS)

$(REPORTS):
	cd $@ && $(TECTONIC) -X compile main.tex

watch-%:
	cd $* && $(TECTONIC) -X watch

clean:
	find . -type f \( -name '*.aux' -o -name '*.log' -o -name '*.bbl' -o -name '*.blg' \
		-o -name '*.out' -o -name '*.fls' -o -name '*.fdb_latexmk' -o -name '*.synctex.gz' \) -delete
