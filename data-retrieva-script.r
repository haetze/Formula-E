#!/usr/bin/env Rscript
library(XML)
library(RCurl)
library(rlist)
library(tidyverse)
library(dplyr)
library(stringr)

args = commandArgs(trailingOnly=TRUE)
race.id <- 117 # Berlin 06.08.2020
if(length(args) >= 1){
    potential.id <- strtoi(args[1], 10)
    if(!is.na(potential.id)){
        race.id <- potential.id
    }
}


base.urls <- "https://www.e-formel.de/rennergebnis.html"
url <- paste(base.urls, race.id, sep = "?rid=")
#print(url)

pole.position.string <- "<i class='fa fa-dot-circle-o fa-2x'aria-hidden='true' title='Pole-Position'></i>"
fanboost.string <- "<img style='padding-top: 4px; vertical-align: bottom' src='files/img/fb_logo_mini.png' alt='Fanboost' title='FanBoost'>"
quit.string <- "<i class='fa fa-circle fa-2x yellow' aria-hidden='true'></i>"
fastest.string <- "<i class='fa fa-tachometer fa-2x' aria-hidden='true' title='Schnellste Runde'></i>"


get.race.table <- function(url) {
    page.html <- getURL(url,.opts = list(ssl.verifypeer = FALSE) )
    page.html <- gsub(pole.position.string, "1", page.html)
    page.html <- gsub(fanboost.string, "1", page.html)
    page.html <- gsub(quit.string, "1", page.html)
    page.html <- gsub(fastest.string, "1", page.html)
    ## Figure title of race
    h1 <- str_locate_all(pattern = "<h1>.*</h1>", page.html)
    h1.beginning <- h1[[1]][1]
    h1.end <- h1[[1]][2]
    h1.text <- substring(page.html,h1.beginning+4, h1.end-5)

    tables <- readHTMLTable(page.html)
    tables <- list.clean(tables, fun = is.null, recursive = FALSE)
    race <- tables[1][[1]]
    for(t in tables) {
        if(length(colnames(race)) < length(colnames(t))) {
            race <- t
        }
    }

    race <- rbind(colnames(race), race)
    colnames(race) <- c("Team",
                        "Points",
                        "Rounds",
                        "Time",
                        "Fastest.Lap",
                        "Starting.Position",
                        "Position.Delta",
                        "Pole.Position",
                        "Had.Fastest",
                        "Fanboost",
                        "Quit")
    tmp <- tables[1][[1]]
    for(t in tables) {
        n <- colnames(t)
        l <- length(n)
        if(l == 2 && all(n == c("Platz", "Fahrer"))){
            tmp <- t
        }
    }
    race[["Driver"]] <- tmp[["Fahrer"]]
    race[["Final.Position"]] <- tmp[["Platz"]]

    race <- as_tibble(race)
    race <- select(race, -Team, -Position.Delta)
    race <- mutate(race, Had.Fastest = !is.na(strtoi(Had.Fastest, 2)))
    race <- mutate(race, Pole.Position = !is.na(strtoi(Pole.Position, 2)))
    race <- mutate(race, Quit = !is.na(strtoi(Quit, 2)))
    race <- mutate(race, Fanboost = !is.na(strtoi(Fanboost, 2)))
    race <- mutate(race, Starting.Position = strtoi(Starting.Position, 10))
    race <- mutate(race, Final.Position = strtoi(Final.Position, 10))
    race <- mutate(race, Rounds = strtoi(Rounds, 10))
    race <- mutate(race, Points = strtoi(Points, 10))
    race <- mutate(race, Fastest.Lap = as.difftime(Fastest.Lap, "%M:%OS"))
    race <- mutate(race, Time = as.difftime(Time, "%M:%OS"))
    race <- mutate(race, P.Delta = Starting.Position - Final.Position)

    tmp <- tables[3][[1]]
    colnames(tmp) <- c("Driver", "Team", "Q.Time")
    tmp <- as_tibble(tmp)
    tmp <- select(tmp, -Team)

    race <- inner_join(race, tmp, by = "Driver")
    race <- mutate(race, Q.Time = as.difftime(Q.Time, "%M:%OS"))
    race <- mutate(race, RID = race.id)
    race <- mutate(race, Title = h1.text)
    return(race)
}



write.data <- function(race) {
    number.of.lines <- dim(race)[1]
    race.id <- race[14][[1]][1]
    file.name <- paste(race.id, "dat", sep=".")
    file.path = paste(dir,file.name, sep="/")
    file.existance = file.access(file.path)
    if(file.existance == -1) {
        write.table(race, file.path)
    }
    
    for(i in seq(1,number.of.lines)) {
        line <- race[i,]
        file.name = paste(gsub(pattern=" ", replacement="-", line[["Driver"]]), "dat", sep=".")
        dir = "data"
        file.path = paste(dir,file.name, sep="/")
        file.existance = file.access(file.path)
        if(file.existance == 0) {
            ## File exists.
            ## Append line if doesn't exisit.
            from.storage <- read.table(file.path)
            rid.exists <- any(line[["RID"]] == from.storage[["RID"]])
            if(!rid.exists){
                combined <- rbind(from.storage, line)
                write.table(combined, file.path)
            }

        } else if(file.existance == -1){
            ## File doesn't exist.
            ## Write table to storage.
            write.table(line, file.path)


        }

    }

}


race <- get.race.table(url)
write.data(race)
