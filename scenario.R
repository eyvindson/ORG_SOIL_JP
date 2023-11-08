# In this script, we combine the regular data with scenario data to complete a time series

rm(list=ls())

source("PATHS.R")

CONST_scenario_year <- 2050

# Let's start with basal areas

scen_ppa <- 
  FUNC_read_file(paste(PATH_input, "scen_ppa.csv", sep = "")) %>% 
  pivot_longer(cols = starts_with("X"),
               names_to = "year", 
               values_to = "basal_area") %>% 
  mutate(year = as.numeric(sub("X", "", year))) %>% 
  # Interpolation
  group_by(region, peat_type, tree_type) %>% 
  complete(year = min(year):2050) %>% 
  mutate(basal_area = na.approx(basal_area)) %>% 
  filter(year <= CONST_scenario_year)

complete_ppa <- 
  FUNC_read_file(PATH_basal_areas_by_treetype) %>% 
  filter(year < 2011) %>% 
  rbind(scen_ppa)

FUNC_save_output(complete_ppa, PATH_basal_areas_by_treetype)

complete_ppa_agg <-
  complete_ppa %>% 
  group_by(region, peat_type, year) %>% 
  summarize(basal_area = sum(basal_area))

FUNC_save_output(complete_ppa_agg, PATH_basal_area_data)

#Biomass

scen_bm <-
  FUNC_read_file(paste(PATH_input, "scen_bm.csv", sep = "")) %>% 
  pivot_longer(cols = "Rhtkg_2011":"Jatkg_2061", 
               names_sep = "_",
               names_to = c("peat_name", "year"),
               values_to = "bm") %>% 
  mutate(year = as.integer(year)) %>% 
  left_join(CONST_peat_lookup) %>% 
  select(-peat_name) %>% 
  group_by(region, peat_type, tree_type, component) %>% 
  complete(year = min(year):2050) %>% 
  mutate(bm = na.approx(bm)) %>% 
  filter(year <= CONST_scenario_year) %>% 
  mutate(region = if_else(region == "south", 1, 2)) %>% 
  left_join(CONST_species_lookup) %>% 
  ungroup() %>% 
  select(-tree_type) %>% 
  rename(species = laji, tkg = peat_type)
  
complete_bm <- 
  FUNC_read_file(PATH_interpolated_biomass) %>% 
  filter(year < 2011) %>% 
  rbind(scen_bm)

FUNC_save_output(complete_bm, PATH_interpolated_biomass)

# For weather data, repeat last known value

extended_weatherdata <-
  FUNC_read_file(PATH_weather_data_aggregated) %>% 
  group_by(region, peat_type) %>% 
  complete(year = 1990:CONST_scenario_year) %>% 
  fill(roll_T, .direction = "downup")

FUNC_save_output(extended_weatherdata, PATH_weather_data_aggregated)

extended_yasso_weatherdata <-
  FUNC_read_file(PATH_weather_logyasso) %>% 
  group_by(region) %>% 
  complete(year = 1960:CONST_scenario_year) %>% 
  fill(sum_P, mean_T, ampli_T, .direction = "downup")

FUNC_save_output(extended_yasso_weatherdata, PATH_weather_logyasso)

# Finally litter extensions

deadwood_litter <-
  FUNC_read_file(PATH_dead_litter) %>% 
  group_by(region) %>% 
  complete(year = 1990:CONST_scenario_year) %>% 
  fill(lognat_litter, .direction = "downup")

FUNC_save_output(deadwood_litter, PATH_dead_litter)

all_litter <-
  FUNC_read_file(PATH_ghgi_litter) %>% 
  group_by(region, soil, ground, litter_source, litter_type) %>% 
  complete(year = min(year):CONST_scenario_year) %>% 
  fill(A, W, E, N, .direction = "downup")

FUNC_save_output(all_litter, PATH_ghgi_litter)