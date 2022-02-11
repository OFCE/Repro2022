# Paths
source("settings.R")
name_plot <- "plot_6"

for (frmt in c(format_img,"pdf", "data")){
  dir.create(path = str_c(path_res,path_project,name_plot,"/",frmt),recursive = TRUE)
}

# Label
rep_pal[[str_c("cb_palette_p6")]] <- c("#635341","#ae967e", "#435762" , "#af594f","#005DA4", "#C51315")
type_plot <- c("Gaz", "Charbon", "Gazole", "Essence", "Fioul domestique", "Moyenne")
type_mean <- c("Gaz", "Charbon", "Gazole", "Essence", "Fioul domestique")

## Data 
data_plot <- read.csv(str_c(path_project,name_plot,"/data/data_plot_6.csv")) 

# Plot
rep_plot[[str_c("plot")]] <- ggplot(data = data_plot, aes(x = year,
                                                          y = value,
                                                          group = type,
                                                          colour = type)) +
  geom_line(size = 0.9) + 
  geom_point(size = 2) + 
  ylim(0,300) +
  geom_hline(aes(yintercept = 0), color = "gray", linetype= "solid", size = 0.3) +
  scale_color_manual(values = rep_pal[[str_c("cb_palette_p6")]]) +
  theme_ofce(base_family = "Nunito") +
  theme(legend.title=element_blank()) + 
  labs(
    title= "",
    subtitle =  "",
    caption="Lecture : La moyenne de la taxe carbone implicite est calculée comme le ratio entre les recettes de la TICPE et les émissions de CO2. \ Pour le calcul par combustible, le taux effectif de la TICPE publié dans la loi de finances est rapporté au contenu carbone de l’assiette. On obtient des estimations près proches par le calcul du ratio entre les recettes de la TICPE par combustible et les émissions de CO2 par combustible (chiffres non reportés). Source: Calcul des auteurs",
    x= "",
    y="En euros par tCO2"
  ) 

# Save
for (frmt in format_img){
  ggsave(str_c(name_plot,".",frmt), rep_plot[[str_c("plot")]], device = str_c(frmt), path = str_c(path_res,path_project,name_plot,"/",frmt), width = 210 , height = 140 , units = "mm", dpi = 600)  
}