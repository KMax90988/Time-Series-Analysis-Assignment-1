#Assignment 1 Part 1 Code - Time Series Analysis
#Maximus Caruso a1821471

#Declaration of libraries that may be used throughout the project:
library(tsibble)
library(fable)
library(feasts)
library(dplyr)
library(ggplot2)
library(tidyr)

#For coding convenience since only one dataset will be used for this Assignment,
#let BirthsAndFertilityRatesAnnual be called "Dataset".
#The following code both sorts the dataset and renames variables for convenience
#in later stages. It does this using column manipulation resulting in a 'tidy'
#format:
Dataset <- read.csv("BirthsAndFertilityRatesAnnual.csv") %>%
  pivot_longer(cols = -DataSeries, names_to = "Year", values_to = "Value") %>%
  mutate(Year = as.numeric(Year)) %>%
  filter(DataSeries %in% c("Total Fertility Rate (TFR)", "Total Live-Births")) %>%
  pivot_wider(names_from = DataSeries, values_from = Value) %>%
  rename(TFR = `Total Fertility Rate (TFR)`,
         TLB = `Total Live-Births`) %>%
  filter(Year >= 1960 & Year <= 2024)

