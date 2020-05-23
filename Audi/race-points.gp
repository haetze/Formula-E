#!/usr/local/Cellar/gnuplot/5.2.8/bin/gnuplot -persist
set xlabel "Location"
set ylabel "Points"
set grid xtics,ytics
set terminal svg
set output "team-points.svg"
plot [][-1:] "race-points.dat" u ($0):2:xtic(1) t "Points at Location" w lp,"race-points-agg.dat" u ($0):2:xtic(1) t "Points aggregated" w lp
set terminal qt
set output
# EOF
