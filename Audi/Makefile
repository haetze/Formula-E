### Makefile --- 

## Author: richard.stewing@udo.edu

########################################################################
# Variables                                                            #
########################################################################
SEASON := 19
BASE-URL := https://www.e-formel.de/resultate.html?ses=
URL := $(BASE-URL)$(SEASON)
########################################################################

default:
	@echo "This Makefile creates a few simple graphics about the Formula E."
	@echo "At the moment it focuses on Lucas di Grassi of Audi Sport ABT Schaeffler."
	@echo "Since Daniel Abt left during Season 19/20 his data is incomplete, he was replaced by Rene Rast."
	@echo "The ''all'' target builds all graphics. Paths relativ to img/."
	@echo "  team-points.svg: Shows how much points were collected over the season 19/20."
	@echo "  di-Grassi-positiondelta.svg: Shows the change in position from start to finish during a race."
	@echo "  di-grassi-$(SEASON).svg: Shows when di Grassi collected points in Season $(SEASON)."
	@echo "  The same files exist for Rast and Abt but their are incomplete."
	@echo "Data is scrapped from $(BASE-URL) and uses their season encoding."


all: data/race-points-agg.dat
all: data/race-points.dat
all: data/abt.dat
all: data/rast.dat
all: data/di-Grassi.dat
all: img/team-points.svg
all: img/abt-positiondelta.svg
all: img/rast-positiondelta.svg
all: img/di-Grassi-positiondelta.svg
all: img/di-grassi-$(SEASON).svg


data/race-points-agg.dat data/race-points.dat data/abt.dat di-Grassi.dat rast.dat: data/team.dat src/script.r
	Rscript src/script.r

img:
	mkdir -p img

img/team-points.svg: data/race-points-agg.dat data/race-points.dat src/race-points.gp img
	./src/race-points.gp


img/abt-positiondelta.svg: data/abt.dat src/abt.gp img
	./src/abt.gp

img/rast-positiondelta.svg: data/rast.dat src/rast.gp img
	./src/rast.gp


img/di-Grassi-positiondelta.svg: data/di-Grassi.dat src/di-Grassi.gp img
	./src/di-Grassi.gp


data/di-grassi-$(SEASON).dat: src/extract-di-grassi.sed src/extract-data.sed
	@echo "Pulling data from $(URL)."
	@echo "This is based on the value of the SEASON variable, currently $(SEASON)."
	curl $(URL) | sed -f src/extract-di-grassi.sed | sed -f src/extract-data.sed > data/di-grassi-$(SEASON).dat

img/di-grassi-$(SEASON).svg: data/di-grassi-$(SEASON).dat src/di-grassi-scrape.gp
	./src/di-grassi-scrape.gp img/di-grassi-$(SEASON).svg data/di-grassi-$(SEASON).dat



clean:
	rm -f data/race-points-agg.dat data/race-points.dat data/abt.dat data/di-Grassi.dat
	rm -f data/di-grassi-*.dat
	rm -f img/*.svg

publish:
	git commit -m "$(MSG)" -a
	git push
