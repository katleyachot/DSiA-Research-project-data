library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
options(ggplot2.discrete.colour= c("#8e34e3","#e36b34"))

#load in data
clean_e_mcslc <- read.csv("./clean_eug_mcslc.csv", header=TRUE)
clean_s_mcslc<- read.csv("./clean_spr_mcslc.csv", header=TRUE)
clean_s_cahoots <-read.csv("./clean_spr_cahoots.csv")
clean_e_cahoots <- read.csv("./clean_eug_cahoots.csv")
clean_epd <- read.csv("./clean_epd.csv")
clean_spd <- read.csv("./clean_s_cad.csv")

#standardize datetime and add hour column
e_mcslc <- clean_e_mcslc %>% mutate(parsed_dispatch_time = parse_date_time(
          Dispatch.Request.Date...Time, order= c("ymd HMS", "ymd HM", "ymd")),     
            hour = hour(parsed_dispatch_time)) #add hour column
s_mcslc <- clean_s_mcslc %>% mutate(parsed_dispatch_time = parse_date_time(
          Dispatch.Request.Date...Time, order= c("ymd HMS", "ymd HM", "ymd")),     
            hour = hour(parsed_dispatch_time)) #add hour column

spd <- clean_spd %>% mutate(parsed_dispatch_time = parse_date_time(
          Call.Creation.Time, order = c("ymd HMS", "ymd HM", "ymd")),
            hour = hour(parsed_dispatch_time))
epd <- clean_epd %>% mutate(parsed_dispatch_time = parse_date_time(
          calltime,order = c("ymd HMS", "ymd HM", "ymd")),
            hour = hour(parsed_dispatch_time))

eug_cahoots <-clean_e_cahoots%>% mutate(parsed_dispatch_time = parse_date_time(
         calltime, order = c("ymd HMS", "ymd HM", "ymd")),
           hour = hour(parsed_dispatch_time))
spr_cahoots <-clean_s_cahoots%>% mutate(parsed_dispatch_time = parse_date_time(
         Call.Creation.Time, order = c("ymd HMS", "ymd HM", "ymd")),
          hour = hour(parsed_dispatch_time))

#define cahoots end as april 7, 2025 
cahoots_end <- as.POSIXct("2025-04-07")

#split data into before cahoots end and after
e_mcslc_before <- e_mcslc %>%
  filter(parsed_dispatch_time < cahoots_end)
e_mcslc_after <- e_mcslc %>%
  filter(parsed_dispatch_time >= cahoots_end)

s_mcslc_before <- s_mcslc %>%
  filter(parsed_dispatch_time < cahoots_end)
s_mcslc_after <- s_mcslc %>%
  filter(parsed_dispatch_time >= cahoots_end)
  
epd_before <- epd %>%
  filter(parsed_dispatch_time < cahoots_end)
epd_after <- epd %>%
  filter(parsed_dispatch_time >= cahoots_end)

spd_before <- spd %>%
  filter(parsed_dispatch_time < cahoots_end)
spd_after <- spd %>%
  filter(parsed_dispatch_time >= cahoots_end)

spr_cahoots_before <- spr_cahoots%>%
  filter(parsed_dispatch_time < cahoots_end)
spr_cahoots_after <- spr_cahoots%>%
  filter(parsed_dispatch_time >= cahoots_end)

#label for before and after
e_mcslc_before$period <- "before"
e_mcslc_after$period <- "after"
#recombine with labels
combined_e_mcslc <- bind_rows( e_mcslc_after,e_mcslc_before)
combined_e_mcslc$period <- factor(
  combined_e_mcslc$period,
  levels = c("before", "after")
)
#plot before and after
ggplot(combined_e_mcslc, aes(x = hour, fill = period, color = period)) +
  geom_density(alpha = 0.2, bw=1) +
  scale_fill_manual(
    values = c(
      "before" = "blue",
      "after" = "red"
    )
  )+
  labs(
    title = "Hourly Eugene MCSLC Call Distribution",
    subtitle= "Before and After CAHOOTS Ended",
    x = "Hour of Day",
    y = "Density"
  ) +
  scale_x_continuous(breaks = 0:23) +
  theme_minimal()

ggsave("hourly_eug_mcslc.png",bg = "white")

