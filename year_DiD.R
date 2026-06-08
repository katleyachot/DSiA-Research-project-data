epd <- read.csv("~/Documents/DSiA/clean_epd.csv")
spd <- read.csv("~/Documents/DSiA/clean_spd.csv")
cahoots_eug <- read.csv("~/Documents/DSiA/clean_cahoots.csv")
cahoots_spr <- read.csv("~/Documents/DSiA/clean_spr_cahoots.csv")
mcslc_eug <- read.csv("~/Documents/DSiA/clean_eug_mcslc.csv")
mcslc_spr <- read.csv("~/Documents/DSiA/clean_spr_mcslc.csv")
library(dplyr)
library(lubridate)
library(ggplot2)
options(ggplot2.discrete.colour= c("#de4433", "#5e33de"))


epd$time <- ymd_hms(epd$calltime)
spd$time <- ymd_hms(spd$Call.Creation.Time)

epd_daily <- epd %>%
  mutate(date = as.Date(time)) %>%
  group_by(date) %>%
  summarise(call_volume = n()) %>%
  mutate(city = "Eugene")

spd_daily <- spd %>%
  mutate(date = as.Date(time)) %>%
  group_by(date) %>%
  summarise(call_volume = n()) %>%
  mutate(city = "Springfield")

daily_calls <- bind_rows(epd_daily, spd_daily)

daily_calls <- daily_calls %>%
  mutate(
    treated = ifelse(city == "Eugene", 1, 0),
    post = ifelse(date >= as.Date("2025-04-07"), 1, 0),
    did = treated * post
  )
daily_calls <- daily_calls %>%
  mutate(year = year(date))
#normalize using population of springfield and eugene
daily_calls <- daily_calls %>%
  left_join(population,
            by = c("city", "year"))
daily_calls <- daily_calls %>%
  mutate(calls_per_10k =(call_volume / population) * 10000)

model <- lm(calls_per_10k ~ treated * post, data = daily_calls)
summary(model)

#ensure parallel trends 
police_pre <- daily_calls %>%
  filter(date < as.Date("2025-04-07")) %>%
  mutate(
    time_num = as.numeric(date)
  )

police_parallel <- lm(
  calls_per_10k ~ treated * time_num,
  data = police_pre
)

summary(police_parallel)

ggplot(daily_calls,
       aes(x = date,
           y = calls_per_10k,
           color = city)) +
  geom_line(alpha = 0.25) +
  geom_smooth(method = "loess", span = 0.15, se = FALSE, linewidth = 1.2) +
  geom_vline(
    xintercept = as.Date("2025-04-07"),
    linetype = "dashed"
  ) +
  labs(
    title = "Police Calls Per 10,000 Residents",
    x = "Date",
    y = "Daily calls per 10,000 Residents"
  ) +
  theme_minimal()+
  theme(
    panel.background = element_rect(fill = "white",color = NA),
    plot.background = element_rect(fill = "white",color = NA),
    panel.border = element_blank(),
    axis.text = element_text(color = "black"),
    axis.title = element_text(color = "black"),
    panel.grid = element_line(color = "grey85"),
    plot.title = element_text(margin = margin(t = 15, b = 5), size = 18)
  )
ggsave("police_year.png")

#do the same for cahoots
cahoots_eug$time <- ymd_hms(cahoots_eug$calltime)
cahoots_spr$time <- ymd_hms(cahoots_spr$Call.Creation.Time)

cahoots_eug_daily <- cahoots_eug %>%
  mutate(date = as.Date(time)) %>%
  group_by(date) %>%
  summarise(call_volume = n()) %>%
  mutate(city = "Eugene")

cahoots_spr_daily <- cahoots_spr %>%
  mutate(date = as.Date(time)) %>%
  group_by(date) %>%
  summarise(call_volume = n()) %>%
  mutate(city = "Springfield")

cahoots_daily_calls <- bind_rows(cahoots_eug_daily, cahoots_spr_daily)

cahoots_daily_calls <- cahoots_daily_calls %>%
  mutate(
    treated = ifelse(city == "Eugene", 1, 0),
    post = ifelse(date >= as.Date("2025-04-07"), 1, 0),
    did = treated * post
  )
cahoots_daily_calls <- cahoots_daily_calls %>%
  mutate(year = year(date))

cahoots_daily_calls <- cahoots_daily_calls %>%
  left_join(population,
            by = c("city", "year"))
