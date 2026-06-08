
library(dplyr)
#read in cad data
clean_cad <- read.csv("~/Documents/DSiA/clean_cad.csv", header=TRUE)

#split into cahoots and other service
to_split <- split(clean_cad, clean_cad$cahoots == 0)
CAHOOTS <- to_split[[1]]
not_cahoots <- to_split[[2]]

#dropping the cahoots column since it is not needed anymore
CAHOOTS <- CAHOOTS %>% select(-c(cahoots))
not_cahoots <- not_cahoots %>% select(-c(cahoots))

write.csv(CAHOOTS, "clean_eug_cahoots.csv", row.names = FALSE)
write.csv(not_cahoots, "clean_epd.csv", row.names = FALSE)

#read in springfield cad data
clean_spd <- read.csv("~/Documents/DSiA/clean_s_cad.csv", header=TRUE)
#split into cahoots and other service
to_split <- split(clean_spd, clean_spd$cahoots == 0)
CAHOOTSs <- to_split[[1]]
not_cahootss <- to_split[[2]]

#dropping the cahoots column since it is not needed anymore
CAHOOTSs <- CAHOOTSs %>% select(-c(cahoots))
not_cahootss <- not_cahootss %>% select(-c(cahoots))

write.csv(CAHOOTSs, "clean_spr_cahoots.csv", row.names = FALSE)
write.csv(not_cahootss, "clean_spd.csv", row.names = FALSE)
