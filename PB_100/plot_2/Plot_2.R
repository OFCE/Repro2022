source("settings.R")

name_plot <- "plot_2"

for (frmt in c(format_img,"pdf", "data")){
  dir.create(path = str_c(path_res,path_project,name_plot,"/",frmt),recursive = TRUE)
}

rep_pal[[str_c("cb_palette_p2")]]  <- c("#005DA4", "#F59C00")  

## Data
data_plot <- read.csv(str_c(path_project,name_plot,"/data/data_plot_2.csv")) 

data_plot$years <- lubridate::ymd(data_plot$years, truncated = 2L)

## Plot
plot <- ggplot(data_plot, aes(x = years, y = value, fill = X1)) + 
  geom_area() +
  scale_x_date(expand=c(0,0),
               date_breaks = "5 year", # Ajout de 2 années 
               date_labels = "%Y",
               limits = c(min(data_plot$years), max(data_plot$years)+365)) +
  scale_y_continuous(breaks=seq(0, 12, 2)) +
  scale_fill_manual(values= rep_pal[[str_c("cb_palette_p2")]] ) +
  ofce::theme_ofce(base_family = "Nunito") +
  theme(legend.title=element_blank()) + 
  labs(title =" ",
       subtitle = "", 
       caption = "Source: Traitement SDES 2021. CITEPA ( inventaires NAMEA AIR 2017, SECETEN 2018), EUROSTAT, AIE, INSEE, DOUANES,FAO",
       y = "en tCO2e/hab.", 
       x = "")


## Save
for (frmt in format_img){
  ggsave(str_c(name_plot,".",frmt), plot, device = str_c(frmt), path = str_c(path_res,path_project,name_plot,"/",frmt), width = 210 , height = 140 , units = "mm", dpi = 600)  
}