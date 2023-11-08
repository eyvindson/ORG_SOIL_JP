# Total emission / Soil CO2 balance
#
# This script calculates the final emission factors and soil CO2 balance.
rm(list=ls())

source("PATHS.R")

# Here we load in the various data sources used in calculating the total EF
peat_decomposition <- FUNC_read_file(PATH_peat_decomposition) # peat degradation
total_living_litter <- FUNC_read_file(PATH_living_litter) # Total litter
lognat_litter <- FUNC_read_file(PATH_dead_litter) %>% mutate(region = if_else(region == "south", 1, 2)) # litter from logging and natural mortality
lognat_decomp <- FUNC_read_file(PATH_lognat_decomp)  %>% mutate(region = if_else(region == "south", 1, 2))# decomposition of logging and natural litter, from Yasso07 modelling
total_area <- FUNC_read_file(PATH_total_area) # area data
maakunnat <- FUNC_read_file(PATH_lookup_maku)
# Calculate the emission factor per peatland type by summing up total litter production and
# subtracting peat degradation from the total. Unit ton C / ha

emission_factor <-
  total_living_litter %>% 
  left_join(peat_decomposition) %>% 
  left_join(maakunnat) %>% 
  left_join(lognat_litter) %>% 
  left_join(lognat_decomp) %>% 
  mutate(EF_drained_peatland = (total_living_litter + lognat_litter) + (peat_deg - lognat_decomp)) %>%  
  #mutate(EF_drained_peatland = (total_living_litter + (lognat_litter * rnorm(1,1,0.25)) ) + (peat_deg - (lognat_decomp * rnorm(1,1,0.25)))) %>% 
  replace(is.na(.), 0) %>% 
  select(maakunta, peat_type, year, EF_drained_peatland) 

# Save EF output
FUNC_save_output(emission_factor, PATH_ef_emission_factor)

if(PARAM_draw_plots) {
  
  fig <- ggplot(data=emission_factor, aes(x = peat_type, y = EF_drained_peatland)) +
    geom_bar(position="dodge", stat="identity") +
    ylab("tons of C / ha / y") +
    xlab("") +
    labs(title = "Mean emission factors per peatland type") + 
    facet_wrap(~maakunta) 
  ggsave(fig, filename = file.path(PATH_figures, "emission_factor.png"), dpi = 120)
  
  time_fig <- ggplot(data=emission_factor, aes(x = year, y = EF_drained_peatland, col = as.factor(peat_type))) +
    geom_point() +
    geom_path() +
    ylab("tons of C / ha / y") +
    #ylim(0, NA) +
    facet_grid(~maakunta) +
    theme_bw()
  ggsave(time_fig, filename = file.path(PATH_figures, "emission_factor_timeseries.png"), dpi = 120)
  
}
 
# Calculate final emission
total_emission <-
  emission_factor %>% 
  left_join(total_area) %>% 
  # Calculate total emission, convert to kilotons
  mutate(total_ktC = (drained_peatland_area * EF_drained_peatland) / 1000) %>% 
  group_by(year, maakunta) %>% 
  summarize(total_ktC = sum(total_ktC))

FUNC_save_output(total_emission, PATH_total_soil_carbon)

ggplot(total_emission, aes(x = year, y = total_ktC)) + 
  geom_point() +
  geom_path() +
  facet_grid(~maakunta, scales = "free_y")

area_sum <-
  total_area %>% 
  group_by(year) %>% 
  summarize(tot_area = sum(drained_peatland_area))

total_maku <-
  total_emission %>%
  #filter(maakunta != 21) %>% 
  group_by(year) %>% 
  summarize(total_ktC = sum(total_ktC)) %>% 
  mutate(laskenta = "maku yht") %>% 
  rbind(
    read.csv("C:/Users/03180980/orgsoil_portable/Results/soil_carbon_balance_total.csv", sep=";") %>% 
      filter(year %in% 2015:2021) %>% 
      mutate(laskenta = "GHGI"))

ggplot(total_maku, aes(x = year, y = total_ktC, col = laskenta)) + 
  geom_point() +
  geom_path() 

# Covert to CRF and save

crf_table <-
  total_emission %>% 
  mutate(CRF = "#orga.soil,ktC# {1632C1F2-832E-48D5-BA76-AA1DFAA643DC}", 
         total_ktC = round(total_ktC, 3)) %>% 
  pivot_wider(names_from = year, 
              values_from = total_ktC)
  # write.table(file = paste(PATH_crf, "LU4A1_FL-FL_Organic_soil.csv", sep = ""),
  #             quote = F,
  #             row.names = F, 
  #             col.names = F)


if(PARAM_draw_plots) {
  
  # Calculate final emission
  fig_emission <-
    emission_factor %>% 
    left_join(total_area) %>% 
    # Calculate total emission, convert to kilotons
    mutate(total_ktC = (drained_peatland_area * EF_drained_peatland) / 1000)
  
fig_tot_ptype <- 
  ggplot(fig_emission, aes(x = year, y = total_ktC)) + 
  geom_point() +
  geom_path() +
  ylab("kt of C / y") +
  labs(title = "Total Soil carbon balance") +
  facet_grid(peat_type~maakunta, scales = "free_y")
  ggsave(fig_tot, filename = file.path(PATH_figures, "total_emission_peat_type.png"), dpi = 120)
  
  fig_tot <- 
    ggplot(total_emission, aes(x = year, y = total_ktC)) + 
    geom_point() +
    geom_path() +
    ylab("kt of C / y") +
    labs(title = "Total Soil carbon balance") 
  ggsave(fig_tot, filename = file.path(PATH_figures, "total_emission.png"), dpi = 120)
  
}