#repeat for other services
s_mcslc_before$period <- "before"
s_mcslc_after$period <- "after"
combined_s_mcslc <- bind_rows(s_mcslc_before, s_mcslc_after)
combined_s_mcslc$period <- factor(
  combined_s_mcslc$period,
  levels = c("before", "after")
)
ggplot(combined_s_mcslc, aes(x = hour, fill = period, color = period)) +
  geom_density(alpha = 0.2, bw=1) +
  scale_fill_manual(
    values = c(
      "before" = "blue",
      "after" = "red"
    )
  )+
  labs(
    title = "Hourly Springfield MCSLC Call Distribution",
    subtitle= "Before and After CAHOOTS Ended",
    x = "Hour of Day",
    y = "Density"
  ) +
  scale_x_continuous(breaks = 0:23) +
  theme_minimal()
ggsave("hourly_spr_mcslc.png",bg = "white")

#epd
epd_before$period <- "before"
epd_after$period <- "after"
combined_epd <- bind_rows(epd_before, epd_after)
combined_epd$period <- factor(
  combined_epd$period,
  levels = c("before", "after")
)
ggplot(combined_epd, aes(x = hour, fill = period, color = period)) +
  geom_density(alpha = 0.2, bw=1) +
    scale_fill_manual(
    values = c(
      "before" = "blue",
      "after" = "red"
    )
  )+
  labs(
    title = "Hourly EPD Call Distribution",
    subtitle= "Before and After CAHOOTS Ended",
    x = "Hour of Day",
    y = "Density"
  ) +
  scale_x_continuous(breaks = 0:23) +
  theme_minimal()
ggsave("hourly_epd.png",bg = "white")


spd_before$period <- "before"
spd_after$period <- "after"
combined_spd <- bind_rows(spd_before, spd_after)
combined_spd$period <- factor(
  combined_spd$period,
  levels = c("before", "after")
)
ggplot(combined_spd, aes(x = hour, fill = period, color = period)) +
  geom_density(alpha = 0.2, bw=1) +
  scale_fill_manual(
    values = c(
      "before" = "blue",
      "after" = "red"
    )
  )+
  labs(
    title = "Hourly SPD Call Distribution",
    subtitle= "Before and After CAHOOTS Ended",
    x = "Hour of Day",
    y = "Density"
  ) +
  scale_x_continuous(breaks = 0:23) +
  theme_minimal()
ggsave("hourly_spd.png",bg = "white")

ggplot(eug_cahoots, aes(x = hour)) +
  geom_density(alpha = 0.2, bw=1) +
  labs(
    title = "Hourly Eugene Cahoots Call Distribution",
    x = "Hour of Day",
    y = "Density"
  ) +
  scale_x_continuous(breaks = 0:23) +
  theme_minimal()

spr_cahoots_before$period <- "before"
spr_cahoots_after$period <- "after"
combined_spr_cahoots <- bind_rows(spr_cahoots_before, spr_cahoots_after)
ggplot(combined_spr_cahoots, aes(x = hour, fill = period, color = period)) +
  geom_density(alpha = 0.3, bw=1) +
  labs(
    title = "Hourly Springfield Cahoots Call Distribution",
    x = "Hour of Day",
    y = "Density"
  ) +
  scale_x_continuous(breaks = 0:23) +
  theme_minimal()



epd_hourly_avg <- epd %>%
  mutate(
    period = ifelse(
      parsed_dispatch_time < cahoots_end,
      "Before",
      "After"
    )
  ) %>%
  group_by(period, hour) %>%
  summarise(
    avg_calls = n() / n_distinct(as.Date(parsed_dispatch_time)),
    .groups = "drop"
  )
ggplot(epd_hourly_avg,
       aes(x = hour,
           y = avg_calls,
           color = period)) +
  geom_line(linewidth = 1.2) +
  geom_point() +
  scale_x_continuous(breaks = 0:23) +
  labs(
    title = "Average Hourly EPD Calls",
    x = "Hour of Day",
    y = "Average Calls per Hour"
  ) +
  theme_minimal()


#compare each service's before trends to ensure parallell trends
mcslc_before <- bind_rows(
  e_mcslc_before %>% mutate(city = "Eugene"),
  s_mcslc_before %>% mutate(city = "Springfield")
)

mcslc_hourly <- mcslc_before %>%
  count(city, hour) %>%
  group_by(city) %>%
  mutate(
    proportion = n / sum(n)
  )


ggplot(mcslc_hourly,
       aes(x = hour,
           y = proportion,
           color = city)) +
  geom_line(linewidth = 1.2) +
  geom_point() +
  scale_x_continuous(breaks = 0:23) +
  labs(
    title = "Pre-2025 Hourly MCSLC Call Distribution",
    x = "Hour of Day",
    y = "Proportion of Calls"
  ) +
  theme_minimal()
