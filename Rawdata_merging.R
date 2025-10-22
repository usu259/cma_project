library(sf)
library(dplyr)
library(tidyr)

library(FITfileR)

# 10k Race
race_10k <- readFitFile("Ascona_Locarno_10k.fit")
race_10k_allrecords <- records(race_10k) %>%
  bind_rows() %>%
  arrange(timestamp) %>%
  mutate(run_id = "Ascona_Locarno_10k", context = "race")
#Training Run 1
training_run1 <- readFitFile("Corsa_serale_0209.fit")
training_run1_allrecords <- records(training_run1) %>%
  bind_rows()%>%
  arrange(timestamp) %>%
  mutate(run_id = "Run_1", context = "training")

#Training Run 2

training_run2 <- readFitFile("Corsa_serale_1109.fit")
training_run2_allrecords <- records(training_run2) %>%
  bind_rows()%>%
  arrange(timestamp) %>%
  mutate(run_id = "Run_2", context = "training")
#Training Run 3
training_run3 <- readFitFile("Corsa_pomeridiana_1609.fit")
training_run3_allrecords <- records(training_run3) %>%
  bind_rows()%>%
  arrange(timestamp)%>%
  mutate(run_id = "Run_3", context = "training")
#Training Run 4
training_run4 <- readFitFile("Corsa_pomeridiana_2509.fit")
training_run4_allrecords <- records(training_run4) %>%
  bind_rows()%>%
  arrange(timestamp) %>%
  mutate(run_id = "Run_4", context = "training")
#Training Run 5
training_run5 <- readFitFile("Corsa_pomeridiana_3009.fit")
training_run5_allrecords <- records(training_run5) %>%
  bind_rows()%>%
  arrange(timestamp) %>%
  mutate(run_id = "Run_5", context = "training")


#Merging all dataset

all_data <- bind_rows(race_10k_allrecords,
                      training_run1_allrecords,
                      training_run2_allrecords,
                      training_run3_allrecords,
                      training_run4_allrecords,
                      training_run5_allrecords)
#Export of dataset
write.csv(all_data, "My_runs.csv", row.names = FALSE)




  

