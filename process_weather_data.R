# This script aggregates and calculates weather data used for peat decomposition and yasso07 calculations
# 
# For input data, it uses 1x1 km grid interpolated weather data from 1960- 
#

rm(list=ls())

source("PATHS.R")
source("FUNCTIONS.R")

weather_data <- read.csv2(PATH_weather_data, dec = ".", sep = " ") # Full weather data
NFI12_coordinates <- FUNC_read_file(PATH_NFI12_coordinates) # Locations of NFI12 sampling plots
NFI12_plots <- FUNC_read_file(PATH_NFI12_plots) # More detailed data of all NFI12 sampling plots
maakunnat <- FUNC_read_file("Lookup/maakunnat.txt")

# Properly format dates, add separate columns for "year" and "month"
weather_data$date_start <- as.Date(weather_data$date_start, "%Y-%m-%d")
weather_data$year <- as.numeric(format(weather_data$date_start,'%Y'))
weather_data$month <- as.numeric(format(weather_data$date_start,'%m'))

full_weatherdata <- 
  weather_data %>% 
  # Create a unique identifier for each grid point
  mutate(gridpoint = paste(x, y, sep = "-")) %>% 
  # We only want gridpoints that have an NFI sampling plot close to them
  filter(gridpoint %in% unique(NFI12_coordinates$gridpoint)) %>% 
  select(year, month, gridpoint, temp_avg, prec) %>% 
  # in case the data extends further
  filter(year < CONST_inventory_year + 1)

# Coordinates for sampling plots of the 12th National Forest Inventory
NFI_coords <- 
  NFI12_coordinates %>% 
  filter(fra == 1) %>% 
  left_join(maakunnat) %>% 
  select(lohko, koeala, gridpoint, maakunta, region) 

NFI_weather <-
  NFI12_plots %>% 
  filter(forest == 1, drpeat == 1) %>% 
  select(lohko = cluster, koeala = plot, area, peat_type, weight = area) %>% 
  left_join(NFI_coords) %>% 
  left_join(full_weatherdata) %>% 
  filter(month %in% c(5:10)) %>% 
  group_by(maakunta, peat_type, year) %>% 
  # Due to different sampling regimes in different NFI areas, weighted mean has to be used
  summarize(avg_T = weighted.mean(temp_avg, weight)) %>% 
  mutate(roll_T = rollmean(avg_T, 30, align="right", fill=NA)) %>% 
  filter(year > 1989)  %>%  
  select(-avg_T) 

# Figure
ggplot(NFI_weather, aes(x = year, y = roll_T)) + 
  geom_point() +
  geom_path() +
  facet_grid(peat_type~maakunta, scales = "free_y")
  
# Save results

FUNC_save_output(NFI_weather, PATH_weather_data_aggregated)

########################
#                      #
### YASSO WEATHER ######
#                      #        
########################
# For YASSO07, we need precipitation and temperature amplitude values

# First we calculate annual average weather parameters for each gridpoint in the data
mean_weather_by_gridpoint <-
  full_weatherdata %>%
  group_by(year, gridpoint) %>%
  summarise(sum_P = sum(prec),
            avg_T = mean(temp_avg),
            ampli_T = (max(temp_avg) - min(temp_avg)) /2) 

# Then we find the locations of NFI12 sampling plots and find the nearest weather gridpoints
mean_weather_by_NFI12plot <-
  NFI12_coordinates %>% 
  left_join(mean_weather_by_gridpoint) %>% 
  select(lohko, koeala, gridpoint, year, sum_P, avg_T, ampli_T) %>% 
  group_by(lohko, koeala, year) %>% 
  summarize(sum_P = mean(sum_P),
            avg_T = mean(avg_T),
            ampli_T = mean(ampli_T)) 

# Here we calculate the final weather data to be used in YASSO07 calculations
yasso_weather <-
  NFI12_plots %>%
  # We only want forest plots with drained peatland
  filter(forest == 1, drpeat == 1) %>%
  select(region, cluster, plot, area, peat_type) %>%
  rename(lohko = cluster,
         koeala = plot) %>%
  # Assign subregions 1&2 = 1, 3&4 = 2
  mutate(mainregion = if_else(region %in% c(1:2), 1, 2)) %>%
  group_by(mainregion, peat_type) %>%
  # We need the area data for weighted averages
  mutate(totarea = sum(area)) %>%
  ungroup() %>%
  left_join(mean_weather_by_NFI12plot) %>%
  mutate(mainregion = if_else(region %in% c(1,2), "south", "north")) %>% 
  group_by(mainregion, year) %>%
  summarize(sum_P = weighted.mean(sum_P, w = totarea),
            mean_T = weighted.mean(avg_T, w = totarea),
            ampli_T = weighted.mean(ampli_T, w = totarea)) %>%
  rename(region = mainregion) %>%
  ungroup() 

FUNC_save_output(yasso_weather, PATH_weather_logyasso)

