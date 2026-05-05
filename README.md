# DSiA-Research-project-data
This repository contains scripts for cleaning the raw CAD data and MCSLC data.

## Purpose
The goal of these steps is to clean the raw call data and to output structured CSV files for analysis

## Folder Contents
cleaningMCSLC.R: Loads raw data, fixes formatting issues, and outputs a cleaned version.

cleaningCAD.R: Loads raw data, fixes formatting issues, and outputs a cleaned version.

## Input Files
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

## Output Files
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