ggsave("pre25_mcslc.png", bg="white")

police_before <- bind_rows(
  epd_before %>% mutate(city = "Eugene"),
  spd_before %>% mutate(city = "Springfield")
)

police_hourly <- police_before %>%
  count(city, hour) %>%
  group_by(city) %>%
  mutate(
    proportion = n / sum(n)
  )

ggplot(police_hourly,
       aes(x = hour,
           y = proportion,
           color = city)) +
  geom_line(linewidth = 1.2) +
  geom_point() +
  scale_x_continuous(breaks = 0:23) +
  labs(
    title = "Pre-2025 Hourly Police Call Distribution",
    x = "Hour of Day",
    y = "Proportion of Calls"
  ) +
  theme_minimal()
ggsave("pre25_police.png", bg="white")

cahoots_before <- bind_rows(
  eug_cahoots %>% mutate(city = "Eugene"),
  spr_cahoots_before %>% mutate(city = "Springfield")
)

cahoots_hourly <- cahoots_before %>%
  count(city, hour) %>%
  group_by(city) %>%
  mutate(
    proportion = n / sum(n)
  )

ggplot(cahoots_hourly,
       aes(x = hour,
           y = proportion,
           color = city)) +
  geom_line(linewidth = 1.2) +
  scale_x_continuous(breaks = 0:23) +
  labs(
    title = "Pre-2025 Hourly CAHOOTS Call Distribution",
    x = "Hour of Day",
    y = "Proportion of Calls"
  ) +
  theme_minimal()
ggsave("pre25_cahoots.png", bg="white")



#Police department difference in differences
epd_hourly <- epd %>% mutate(date = as.Date(parsed_dispatch_time)
  ) %>%group_by(date, hour) %>%summarise(  call_volume = n(),.groups = "drop"
  ) %>%mutate(city = "Eugene")

spd_hourly <- spd %>%mutate(date = as.Date(parsed_dispatch_time)
  ) %>% group_by(date, hour) %>% summarise(  call_volume = n(),.groups = "drop"
  ) %>%mutate(city = "Springfield")

police_hourly <- bind_rows(epd_hourly,spd_hourly)
police_hourly <- police_hourly %>%mutate(
    treated = ifelse(city == "Eugene", 1, 0),
    post = ifelse( date >= as.Date("2025-04-07"),1,0),
    year = year(date))
police_hourly <- police_hourly %>% 
  left_join(population, by = c("city", "year")) %>% 
  mutate(calls_per_10k = (call_volume / population) * 10000 )

police_hourly_model <- lm(calls_per_10k ~ treated * post * factor(hour), data = police_hourly)

summary(police_hourly_model)
#ensure parallel trends
police_pre <- police_hourly %>%
  filter(date < as.Date("2025-04-07")) %>%
  mutate(
    time_num = as.numeric(date)
  )
parallel_police <- lm(
  calls_per_10k ~ treated * time_num + factor(hour),
  data = police_pre
)

summary(parallel_police)

#mcslc difference in differences
e_mcslc_hourly <- e_mcslc %>% mutate(date = as.Date(parsed_dispatch_time)) %>% 
  group_by(date, hour) %>% summarise(call_volume = n(),.groups = "drop" ) %>%
  mutate(city = "Eugene")
s_mcslc_hourly <- s_mcslc %>% mutate(date = as.Date(parsed_dispatch_time)) %>% 
  group_by(date, hour) %>% summarise(call_volume = n(),.groups = "drop" ) %>%
  mutate(city = "Springfield")

mcslc_hourly <- bind_rows(e_mcslc_hourly, s_mcslc_hourly)
mcslc_hourly <- mcslc_hourly %>%mutate(
    treated = ifelse(city == "Eugene", 1, 0),
    post = ifelse( date >= as.Date("2025-04-07"),1, 0),
    year = year(date))
mcslc_hourly <- mcslc_hourly %>% 
  left_join(population, by = c("city", "year")) %>% 
  mutate(calls_per_10k = (call_volume / population) * 10000)
mcslc_hourly_model <- lm(calls_per_10k ~ treated * post * factor(hour), data = mcslc_hourly)

summary(mcslc_hourly_model)

#ensure parallel trends
mcslc_pre <- mcslc_hourly %>%
  filter(date < as.Date("2025-04-07")) %>%
  mutate(
    time_num = as.numeric(date)
  )
parallel_mcslc <- lm(
  calls_per_10k ~ treated * time_num + factor(hour),
  data = mcslc_pre
)

summary(parallel_mcslc)
