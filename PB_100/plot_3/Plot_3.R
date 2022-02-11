source("settings.R")
#### Path
name_plot <- "Plot_3"

for (frmt in c(format_img,"pdf", "data")){
  dir.create(path = str_c(path_res,path_project,name_plot,"/",frmt),recursive = TRUE)
}

# Labels
rep_pal[[str_c("cb_palette_p3")]]  <- c("black","#005DA4", "#F59C00", "#C51315", "#008D36" )
label <- c("Émissions de CO2 liées à la combustion", 
           "Population", 
           "PIB/habitant",
           "Intensité énergétique (Mtep/PIB)",
           "Intensité en CO2 de l'énergie (MtCO2/Mtep)")

# Data
read.csv(str_c(path_project,name_plot,"/data/data_plot_3.csv")) 

data_plot$years <- lubridate::ymd(data_plot$years, truncated = 2L)


# Plot
plot <- ggplot(data_plot, aes(x = years, y = 100*value, group = label, colour =label)) + 
  geom_line(size = 0.7) +
  scale_x_date(expand=c(0,0),
               date_breaks = "5 year",
               date_labels = "%Y",
               limits = c(min(data_plot$years), max(data_plot$years)+365)) +
  scale_color_manual(values=rep_pal[[str_c("cb_palette_p3")]] ) +
  ofce::theme_ofce(base_family = "Nunito") +
  theme(legend.title=element_blank(),
        legend.position = c(0.25,0.175)) + 
  labs(title =" ",
       subtitle = "", 
       caption = "Source : Citepa, Insee, Ministère de la transition écologique ",
       y = "", 
       x = "")

# Save
for (frmt in format_img){
  ggsave(str_c(name_plot,".",frmt), plot, device = str_c(frmt), path = str_c(path_res,path_project,name_plot,"/",frmt), width = 210 , height = 140 , units = "mm", dpi = 600)  
}
