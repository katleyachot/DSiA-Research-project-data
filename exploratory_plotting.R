#exploratory plotting for hourly and long term trends for all services

library(dplyr)
library(lubridate)
library(ggplot2)

#load in mcslc data
clean_mcslc <- read.csv("./clean_mcslc.csv", header=TRUE)
#load in cahoots dataset
clean_cahoots <- read.csv("./clean_cahoots.csv")
#load in not cahoots dataset
clean_not_cahoots <- read.csv("./clean_epd.csv")

#add a new column that parses dispatch time to be able to plot it without errors
#standardizes the format, fixing rows without hour/minute/second
mcslc <- clean_mcslc %>% mutate(parsed_dispatch_time = parse_date_time(Dispatch.Request.Date...Time, order= c("ymd HMS", "ymd HM", "ymd")),     
                                hour = hour(parsed_dispatch_time)) #add hour column
#count hourly call volume
mcslc_hourly_count <- mcslc %>%
  group_by(hour) %>%
  summarise(count=n())

mcslc_hourly_count

#plot hourly count
ggplot(mcslc, aes(x = hour)) + geom_bar()+
  labs(
    title = "MCSLC hourly distribution",
    x = "Hour",
    y = "Count"
  )
ggsave("mcslc_hour_bar.png")

#create new df with year and quarter columns 
mcslc_quarter_calls <- mcslc %>%mutate(year = year(parsed_dispatch_time),quarter = quarter(parsed_dispatch_time))
#aggregating year/quarter call volume
mcslc_quarter_calls <- mcslc_quarter_calls %>%
  group_by(year, quarter) %>% 
  summarise(call_volume = n(), .groups = "drop")
#create new column with year and quarter indicated w Q#
mcslc_quarter_calls <- mcslc_quarter_calls %>% 
  mutate(year_quarter = paste0(year, " Q", quarter))

#plot yearly count
ggplot(mcslc_quarter_calls, aes(x = year_quarter, y = call_volume, group = 1)) +geom_line() + 
  geom_point() +
  labs(
    title = "MCSLC quarterly",
  )
ggsave("mcslc_year_line.png")


#add a new column that parses dispatch time to be able to plot it without errors
#standardizes the format, fixing rows without hour/minute/second
cahoots <- clean_cahoots %>% mutate(parsed_dispatch_time = parse_date_time(calltime, order= c("ymd HMS", "ymd HM", "ymd")),     
                                    hour = hour(parsed_dispatch_time)) #add hour column
#count hourly call volume
cahoots_hourly_count <- cahoots %>%
  group_by(hour) %>%
  summarise(count=n())

cahoots_hourly_count

#plot hourly count
ggplot(cahoots, aes(x = hour)) + geom_bar()+
  labs(
    title = "CAHOOTS hourly distribution",
    x = "Hour",
    y = "Count"
  )
ggsave("cahoots_hour_bar.png")

#create new df with year and quarter columns 
cahoots_quarter_calls <- cahoots %>%mutate(year = year(parsed_dispatch_time),quarter = quarter(parsed_dispatch_time))
#aggregating year/quarter call volume
cahoots_quarter_calls <- cahoots_quarter_calls %>%
  group_by(year, quarter) %>% 
  summarise(call_volume = n(), .groups = "drop")
#create new column with year and quarter indicated w Q#
cahoots_quarter_calls <- cahoots_quarter_calls %>% 
  mutate(year_quarter = paste0(year, " Q", quarter))

#plot yearly count
ggplot(cahoots_quarter_calls, aes(x = year_quarter, y = call_volume, group = 1)) +geom_line() + 
  geom_point() +
  labs(
    title = "CAHOOTS quarterly"
  )
ggsave("cahoots_year_line.png")


#add a new column that parses dispatch time to be able to plot it without errors
#standardizes the format, fixing rows without hour/minute/second
not_cahoots <- clean_not_cahoots %>% mutate(parsed_dispatch_time = parse_date_time(calltime, order= c("ymd HMS", "ymd HM", "ymd")),     
                                            hour = hour(parsed_dispatch_time)) #add hour column
#count hourly call volume
not_cahoots_hourly_count <- not_cahoots %>%
  group_by(hour) %>%
  summarise(count=n())

not_cahoots_hourly_count

#plot hourly count
ggplot(not_cahoots, aes(x = hour)) + geom_bar()+
  labs(
    title = "Not Cahoots EPD hourly distribution",
    x = "Hour",
    y = "Count"
  )
ggsave("not_cahoots_hour_bar.png")

#create new df with year and quarter columns 
not_cahoots_quarter_calls <- not_cahoots %>%mutate(year = year(parsed_dispatch_time),quarter = quarter(parsed_dispatch_time))
#aggregating year/quarter call volume
not_cahoots_quarter_calls <- not_cahoots_quarter_calls %>%
  group_by(year, quarter) %>% 
  summarise(call_volume = n(), .groups = "drop")
#create new column with year and quarter indicated w Q#
not_cahoots_quarter_calls <- not_cahoots_quarter_calls %>% 
  mutate(year_quarter = paste0(year, " Q", quarter))

#plot yearly count
ggplot(not_cahoots_quarter_calls, aes(x = year_quarter, y = call_volume, group = 1)) +geom_line() + 
  geom_point() +
  labs(
    title = "Not Cahoots quarterly"
  )
ggsave("not_cahoots_year_line.png")


#creating an overlapping kde chart
#create a column for each dataframe to indicate each service 
mcslc$service <- "MCSLC"
cahoots$service <- "CAHOOTS"
not_cahoots$service <- "EPD"
#combine all onto one dataframe
combined_calls <- bind_rows(mcslc, cahoots, not_cahoots)
ggplot(combined_calls, aes(x = hour, fill = service, color = service)) +
  geom_density(alpha = 0.3, bw=1) +
  labs(
    title = "Hourly Call Distribution by Service",
    x = "Hour of Day",
    y = "Density"
  ) +
  scale_x_continuous(breaks = 0:23) +
  theme_minimal()
ggsave("overlapkde.png")


#radial line plot... not sure if I love this
mcslc_hourly_count$service <- "MCSLC"
cahoots_hourly_count$service <- "CAHOOTS"
not_cahoots_hourly_count$service <- "EPD"
hourly_combined <- bind_rows(
  mcslc_hourly_count,
  cahoots_hourly_count,
  not_cahoots_hourly_count
  )
hourly_density <- hourly_combined %>%
  group_by(service) %>%
  mutate(density = count / sum(count))
hourly_density_closed <- hourly_density %>%
  bind_rows(
    hourly_density %>% filter(hour == 0) %>% mutate(hour = 24)
  )
ggplot(hourly_density_closed,
       aes(x = hour, y = density, color = service, group = service)) +
  geom_line(linewidth = 1.2) +
  coord_polar(start = 0) +
  scale_x_continuous(breaks = seq(0, 23, by = 3)) +
  labs(
    title = "Hourly Call Density by Service",
    x = "Hour of Day",
    y = "Proportion of Daily Calls",
    color = "Service"
  ) +
  theme_minimal()

