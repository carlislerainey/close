
# load packages
library(tidyverse)
library(ggrepel)

# load data
raw_data <- read_csv("data/1976-2016-president.csv") %>%
  glimpse()

# wrangle data a bit
data <- raw_data %>%
  # keep only presidential returns
  filter(office == "US President") %>% 
  # keep only "major" candidates
  filter(candidatevotes/totalvotes > 0.01) %>%
  select(year, state, party, candidatevotes) %>%
  filter(party %in% c("democrat", "republican")) %>%
  pivot_wider(names_from = party, values_from = candidatevotes) %>%
  mutate(two_party_votes = democrat + republican,
         votes_margin = abs(democrat - republican)) %>%
  select(year, state, votes_margin) %>%
  write_rds("data/votes-margin.rds") %>%
  write_csv("data/votes-margin.csv") %>%
  glimpse()




