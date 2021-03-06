#!/usr/bin/env Rscript
#
#
# Script: CherryTomatos.r
#
# Stand: 2020-10-21
# (c) 2020 by Thomas Arend, Rheinbach
# E-Mail: thomas@arend-rhb.de
#

MyScriptName <-"ggHistogram"

require(data.table)

setwd("~/git/R/MiniTomatoes/R")

source("lib/copyright.r")
source("lib/myfunctions.r")
library(REST)
library(ggplot2)
library(viridis)
library(hrbrthemes)

w1 <- read.csv('../data/data1.csv', dec = '.', )

weight <-as.data.table(table(w1$weight))

colnames(weight) <- c('Gewicht', 'Anzahl')

# setorder(weight,Gewicht)

gseq <- seq(1,max(weight[,2])+1)
gcount <- rep(0,length(gseq))

w <- data.frame(

  Gewicht = gseq
  , Anzahl = gcount
)

for (i in 1:nrow(weight)) {

  w[as.numeric(weight[i,1]),2] <- weight[i,2]

}
  
blp <- ggplot(w,aes(x=Gewicht, y=Anzahl)) + 
  geom_histogram(stat = "identity")

ggsave(plot = blp, file = paste('../png/', MyScriptName,".png", sep="")
       , type = "cairo-png",  bg = "white"
       , width = 29.7, height = 21, units = "cm", dpi = 150)

print ( c(mean(w1[,2]), sd(w1[,2])))
