#!/usr/local/Cellar/gnuplot/5.2.8/bin/gnuplot -persist
set xlabel "Location"
set ylabel "Points"
set grid xtics,ytics
set terminal svg
set style line 1 lw 2 pt 12
set style line 2 lw 2 pt 12
set output "team-points.svg"
plot [][-1:] "race-points.dat" u ($0):2:xtic(1) t "Points at Location" w lp ls 1,"race-points-agg.dat" u ($0):2:xtic(1) t "Points aggregated" w lp ls 2
set terminal qt
set output
# EOF
