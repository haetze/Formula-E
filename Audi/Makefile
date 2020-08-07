### Makefile --- 

## Author: richard.stewing@udo.edu


all: data/race-points-agg.dat data/race-points.dat data/abt.dat data/di-Grassi.dat img/team-points.svg
all: img/abt-positiondelta.svg img/di-Grassi-positiondelta.svg


data/race-points-agg.dat data/race-points.dat data/abt.dat di-Grassi.dat: data/team.dat
	Rscript src/script.r
img:
	mkdir -p img

img/team-points.svg: data/race-points-agg.dat data/race-points.dat src/race-points.gp img
	./src/race-points.gp


img/abt-positiondelta.svg: data/abt.dat src/abt.gp img
	./src/abt.gp

img/di-Grassi-positiondelta.svg: data/di-Grassi.dat src/di-Grassi.gp img
	./src/di-Grassi.gp


clean:
	rm data/race-points-agg.dat data/race-points.dat data/abt.dat data/di-Grassi.dat
	rm img/*.svg


publish:
	git commit -m "$(MSG)" -a
	git push
