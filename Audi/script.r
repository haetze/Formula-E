tab <- read.table("team.dat", sep="", header=TRUE)
abt <- tab[tab[["Driver"]] == "Daniel Abt",!(names(tab) %in% c("Driver"))]
di.Grassi<- tab[tab[["Driver"]] == "Lucas di Grassi",!(names(tab) %in% c("Driver"))]


sum.for.race.day <- aggregate(tab[c("PositionP", "Pole", "Fastes.Lap.Qualifying", "Fastes.Lap.Race")], by = list(tab[["Date"]]), sum)
location.for.race.day <- aggregate(tab[c("Location")], by = list(tab[["Date"]]), function(x) x[1])

sum.for.race.category <- merge(location.for.race.day, sum.for.race.day)

names(sum.for.race.category)[names(sum.for.race.category) == "Group.1"] <- "Date"

sum.for.race <- data.frame("Location" = sum.for.race.category[["Location"]],
                           "Points" =
                               sum.for.race.category[["PositionP"]] +
                               sum.for.race.category[["Pole"]] +
                               sum.for.race.category[["Fastes.Lap.Qualifying"]] +
                               sum.for.race.category[["Fastes.Lap.Race"]]
                           )

write.table(x = sum.for.race,
            file = "race-points.dat",
            row.names = FALSE)

sum.for.race.agg = sum.for.race

agg <- 0
for(i in seq(1, length(sum.for.race[["Points"]]))) {
    sum.for.race.agg[["Points"]][i] <- sum.for.race[["Points"]][i] + agg
    agg <- sum.for.race.agg[["Points"]][i]
}

write.table(x = sum.for.race.agg,
            file = "race-points-agg.dat",
            row.names = FALSE)


abt[["Positiondelta"]] = abt[["Startingposition"]] - abt[["Position"]]
di.Grassi[["Positiondelta"]] = di.Grassi[["Startingposition"]] - di.Grassi[["Position"]]

write.table(x = abt,
            file = "abt.dat",
            row.names = FALSE)

write.table(x = di.Grassi,
            file = "di-Grassi.dat",
            row.names = FALSE)



