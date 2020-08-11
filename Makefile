### Makefile --- 

## Author: richard.stewing@udo.edu

# First Race Season 2019/2020
RACE-IDS := 97 98 100 101 102 116 117 118 119
DATA-FILES := $(patsubst %,data/%.dat, $(RACE-IDS))


doc:
	@echo "Available Targets:"
	@echo "  data/RACE-ID.dat:"
	@echo "    Description: Retrieves data from https://www.e-formel.de and creates/appends tables in data/."
	@echo "    Available RACE-IDs: $(RACE-IDS)"
	@echo "    Examples:"
	@echo "      ''make data/97.dat''"
	@echo "      ''make data/117.dat''"
	@echo "  all:"
	@echo "    Description: Downloads all data files. Don't use with -j flag."
	@echo "    Examples:"
	@echo "      ''make all''"
	@echo "  clean:"
	@echo "    Description: Removes data/ directory"
	@echo "    Examples:"
	@echo "      ''make clean''"


all: $(DATA-FILES)

clean:
	rm -rf data

data:
	@mkdir -p data

data/%.dat: src/data-retrieva-script.r data
	@echo "+==============================================================================+"
	@echo "  Requesting Race data with ID $(basename $(@F))"
	@echo "+==============================================================================+"
	./src/data-retrieva-script.r $(basename $(@F))

