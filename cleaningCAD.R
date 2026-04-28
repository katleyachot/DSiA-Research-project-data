#load in data
EugeneCAD2015noloc <- read.csv("~/Documents/DSiA/project data/research_data_export/Eugene_CAD_data_noloc/EugeneCAD2015noloc.csv")

#select only relevant columns
cad2015 <- EugeneCAD2015noloc %>% select(c("yr", "inci_id", "calltime", "nature", "primeunit"))

#convert calltime column to datetime object
cad2015$calltime <- as.POSIXct(cad2015$calltime,format = "%Y-%m-%d %H:%M:%OS")

#check for NAs
which(is.na(cad2015), arr.ind = TRUE)
sum(is.na(cad2015))

#create cahoots column to indicate if primeunit translates to cahoots unit
#cahoots units use pattern "_#J##" or code "_CAHOT"
cad2015 <- cad2015 %>% mutate(cahoots = as.integer(str_detect(str_trim(primeunit),"^_[0-9]J[0-9]{2}$|^_CAHOT$")))

#check range of dates to check for outliers
range(cad2015$calltime, na.rm = TRUE)
#check for duplicate entries
sum(duplicated(cad2015))

#save cleaned dataframe to new csv 
write.csv(cad2015, "clean_cad2015.csv", row.names = FALSE)

#repeat steps for the other 9 years
EugeneCAD2016noloc <- read.csv("~/Documents/DSiA/project data/research_data_export/Eugene_CAD_data_noloc/EugeneCAD2016noloc.csv")
cad2016 <- EugeneCAD2016noloc %>% select(c("yr", "inci_id", "calltime", "nature", "primeunit"))
cad2016$calltime <- as.POSIXct(cad2016$calltime,format = "%Y-%m-%d %H:%M:%OS")
which(is.na(cad2016), arr.ind = TRUE)
sum(is.na(cad2016))
cad2016 <- cad2016 %>% mutate(cahoots = as.integer(str_detect(str_trim(primeunit),"^_[0-9]J[0-9]{2}$|^_CAHOT$")))
range(cad2016$calltime, na.rm = TRUE)
sum(duplicated(cad2016))
write.csv(cad2016, "clean_cad2016.csv", row.names = FALSE)

EugeneCAD2017noloc <- read.csv("~/Documents/DSiA/project data/research_data_export/Eugene_CAD_data_noloc/EugeneCAD2017noloc.csv")
cad2017 <- EugeneCAD2017noloc %>% select(c("yr", "inci_id", "calltime", "nature", "primeunit"))
cad2017$calltime <- as.POSIXct(cad2017$calltime,format = "%Y-%m-%d %H:%M:%OS")
sum(is.na(cad2017))
cad2017 <- cad2017 %>% mutate(cahoots = as.integer(str_detect(str_trim(primeunit),"^_[0-9]J[0-9]{2}$|^_CAHOT$")))
range(cad2017$calltime, na.rm = TRUE)
sum(duplicated(cad2017))
write.csv(cad2017, "clean_cad2017.csv", row.names = FALSE)

EugeneCAD2018noloc <- read.csv("~/Documents/DSiA/project data/research_data_export/Eugene_CAD_data_noloc/EugeneCAD2018noloc.csv")
cad2018 <- EugeneCAD2018noloc %>% select(c("yr", "inci_id", "calltime", "nature", "primeunit"))
cad2018$calltime <- as.POSIXct(cad2018$calltime,format = "%Y-%m-%d %H:%M:%OS")
sum(is.na(cad2018))
cad2018 <- cad2018 %>% mutate(cahoots = as.integer(str_detect(str_trim(primeunit),"^_[0-9]J[0-9]{2}$|^_CAHOT$")))
range(cad2018$calltime, na.rm = TRUE)
sum(duplicated(cad2018))
write.csv(cad2018, "clean_cad2018.csv", row.names = FALSE)

EugeneCAD2019noloc <- read.csv("~/Documents/DSiA/project data/research_data_export/Eugene_CAD_data_noloc/EugeneCAD2019noloc.csv")
cad2019 <- EugeneCAD2019noloc %>% select(c("yr", "inci_id", "calltime", "nature", "primeunit"))
cad2019$calltime <- as.POSIXct(cad2019$calltime,format = "%Y-%m-%d %H:%M:%OS")
sum(is.na(cad2019))
cad2019 <- cad2019 %>% mutate(cahoots = as.integer(str_detect(str_trim(primeunit),"^_[0-9]J[0-9]{2}$|^_CAHOT$")))
range(cad2019$calltime, na.rm = TRUE)
sum(duplicated(cad2019))
write.csv(cad2019, "clean_cad2019.csv", row.names = FALSE)

