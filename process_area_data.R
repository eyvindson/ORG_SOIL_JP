# Process area data 
# 
# This script reads area data from the inventory, transforms and aggregates the needed values for this calculation. 
# It extracts the total peatland area by peatland forest type and calculates their proportions

rm(list=ls())

source("PATHS.R")
# Process area data
# Load area data, convert to "long"

tkg_alat.maku <- read.csv("C:/Users/03180980/Orgcalc_regional/Input/tkg_alat-maku.csv")

#areas_long <- FUNC_longify(all_areas, value_name = "area")

# Lookup table for regions for converting NFI areas to South/North Finland 1,2 = south, 3,4, = north
# regsum <- data.frame(region = c(1,2,3,4),
#                      mainreg = rep(c(1, 2), each = 2))

# Filter and aggregate the data
# areas_aggregated <-
#   areas_long %>%
#   filter(soil == 2, tkang %in% c(1:7)) %>%
#   # Combine forest peatland types 2&3 and 4&4
#   mutate(tkang = ifelse(tkang == 3, 2, tkang),
#          tkang = ifelse(tkang == 5, 4, tkang),
#          region = ifelse(region == 1, "south", "north")) %>%
#   group_by(region, tkang, year) %>%
#   summarize(drained_peatland_area = sum(area)) %>%
#   rename(peat_type = tkang) %>%
#   filter(!is.na(peat_type))

areas_aggregated <-
  tkg_alat.maku %>% 
  filter(fra12 == 1) %>% 
  mutate(tkg = ifelse(tkg == 3, 2, tkg),
         tkg = ifelse(tkg == 5, 4, tkg)) %>% 
  group_by(maku, tkg) %>% 
  summarize(drained_peatland_area = sum(totala) * 100) %>% 
  ungroup() %>% 
  group_by(maku) %>% 
  complete(tkg = c(1,2,4,6,7)) %>% 
  mutate(drained_peatland_area = ifelse(is.na(drained_peatland_area), 0, drained_peatland_area)) %>% 
  rename(maakunta = maku) %>% 
  group_by(maakunta, tkg) %>% 
  mutate(year = 2015) %>% 
  complete(year = 2015:2021) %>% 
  rename(peat_type = tkg) %>% 
  fill(drained_peatland_area, .direction = "updown")
  
# Save the result
FUNC_save_output(areas_aggregated, PATH_total_area)

# Calculate proportional peatland areas and save
peatland_propoprtional_areas <-
  areas_aggregated %>% 
  group_by(maakunta, year) %>% 
  mutate(proportional_area = drained_peatland_area / sum(drained_peatland_area))

FUNC_save_output(peatland_propoprtional_areas, PATH_peatland_proportional_area)

