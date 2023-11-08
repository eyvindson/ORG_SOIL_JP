# Please read the README_FIRST.txt

rm(list=ls())

source("PATHS.R")

# Update weather data first. 

# Input data preparation
if(!file.exists(PATH_weather_data_aggregated)) {
  source(PATH_script_weather) # leave this out if new weather data is not needed
}  
source(PATH_script_area) # read and process area data 
source(PATH_script_ba_bm_interpolation) # Interpolate biomass and basal areas
source(PATH_script_process_litter) # process litter data, both for living tree litter, as well as logging & natural mortality


source(PATH_script_yasso) # YASSO decomposition of natural and logging mortality

## Here starts the actual main calculation ## 

# Calculate peat decomposition
source(PATH_script_peat_decomposition)
# Calculate above and below ground litter from living trees, fine roots and shrub
source(PATH_script_total_litter)
# Calculate the final emissions based on emission factors and area data
source(PATH_script_total_emission)
