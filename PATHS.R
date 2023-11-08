# Denote all parameters with the prefix PARAM for easier reading

### SCENARIO EDITION ######

# Lets daisy chain these here since all files call this file
source("LIBRARIES.R")
source("FUNCTIONS.R")
source("CONSTANTS.R")

# Define all paths here. Make sure to include / in the end of directory paths

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# This path should point to the root folder of the whole project, where main.R is located.#
# Rest of the paths are generated automatically. Include / in the end of the path!                                         #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

PATH_main = "C:/Users/03180980/Orgcalc_regional/"

CONST_inventory_year <- 2021 # This needs to match the folder year
# This is the path to the root folder of the inventory calculations in Sorvi
# This changes depending whether scripts are run on your personal machine vs. Sorvi

if(Sys.info()["sysname"] != "Linux") {
  PATH_ghgi = "Z:/d4/projects/khk/ghg/" # this assumes you have mounted the Sorvi fileystem under Z:  
} else {
  PATH_ghgi = "/data/d4/projects/khk/ghg/" # absolute path on Sorvi
}

# General parameters go here
pre_reporting = FALSE
PARAM_draw_plots = TRUE # Set to true to enable drawing of various plots that will be stored under /Plots  

###########################################################################################
########   There should be no need to touch anything beyond this point   ##################
###########################################################################################  

# Main folders

PATH_ghgi_currentyear = paste(PATH_ghgi, CONST_inventory_year, "/", sep ="")
PATH_organic_rem_currentyear = paste(PATH_ghgi_currentyear, "soil/organic/remaining/", sep ="")

PATH_input =  paste(PATH_main, "Input/", sep = "")
PATH_midresults = paste(PATH_main, "Midresults/", sep = "")
PATH_results = paste(PATH_organic_rem_currentyear, "results/", sep = "")
PATH_figures =  paste(PATH_organic_rem_currentyear, "figs/", sep = "")
PATH_lookup =  paste(PATH_main, "Lookup/", sep = "")
PATH_logs = paste(PATH_main, "Logs/", sep = "")


# Lookups. These are tables that are used in converting and aggregating things.
PATH_lookup_litter = paste(PATH_lookup, "litter_conversion.csv", sep = "") # for converting biomass fractions into litter fractions
PATH_lookup_maku = paste(PATH_lookup, "maakunnat.txt", sep = "") 


# Script files

PATH_script_weather = paste(PATH_main, "process_weather_data.R", sep = "")
PATH_script_ba_bm_interpolation = paste(PATH_main, "process_BM_and_BA.R", sep = "")
PATH_script_yasso = paste(PATH_main, "process_lognat_yasso.R", sep = "")
PATH_script_area = paste(PATH_main, "process_area_data.R", sep = "")
PATH_script_process_litter = paste(PATH_main, "process_litterdata.R", sep = "")
PATH_script_biomass_to_litter = paste(PATH_main, "biomass_to_litter.R", sep = "")
PATH_script_peat_decomposition = paste(PATH_main, "peat_decomp.R", sep = "") 
PATH_script_total_litter = paste(PATH_main, "total_litter.R", sep = "")
PATH_script_total_emission = paste(PATH_main, "total_emission.R", sep = "") 
PATH_script_scenario = paste(PATH_main, "scenario.R", sep = "") 

# Main input files

PATH_weather_data = paste(PATH_input, "Weather/WeatherData_1960_", CONST_inventory_year, ".csv",  sep = "") # Data file containing the raw weather data
PATH_ba_bm_raw_data = paste(PATH_input, "basal_areas_and_biomass_maku.csv", sep = "") # Raw
PATH_ghgi_area =  paste(PATH_ghgi_currentyear, "areas/lulucf/results/lulucf_rem_kptyy_tkang_ojlk.txt", sep = "")
PATH_basal_area_data = paste(PATH_midresults, "basal_areas.csv", sep = "") # basal area data file
PATH_basal_areas_by_treetype = paste(PATH_midresults, "basal_areas_by_treetype.csv", sep = "") # basal area data file 
PATH_area_script = paste(PATH_main, "process_area_data.R", sep = "") # main file

PATH_ghgi_all_litter = paste(PATH_ghgi_currentyear, "trees/drain/remaining/litter/lulucf/", sep ="")

# GHGI paths

PATH_crf = paste(PATH_ghgi_currentyear, "crf/", sep = "") # main CRF results 

# Midresults / intermediary results

PATH_interpolated_biomass = paste(PATH_midresults, "biomass_interpolated.csv", sep = "")
PATH_living_tree_litter = paste(PATH_midresults, "living_tree_litter.csv", sep = "") # litter from living living trees from GHGI
PATH_living_litter = paste(PATH_midresults, "living_litter.csv", sep = "") # soil litter biomasses
PATH_dead_litter = paste(PATH_midresults, "dead_litter.csv", sep = "") # soil litter biomasses  
PATH_lognat_decomp = paste(PATH_midresults, "lognat_decomp.csv", sep = "") # soil litter biomasses  
PATH_weather_data_aggregated = paste(PATH_midresults, "aggregated_weather_data.csv", sep = "" ) # Aggregated weather data saved here
PATH_weather_logyasso =  paste(PATH_midresults, "logyasso_weather_data.csv",  sep = "") # Weather data for yasso calculations
PATH_ghgi_litter = paste(PATH_midresults, "ghgi_litter.csv", sep = "")
PATH_total_area = paste(PATH_midresults, "total_area.csv", sep = "")
PATH_peatland_proportional_area = paste(PATH_midresults, "peatland_proportional_area.csv", sep = "") # proportional areas of different peatland types

# Results

PATH_peat_decomposition = paste(PATH_results, "peat_decomposition.csv", sep = "" )
PATH_ef_emission_factor = paste(PATH_results, "emission_factor.csv", sep = "" )
PATH_total_soil_carbon = paste(PATH_results, "soil_carbon_balance_total.csv", sep = "")

# NFI data

PATH_NFI12_plots = paste(PATH_lookup, "NFI12_plots.csv",  sep = "") # plot level NFI12 data 
PATH_NFI12_coordinates = paste(PATH_lookup, "NFI12_coordinates_maku.csv",  sep = "") # NFI12 plot coordinates

# How many years into the future after the last known value

CONST_forward_years = CONST_inventory_year - 2020
