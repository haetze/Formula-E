### Makefile --- 

## Author: richard.stewing@udo.edu


all: race-points-agg.dat race-points.dat abt.dat di-Grassi.dat team-points.svg
all: abt-positiondelta.svg di-Grassi-positiondelta.svg


race-points-agg.dat race-points.dat abt.dat di-Grassi.dat: team.dat
	Rscript script.r

team-points.svg: race-points-agg.dat race-points.dat race-points.gp
	./race-points.gp


abt-positiondelta.svg: abt.dat abt.gp
	./abt.gp

di-Grassi-positiondelta.svg: di-Grassi.dat di-Grassi.gp
	./di-Grassi.gp


clean:
	rm *.dat
	rm *.svg


publish:
	git commit -m "$(MSG)" -a
	git push
