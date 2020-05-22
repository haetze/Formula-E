#!/usr/local/Cellar/gnuplot/5.2.8/bin/gnuplot -persist
set xlabel "Location"
set ylabel "Positiondelta (higher is better)"
set grid xtics,ytics
set terminal svg
set output "di-Grassi-positiondelta.svg"
plot "di-Grassi.dat" u 14:xticlabels(1) t "Positiondelta" w lp, 0 w l lt rgb "black" t ""
set terminal qt
set output
# EOF
