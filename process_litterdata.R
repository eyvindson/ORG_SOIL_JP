# Process litter data
# 
# This script calculates living tree litter production based on interpolated biomass proportions.
# It also fetches litter production values from logging and natural mortality from the GHGI


rm(list=ls())

source("PATHS.R")

# Process area data

ghg_path = PATH_ghgi_all_litter

# List all the GHGI files containing the pertinent data
litter_file_list <- list.files(ghg_path, 
                               pattern = "*csv")

listfill <- data.frame()

# These are just for unifying GHGI style nomenclature and markup with the peat stuff 
mort_lookup <- data.frame(mort = c("log", "nat"),
                          litter_source = c("logging", "natmort"))

litt_lookup <- data.frame(litt = c("cwl", "fwl", "nwl"),
                          litter_type = c("coarse_woody_litter", "fine_woody_litter", "non-woody_litter"))

region_lookup <- data.frame(reg = c("SF", "NF"),
                            region = c("south", "north"))

region2_lookup <- data.frame(reg = c("sf", "nf"),
                             region = c("south", "north"))

ground_lookup <- data.frame(gnd = c("abv", "bel"),
                            ground = c("above", "below"))

# Use file names for classification then read the contents to a table iteratively

for (i in 1:length(litter_file_list)) {
  
  item_to_read <- paste(ghg_path, litter_file_list[i], sep ="")
  read_item <- read.table(item_to_read, sep = ",", header = TRUE, col.names = c("A", "W", "E", "N"))
  categories <- unlist(x = strsplit(litter_file_list[i], split = ".", fixed = TRUE))
  
  read_item$mort <- categories[1]
  read_item$litt <- categories[2]
  read_item$reg <- categories[3]
  read_item$soil <- categories[4]
  read_item$gnd <- categories[5]
  
  # Because no year data are provided, we have to assume that the last row represents the current inventory year
  read_item <- mutate(read_item, year = (CONST_inventory_year + 1) - rev(row_number()))
  
  listfill <- rbind(listfill, read_item)  
}

# Tidying up and combining everything into a neat package
ghgi_litter <-
  listfill %>% 
  left_join(mort_lookup) %>% 
  left_join(litt_lookup) %>% 
  left_join(region_lookup) %>% 
  left_join(ground_lookup) %>% 
  select(region, soil, ground, litter_source, litter_type, year, A, W, E, N)
# Here we save the litter inputs for YASSO calculations

FUNC_save_output(ghgi_litter, PATH_ghgi_litter)

# ## Here we calculate living tree litter based on biomass fractions
# # 
# BM_interp_long <- FUNC_read_file(PATH_interpolated_biomass)
# LOOKUP_litter_conversion <- read.table(PATH_lookup_litter, header = TRUE)
# maakunnat <- FUNC_read_file(PATH_lookup_maku)
# 
# #### TABLE OF BIOMASS #####
# 
# bm_conv <- LOOKUP_litter_conversion[1:7, 3:4]
# 
# bm_conv <- data.frame(component = 1:7,
#                       bmtype = c("Stemwood",
#                                  "Bark",
#                                  "Live branches",
#                                  "Foliage",
#                                  "Dead brances",
#                                  "Stumps",
#                                  "Roots"))
# 
# # Calculate litter production from biomass fractions
# 
# litter_types <-
#   BM_interp_long %>%
#   # Leave out total biomasses (categories 8 & 9)
#   filter(component < 8) %>%
#   left_join(maakunnat %>% select(-maakunta_nimi)) %>%   
#   left_join(LOOKUP_litter_conversion) %>%
#   # Calculate litter production from biomass, convert to C
#   mutate(litter = bm * bm_turnover_constant * CONST_biomass_to_C) %>%
#   select(-bm, -bm_turnover_constant, -bmtype) 
# 
# living_tree_litter <-
#   litter_types %>%
#   # Leaving out dead branches in order to avoid double counting
#   filter(component != 5) %>%
#   # # Leave out spruce bark
#   filter(!(component == 2 & species == 2)) %>%
#   # divide into above and below ground litter
#   mutate(ground = ifelse(component == 7, "below", "above")) %>%
#   group_by(maakunta, year, tkg, litter_type, ground) %>%
#   summarize(living_tree_litter = sum(litter)) %>%
#   # designate these as living
#   mutate(litter_source = "living") %>%
#   rename(peat_type = tkg)
# 
# FUNC_save_output(living_tree_litter, PATH_living_tree_litter)

#####################################################################################

# Calculate the litter production from logging and natural mortality, data from ghgi

lognat_litter <- 
  ghgi_litter %>% 
  # Filter out prior to 1990 and mineral grounds
  filter(year > 1989, soil == "org", !is.na(ground)) %>% 
  mutate(litter = A + W + E + N) %>% 
  select(region, year, litter_type, ground, litter, litter_source) %>%  
  group_by(region, year) %>% 
  summarize(lognat_litter = sum(litter))

FUNC_save_output(lognat_litter, PATH_dead_litter)
