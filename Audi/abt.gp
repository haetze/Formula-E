#!/usr/local/Cellar/gnuplot/5.2.8/bin/gnuplot -persist
set xlabel "Location"
set ylabel "Positiondelta (higher is better)"
set grid xtics,ytics
set xzeroaxis
set terminal svg
set output "abt-positiondelta.svg"
plot "abt.dat" u ($0):14:xtic(1) t "Positiondelta" w lp
set terminal qt
set output
# EOF
