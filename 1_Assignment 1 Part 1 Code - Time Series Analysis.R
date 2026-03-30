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
#in later stages. It does this by utilising column manipulation.

#The previous iteration ran into type errors, so a reworked approach has been
#implemented taking a step back to first process the raw data in multiple steps.
#The below code produces introductory plots:


#Extracting raw .csv data:
Dataset_raw <- read.csv("BirthsAndFertilityRatesAnnual.csv")

#Converting to a long dataframe format, and renaming labels for convenience:
Dataset_long <- Dataset_raw %>%
  pivot_longer(
    cols = -DataSeries,         
    names_to = "Year",         
    values_to = "Value",  
    values_transform = list(Value = as.numeric) 
  )

#Further fixing the years columns format:
Dataset_long <- Dataset_long %>%
  mutate(Year = as.numeric(gsub("X", "", Year)))

#Filtering for desired data values for the assignment, TFR and TLB:
Dataset_filtered <- Dataset_long %>%
  filter(DataSeries %in% c("Total Fertility Rate (TFR)", 
                           "Total Live-Births"))

#Reconverting to a wide dataframe format:
Dataset <- Dataset_filtered %>%
  pivot_wider(names_from = DataSeries, values_from = Value)

#Renaming remaining value columns for convenience:
Dataset <- Dataset %>%
  rename(
    TFR = `Total Fertility Rate (TFR)`,
    TLB = `Total Live-Births`
  )

#Filtering desired years for part 1 of the assignment:
Dataset <- Dataset %>%
  filter(Year >= 1960 & Year <= 2024)

#Converting to a tsibble for later time series analysis:
ts_data <- Dataset %>%
  as_tsibble(index = Year)


#Plotting TLB:
ggplot(ts_data, aes(x = Year, y = TLB)) +
  geom_line() +
  ggtitle("Total Live Births over Time")

#Plotting TFR:
ggplot(ts_data, aes(x = Year, y = TFR)) +
  geom_line() +
  ggtitle("Total Fertility Rate over Time")