cahoots_daily_calls <- cahoots_daily_calls %>%
  mutate(
    calls_per_10k =
      (call_volume / population) * 10000
  )
cahoots_model <- lm(
  calls_per_10k ~ treated * post,
  data = cahoots_daily_calls
)

summary(cahoots_model)

#ensure parallel trends
cahoots_pre <- cahoots_daily_calls %>%
  filter(date < as.Date("2025-04-07")) %>%
  mutate(
    time_num = as.numeric(date)
  )

cahoots_parallel <- lm(
  calls_per_10k ~ treated * time_num,
  data = cahoots_pre
)

summary(cahoots_parallel)

ggplot(cahoots_daily_calls,
       aes(x = date,
           y = calls_per_10k,
           color = city)) +
  geom_line(alpha = 0.2) +
  geom_smooth(method = "loess", span = 0.15, se = FALSE, linewidth = 1.2) +
  geom_vline(
    xintercept = as.Date("2025-04-07"),
    linetype = "dashed"
  ) +
  labs(
    title = "CAHOOTS Calls Per 10,000 Residents",
    x = "Date",
    y = "Daily calls per 10,000 Residents"
  ) +
  theme_minimal()+
  theme(
    panel.background = element_rect(fill = "white",color = NA),
    plot.background = element_rect(fill = "white",color = NA),
    panel.border = element_blank(),
    axis.text = element_text(color = "black", size=11),
    axis.title = element_text(color = "black"),
    panel.grid = element_line(color = "grey85"),
    plot.title = element_text(margin = margin(t = 15, b = 5), size = 18),
  )
ggsave("cahoots_year.png")
#same for mcslc
mcslc_eug$time <- ymd_hms(mcslc_eug$`Dispatch.Request.Date...Time`)
mcslc_spr$time <- ymd_hms(mcslc_spr$`Dispatch.Request.Date...Time`)

mcslc_eug_daily <- mcslc_eug %>%
  mutate(date = as.Date(time)) %>%
  group_by(date) %>%
  summarise(call_volume = n()) %>%
  mutate(city = "Eugene")

mcslc_spr_daily <- mcslc_spr %>%
  mutate(date = as.Date(time)) %>%
  group_by(date) %>%
  summarise(call_volume = n()) %>%
  mutate(city = "Springfield")

mcslc_daily_calls <- bind_rows(mcslc_eug_daily, mcslc_spr_daily)

mcslc_daily_calls <- mcslc_daily_calls %>%
  mutate(
    treated = ifelse(city == "Eugene", 1, 0),
    post = ifelse(date >= as.Date("2025-04-07"), 1, 0),
    did = treated * post
  )
mcslc_daily_calls <- mcslc_daily_calls %>%
  mutate(year = year(date))

mcslc_daily_calls <- mcslc_daily_calls %>%
  left_join(population,
            by = c("city", "year"))
mcslc_daily_calls <- mcslc_daily_calls %>%
  mutate(
    calls_per_10k =
      (call_volume / population) * 10000
  )
mcslc_model <- lm(
  calls_per_10k ~ treated * post,
  data = mcslc_daily_calls
)

summary(mcslc_model)

#ensure parallel trends
mcslc_pre <- mcslc_daily_calls %>%
  filter(date < as.Date("2025-04-07")) %>%
  mutate(
    time_num = as.numeric(date)
  )

mcslc_parallel <- lm(
  calls_per_10k ~ treated * time_num,
  data = mcslc_pre
)

summary(mcslc_parallel)

ggplot(mcslc_daily_calls,
       aes(x = date,
           y = calls_per_10k,
           color = city)) +
  geom_line(alpha = 0.2) +
  geom_smooth(method = "loess", span = 0.15, se = FALSE, linewidth = 1.2) +
  geom_vline(
    xintercept = as.Date("2025-04-07"),
    linetype = "dashed"
  ) +
  labs(
    title = "MCSLC Calls Per 10,000 Residents",
    x = "Date",
    y = "Daily calls per 10,000 Residents"
  ) +
  theme_minimal()+
  theme(
    panel.background = element_rect(fill = "white",color = NA),
    plot.background = element_rect(fill = "white",color = NA),
    panel.border = element_blank(),
    axis.text = element_text(color = "black", size=11),
    axis.title = element_text(color = "black"),
    panel.grid = element_line(color = "grey85"),
    plot.title = element_text(margin = margin(t = 15, b = 5), size = 18)
  )
ggsave("mcslc_year.png",  bg = "white",
       dpi = 300)

