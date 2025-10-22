library(sf)
library(readr)
library(ggplot2)
library(tmap)
library(dplyr)

runs <- read_delim("My_runs.csv",delim = ",")

runs <- st_as_sf(runs, coords = c("position_long","position_lat"), crs = 4326) %>%
  st_transform(2056) %>%
  mutate(run_id = ifelse(run_id == "Run_04", "Run_4", run_id))
  
Race <- runs %>% 
  filter(run_id == "Ascona_Locarno_10k")

write.csv(Race, "race.csv", row.names = FALSE)

Race_line <- Race %>%
  summarise(do_union = FALSE) %>%
  st_cast("LINESTRING")

run_1 <- runs %>%
  filter(run_id == "Run_1")

write.csv(run_1, "run_1.csv", row.names = FALSE)

run_1_line <- run_1 %>%
  summarise(do_union = FALSE) %>%
  st_cast("LINESTRING")

run_2 <- runs %>%
  filter(run_id == "Run_2")

write.csv(run_2, "run_2.csv", row.names = FALSE)

run_2_line <- run_2 %>%
  summarise(do_union = FALSE) %>%
  st_cast("LINESTRING")

run_3 <- runs %>%
  filter(run_id == "Run_3")

write.csv(run_3, "run_3.csv", row.names = FALSE)

run_3_line <- run_3 %>%
  summarise(do_union = FALSE) %>%
  st_cast("LINESTRING")

run_4 <- runs %>%
  filter(run_id == "Run_4")

write.csv(run_4, "run_4.csv", row.names = FALSE)

run_4_line <- run_4 %>%
  summarise(do_union = FALSE) %>%
  st_cast("LINESTRING")

run_5 <- runs %>%
  filter(run_id == "Run_5")

write.csv(run_5, "run_5.csv", row.names = FALSE)

run_5_line <- run_5 %>%
  summarise(do_union = FALSE) %>%
  st_cast("LINESTRING")


tmap_mode("view")
tmap_options(basemaps = "OpenStreetMap")

tm_shape(run_1_line)+
  tm_lines() +
  tm_dots()

