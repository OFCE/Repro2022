# Paths
source("settings.R")
name_plot <- "plot_5"

for (frmt in c(format_img,"pdf", "data")){
  dir.create(path = str_c(path_res,path_project,name_plot,"/",frmt),recursive = TRUE)
}


rep_pal[[str_c("cb_palette_p5")]]  <- sequential_hcl(n = 8, h = c(300, 75), c = c(40, NA, 95), l = c(15, 90), power = c(1, 1.1), register = )


## Data loading
data_plot <- read.csv(str_c(path_project,name_plot,"/data/data_plot_5.csv")) 



## Plot
rep_plot[[str_c("plot")]] <- ggplot(data = data_plot , aes(x= years, y = value,  fill = type)) +
  geom_bar(stat="identity") +
  facet_wrap(vars(scenario)) + 
  scale_color_manual(values =  rep_pal[[str_c("cb_palette_p5")]], aesthetics = "fill") +
  
  theme_ofce(base_family = "Nunito") +
  theme(legend.title = element_blank(), 
        legend.position = "right") + 
  labs(
    title = "",#str_c(i), 
    subtitle =  "",
    caption = "Source: Carbone 4, OFCE, NEO (2021)",
    x = "",
    y = "en Mds €"
  ) 

# Saving
for (frmt in format_img){
  ggsave(str_c(name_plot,".",frmt), rep_plot[[str_c("plot")]], device = str_c(frmt), width = 270 , height = 140 , units = "mm", dpi = 600)  
}

