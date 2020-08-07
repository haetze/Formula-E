#!/usr/local/Cellar/gnuplot/5.2.8/bin/gnuplot -persist
sym(d) = d < 0 ? "▼" : "▲"
set xlabel "Location"
set ylabel "Positiondelta (higher is better)"
set grid xtics,ytics
set xzeroaxis
set terminal svg
set output "img/rast-positiondelta.svg"
plot "data/rast.dat" u ($0):14:xtic(1) t "Positiondelta" w l lc rgb "blue", "" u ($0):14:(sym($14)) w labels t ""
set terminal qt
set output
# EOF
