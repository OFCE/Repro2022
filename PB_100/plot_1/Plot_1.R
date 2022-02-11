# Paths
source("settings.R")
name_plot <- "plot_1"

for (frmt in c(format_img,"pdf")){
  dir.create(path = str_c(path_res,path_project,name_plot,"/",frmt),recursive = TRUE)
}


rep_pal[[str_c("cb_palette_p1")]]  <-  c("#005DA4", "#F59C00", "#C51315", "#008D36", "black", "blue")


# Data
data_plot <- read.csv(str_c(path_project,name_plot,"/data/data_plot.PB_1.csv")) 

data_plot$years <- lubridate::ymd(data_plot$years, truncated = 2L)

## Plot 
rep_plot[[str_c("plot")]] <- ggplot() +
  geom_line(data = data_plot , aes(x = years, y = value, group = country, colour = country), size = 0.7) +
  geom_text(data = df.var , aes(label = str_c(round(100 * var,0), "%"), 
                                x = as.Date("2019-01-01"), 
                                y = value, 
                                group = country,
                                color = country), 
            size = 2) + 
  theme_ofce(base_family = "Nunito") + 
  theme(legend.title = element_blank()) +
  scale_color_manual(values = rep_pal[[str_c("cb_palette_p1")]] ,
                     label = levels(countries_FR)) +
  scale_x_date(expand=c(0,0),
               date_breaks = "5 year",
               date_labels = "%Y",
               limits = c(min(data_plot$years), max(data_plot$years)+365*2)) +
  labs(
    title= "",#str_c(i), 
    subtitle =  "",
    caption = "Source : Banque Mondiale - Indicateurs du développement dans le monde",
    y= "en tCO2e/hab.",
    x=""
  ) 

# Save
for (frmt in format_img){
  ggsave(str_c(name_plot,".",frmt), rep_plot[[str_c("plot")]], device = str_c(frmt), path = str_c(path_res,path_project,name_plot,"/",frmt), width = 210 , height = 140 , units = "mm", dpi = 600)  
}