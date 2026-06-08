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
- clean_s_cad.csv
- clean_spd2015.csv
- clean_spd2016.csv
- clean_spd2017.csv
- clean_spd2018.csv
- clean_spd2019.csv
- clean_spd2020.csv
- clean_spd2021.csv
- clean_spd2022.csv
- clean_spd2023.csv
- clean_spd2024.csv
- clean_spd2025.csv

## Splitting CAD Input Files
- clean_cad.csv
- clean_s_cad.csv
## Splitting CAD Output Files
- clean_eug_cahoots.csv
- clean_epd.csv
- clean_spr_cahoots.csv
- clean_spd.csv

## Exploratory Plotting Input Files
- clean_mcslc.csv
- clean_cahoots.csv
- clean_epd.csv

## Exploratory Plotting Output Files
- mcslc_hour_bar.png
- mcslc_year_line.png
- cahoots_hour_bar.png
- cahoots_year_line.png
- not_cahoots_hour_bar.png
- not_cahoots_year_line.png

## Hourly Analysis Input Files
- clean_eug_mclsc.csv
- clean_spr_mcslc.csv
- clean_eug_cahoots.csv
- clean_spr_cahoots.csv
- clean_epd.csv
- clean_s_cad.csv

## Hourly Analysis Output Files
- hourly_eug_mcslc.png
- hourly_spr_mcslc.png
- hourly_epd.png
- hourly_spd.png
- pre25_mclsc.png
- pre25_police.png
- pre25_cahoots.png
- spr_and_eug_cahoots_hour.png

## Long-term Analysis Input Files 
-  clean_eug_mclsc.csv
- clean_spr_mcslc.csv
- clean_eug_cahoots.csv
- clean_spr_cahoots.csv
- clean_epd.csv
- clean_s_cad.csv
  
## Long-term Analysis Output Files
- police_year.png
- cahoots_year.png
- mcslc_year.png

## How to Run
Run the following scripts to clean, plot, and analyze the data
  - cleaningCAD.R
  - cleaningMCSLC.R
  - splitting_cad.R
  - exploratory_plotting.R
  - hourly_DiD.R
  - year_DiD.R

# Dependencies
This project uses the following R packages:
- dplyr
- lubridate
- readr
- stringr
- tidyverse
- tidyr

