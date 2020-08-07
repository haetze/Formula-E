#!/usr/local/Cellar/gnuplot/5.2.8/bin/gnuplot -persist -c
set xlabel "Race number"
set ylabel "Points"
set key autotitle columnhead
set grid xtics,ytics
set xzeroaxis
set terminal svg
set output ARG1
plot ARG2 u ($0 + 1):2 t "Punkte im Rennen" w l lc rgb "blue"
set terminal qt
set output
# EOF
