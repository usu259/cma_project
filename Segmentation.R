library(readr)
library(tidyr)
library(sf)
library(dplyr)
library(tmap)
library(ggplot2)
race <- st_read("race.gpkg")


#Functions
distance_by_element <- function(later, now) {
  as.numeric(
    st_distance(later, now, by_element = TRUE)
  )
}

# Temporal window: 60 s

race <- race %>% 
  mutate(dis_60s_forward = distance_by_element(lead(geom, 60),geom),
         dis_60s_backward = distance_by_element(geom, lag(geom,60)))

#Temporal window: 30s

race <- race %>% 
  mutate(dis_30s_forward = distance_by_element(lead(geom, 30),geom),
         dis_30s_backward = distance_by_element(geom, lag(geom,30)))


race <- race %>%
  rowwise() %>%
  mutate(stepMean = mean(c(dis_60s_forward,dis_60s_backward,dis_30s_forward,dis_30s_backward))) %>%
  ungroup()

#Treshold statis (slower segments)

summary(race$stepMean)

threshold = 120.68 # 1st quart

race <- race %>%
  mutate(slow = stepMean < threshold)

#filtering where slow = TRUE or NA

race_filtred <- race %>%
  filter(!slow)

##extracting coordinates for ggplot

race_xy <- race %>%
  mutate(.row = row_number()) %>%
  cbind(st_coordinates(race))

#Visualizing

race_xy %>%
  ggplot(aes(X,Y, colour = slow))+
  geom_path()+
  geom_point()+
  coord_equal()