EugeneCAD2020noloc <- read.csv("~/Documents/DSiA/project data/research_data_export/Eugene_CAD_data_noloc/EugeneCAD2020noloc.csv")
cad2020 <- EugeneCAD2020noloc %>% select(c("yr", "inci_id", "calltime", "nature", "primeunit"))
cad2020$calltime <- as.POSIXct(cad2020$calltime,format = "%Y-%m-%d %H:%M:%OS")
sum(is.na(cad2020))
cad2020 <- cad2020 %>% mutate(cahoots = as.integer(str_detect(str_trim(primeunit),"^_[0-9]J[0-9]{2}$|^_CAHOT$")))
range(cad2020$calltime, na.rm = TRUE)
sum(duplicated(cad2020))
write.csv(cad2020, "clean_cad2020.csv", row.names = FALSE)

EugeneCAD2021noloc <- read.csv("~/Documents/DSiA/project data/research_data_export/Eugene_CAD_data_noloc/EugeneCAD2021noloc.csv")
cad2021 <- EugeneCAD2021noloc %>% select(c("yr", "inci_id", "calltime", "nature", "primeunit"))
cad2021$calltime <- as.POSIXct(cad2021$calltime,format = "%Y-%m-%d %H:%M:%OS")
sum(is.na(cad2021))
cad2021 <- cad2021 %>% mutate(cahoots = as.integer(str_detect(str_trim(primeunit),"^_[0-9]J[0-9]{2}$|^_CAHOT$")))
range(cad2021$calltime, na.rm = TRUE)
sum(duplicated(cad2021))
write.csv(cad2021, "clean_cad2021.csv", row.names = FALSE)

EugeneCAD2022noloc <- read.csv("~/Documents/DSiA/project data/research_data_export/Eugene_CAD_data_noloc/EugeneCAD2022noloc.csv")
cad2022 <- EugeneCAD2022noloc %>% select(c("yr", "inci_id", "calltime", "nature", "primeunit"))
cad2022$calltime <- as.POSIXct(cad2022$calltime,format = "%Y-%m-%d %H:%M:%OS")
sum(is.na(cad2022))
cad2022 <- cad2022 %>% mutate(cahoots = as.integer(str_detect(str_trim(primeunit),"^_[0-9]J[0-9]{2}$|^_CAHOT$")))
range(cad2022$calltime, na.rm = TRUE)
sum(duplicated(cad2022))
write.csv(cad2022, "clean_cad2022.csv", row.names = FALSE)

EugeneCAD2023noloc <- read.csv("~/Documents/DSiA/project data/research_data_export/Eugene_CAD_data_noloc/EugeneCAD2023noloc.csv")
cad2023 <- EugeneCAD2022noloc %>% select(c("yr", "inci_id", "calltime", "nature", "primeunit"))
cad2023 <- EugeneCAD2023noloc %>% select(c("yr", "inci_id", "calltime", "nature", "primeunit"))
cad2023$calltime <- as.POSIXct(cad2023$calltime,format = "%Y-%m-%d %H:%M:%OS")
view(cad2023)
sum(is.na(cad2023))
cad2023 <- cad2023 %>% mutate(cahoots = as.integer(str_detect(str_trim(primeunit),"^_[0-9]J[0-9]{2}$|^_CAHOT$")))
range(cad2023$calltime, na.rm = TRUE)
sum(duplicated(cad2023))
write.csv(cad2023, "clean_cad2023.csv", row.names = FALSE)

EugeneCAD2024noloc <- read.csv("~/Documents/DSiA/project data/research_data_export/Eugene_CAD_data_noloc/EugeneCAD2024noloc.csv")
cad2024 <- EugeneCAD2024noloc %>% select(c("yr", "inci_id", "calltime", "nature", "primeunit"))
cad2024$calltime <- as.POSIXct(cad2024$calltime,format = "%Y-%m-%d %H:%M:%OS")
sum(is.na(cad2024))
cad2024 <- cad2024 %>% mutate(cahoots = as.integer(str_detect(str_trim(primeunit),"^_[0-9]J[0-9]{2}$|^_CAHOT$")))
range(cad2024$calltime, na.rm = TRUE)
sum(duplicated(cad2024))
write.csv(cad2024, "clean_cad2024.csv", row.names = FALSE)

EugeneCAD2025noloc <- read.csv("~/Documents/DSiA/project data/research_data_export/Eugene_CAD_data_noloc/EugeneCAD2025noloc.csv")
cad2025 <- EugeneCAD2025noloc %>% select(c("yr", "inci_id", "calltime", "nature", "primeunit"))
cad2025$calltime <- as.POSIXct(cad2025$calltime,format = "%Y-%m-%d %H:%M:%OS")
sum(is.na(cad2025))
cad2025 <- cad2025 %>% mutate(cahoots = as.integer(str_detect(str_trim(primeunit),"^_[0-9]J[0-9]{2}$|^_CAHOT$")))
range(cad2025$calltime, na.rm = TRUE)
sum(duplicated(cad2025))
write.csv(cad2025, "clean_cad2025.csv", row.names = FALSE)


#combine all years into full CAD dataframe
cad_all <- bind_rows(mget(paste0("cad", 2015:2025)))
view(cad_all)
#save combined dataframe into new csv file
write.csv(cad_all, "clean_cad.csv", row.names = FALSE)
