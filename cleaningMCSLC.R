#load in data
library(readr)
MCSLC <- read_csv("project data/research_data_export/MCSLC.csv")
View(MCSLC)

#Select only relevant columns
MCSLC <- MCSLC %>% select(c("ID", "City", "Dispatch Request Date & Time", "Dispatch Date & Time", "MCIT Departure Date & Time", "Reason for Dispatch #1"))
glimpse(MCSLC)

#filter for only Eugene observations
eug_MCSLC <- MCSLC %>% filter(City == "Eugene")

#convert date columns to datetime objects
eug_MCSLC$`Dispatch Request Date & Time` <- as.POSIXct(eug_MCSLC$`Dispatch Request Date & Time`,format = "%m/%d/%y %H:%M")
eug_MCSLC$`Dispatch Date & Time` <- as.POSIXct(eug_MCSLC$`Dispatch Date & Time`,format = "%m/%d/%y %H:%M")
eug_MCSLC$`MCIT Departure Date & Time` <- as.POSIXct(eug_MCSLC$`MCIT Departure Date & Time`, format = "%m/%d/%y %H:%M")

#create all_midnight comment where 1s denote observations with all 0:00 for hour:minute
eug_MCSLC <- eug_MCSLC %>% mutate(all_midnight = ifelse(hour(`Dispatch Request Date & Time`) == 0 &
                                                          minute(`Dispatch Request Date & Time`) == 0 &
                                                          hour(`Dispatch Date & Time`) == 0 &
                                                          minute(`Dispatch Date & Time`) == 0 &
                                                          hour(`MCIT Departure Date & Time`) == 0 &
                                                          minute(`MCIT Departure Date & Time`) == 0,
                                                        which(is.na(eug_MCSLC), arr.ind = TRUE), 1, 0))

#filter out any observations where Dispatch Request columns are NAs
library(dplyr)
library(tidyr)
eug_MCSLC <- eug_MCSLC %>% drop_na(`Dispatch Request Date & Time`)

#save dataframe to new csv file
write.csv(eug_MCSLC, "clean_mcslc.csv", row.names = FALSE)

