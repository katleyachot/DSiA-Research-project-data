# DSiA-Research-project
This repository contains scripts for running a temporal call pattern analysis. The analysis investigates the changes in hourly and long-term patterns of emergency dispatch services after CAHOOTS ended services in Eugene.
The repository contains scripts for cleaning the raw CAD data and MCSLC data, scripts for exploring patterns through visualizations, and scripts to run difference in differences analyses. 

## Purpose
The goal of these steps is to clean the raw call data and to output structured CSV files for analysis

## Folder Contents
cleaningMCSLC.R: Loads raw data, fixes formatting issues, and outputs a cleaned version.
cleaningCAD.R: Loads raw data, fixes formatting issues, and outputs a cleaned version.

exploratory_plotting.R: Creates hourly counts and plots hourly distribution and quarterly trends of EPD, CAHOOTS, and MCSLC.

splitting_cad.R: Splits EPD and SPD CAD data into CAHOOTS and not CAHOOTS, outputs CSVs of the four respective datasets.

creating_pop_table.R: Creates a dataframe containing Eugene and Springfield population from 2015 to 2025.

hourly_DiD.R: Performs parallel trend test and difference of differences test of MCSLC and police data, outputs model summary and visualizations of hourly pattern changes.

yearly_DiD.R: Performs parallel trend test and difference of differences test of MCSLC and police data, outputs model summary and visualizations of long-term pattern changes.

## Cleaning Input Files
- EugeneCAD2015noloc.csv
- EugeneCAD2016noloc.csv
- EugeneCAD2017noloc.csv
- EugeneCAD2018noloc.csv
- EugeneCAD2019noloc.csv
- EugeneCAD2020noloc.csv
- EugeneCAD2021noloc.csv
- EugeneCAD2022noloc.csv
- EugeneCAD2023noloc.csv
- EugeneCAD2024noloc.csv
- EugeneCAD2025noloc.csv
- MCSLC.csv
- 2015spd.csv
- 2016spd.csv
- 2017spd.csv
- 2018spd.csv
- 2019spd.csv
- 2020spd.csv
- 2021spd.csv
- 2022spd.csv
- 2023spd.csv
- 2024spd.csv
- 2025spd.csv

## Cleaning Output Files
- clean_cad.csv
- clean_cad2015.csv
- clean_cad2016.csv
- clean_cad2017.csv
- clean_cad2018.csv
- clean_cad2019.csv
- clean_cad2020.csv
- clean_cad2021.csv
- clean_cad2022.csv
- clean_cad2023.csv
- clean_cad2024.csv
- clean_cad2025.csv
- clean_mcsls.csv

## Plotting Input Files
- clean_mcslc.csv
- clean_cahoots.csv
- clean_epd.csv

## Plotting Output Files
- mcslc_hour_bar.png
- mcslc_year_line.png
- cahoots_hour_bar.png
- cahoots_year_line.png
- not_cahoots_hour_bar.png
- not_cahoots_year_line.png

## How to Run
Run the following scripts to clean the data
  - cleaningCAD.R
  - cleaningMCSLC.R
  - plotting_mcslc_cad.R

# Dependencies
This project uses the following R packages:
- dplyr
- lubridate
- readr
- stringr
- tidyverse
- tidyr

