#This is the week 2 assignment for BIOL432, created by Zoe Clarke Jan 16, 2019
library(dplyr)

#Read in csv file
MyData <- read.csv("InData.csv")

#Only keep rows with "Total" biomass < 60
MyData1 <- filter(MyData, Total < 60)

#Reorder and keep only select columns:
MyData2 <- select(MyData1, Total, Taxon, Scenario, Nutrients)

#Convert total from mg to g and make this a new column to replace "Total"
MyData3 <- transmute(MyData2, TotalG = Total*0.001, Taxon, Scenario, Nutrients)

#Replace strings under "Nutrients" column with first letter only
newNutrients <- factor(c(gsub("(\\w)\\w+", "\\1", MyData3$Nutrients)))
MyData4 <- transmute(MyData3, TotalG, Taxon, Scenario, Nutrients = newNutrients)

#Replace periods under"TotalG" column with commas
newCommas <- gsub("\\D", ",", MyData4$TotalG)
MyData5 <- transmute(MyData4, TotalG = newCommas, Taxon, Scenario, Nutrients)
