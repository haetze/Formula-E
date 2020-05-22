### Makefile --- 

## Author: richard.stewing@udo.edu


all: race-points-agg.dat race-points.dat team-points.svg



race-points-agg.dat race-points.dat: team.dat
	Rscript script.r

team-points.svg: race-points-agg.dat race-points.dat
	./race-points.gp
