# Paths
source("settings.R")
name_plot <- "plot_4"

for (frmt in c(format_img, "data")){
  dir.create(path = str_c(path_res,path_project,name_plot,"/",frmt),recursive = TRUE)
}

rep_pal[[str_c("cb_palette_p4")]]  <- c("#005DA4")

#Construction of the income based deciles
dlist   <-  c("D_1", "D_2","D_3", "D_4", "D_5", "D_6", "D_7", "D_8", "D_9", "D_10")
Decile <-c("Décile 1 ", "Décile 2 ", "Décile 3 ", "Décile 4 ", "Décile 5 ", "Décile 6 ", "Décile 7 ", "Décile 8 ", "Décile 9 ", "Décile 10")

dc <- cbind("Decile_UC" = dlist, Decile) %>% as.data.frame()


## data 
df.1 <- read.csv(str_c(path_project,name_plot,"/data/data_plot_4.csv")) 

df.1$Decile <- factor(dc$Decile, levels = dc$Decile)


data_plot.1 <- df.1 %>% select(-Choc_tot,-CO2) 
data_plot.2 <- df.1 %>% select(-Cov.rate,-CO2) 
data_plot.3 <- df.1 %>% select(-Cov.rate,-Choc_tot) 


## plot
rep_plot[[str_c("plot.1")]] <- ggplot(data = data_plot.1 , aes(x= Decile, y = Cov.rate*100,  fill = Tax)) +
  geom_hline(aes(yintercept = .75),color = "#8b8b8b", linetype= "dashed", size = 0.3) +
  geom_hline(aes(yintercept = .25),color = "#8b8b8b", linetype= "dashed", size = 0.3) +
  geom_hline(aes(yintercept = 1),color = "#8b8b8b", linetype= "dashed", size = 0.3) +
  geom_hline(aes(yintercept = 0.5),color = "#8b8b8b", linetype= "dashed", size = 0.3) +
  geom_hline(aes(yintercept = 0),color = "#8b8b8b", linetype= "solid", size = 0.4) +
  geom_bar(stat="identity", width = 0.85) +
  scale_color_manual(values =  rep_pal[[str_c("cb_palette_p4")]], aesthetics = "fill") +
  ofce::theme_ofce(base_family = "Nunito") +
  theme(legend.position = "none", 
        axis.text.y = element_blank()) + 
  labs(
    title= "",#str_c(i), 
    subtitle =  "Taux d'effort (en % du revenu)",
    caption="",
    x= "",
    y=""
  )  +
  coord_flip()



rep_plot[[str_c("plot.2")]] <- ggplot(data = data_plot.2 , aes(x= Decile, y = Choc_tot, fill = Tax)) + 
  geom_hline(aes(yintercept = 100),color = "#8b8b8b", linetype= "dashed", size = 0.3) +
  geom_hline(aes(yintercept = 200),color = "#8b8b8b", linetype= "dashed", size = 0.4) +
  geom_hline(aes(yintercept = 300),color = "#8b8b8b", linetype= "dashed", size = 0.3) +
  geom_hline(aes(yintercept = 0),color = "#8b8b8b", linetype= "solid", size = 0.4) +
  geom_bar(stat="identity", width = 0.85) +
  scale_color_manual(values =  rep_pal[[str_c("cb_palette_p8")]], aesthetics = "fill") +
  ofce::theme_ofce(base_family = "Nunito") +
  theme(legend.position = "none", 
        axis.text.y = element_blank()) + 
  labs(
    title= "",#str_c(i), 
    subtitle =  "En Euros par ménage",
    caption="",
    x= "",
    y=""
  )   +
  coord_flip()

rep_plot[[str_c("plot.3")]] <- ggplot(data = data_plot.3 , aes(x= Decile, y = CO2, fill = Tax)) + 
  geom_hline(aes(yintercept = 2),color = "#8b8b8b", linetype= "dashed", size = 0.3) +
  geom_hline(aes(yintercept = 4),color = "#8b8b8b", linetype= "dashed", size = 0.4) +
  geom_hline(aes(yintercept = 6),color = "#8b8b8b", linetype= "dashed", size = 0.3) +
  geom_hline(aes(yintercept = 0),color = "#8b8b8b", linetype= "solid", size = 0.4) +
  geom_bar(stat="identity", width = 0.85) +
  scale_color_manual(values =  rep_pal[[str_c("cb_palette_p4")]], aesthetics = "fill") +
  ofce::theme_ofce(base_family = "Nunito") +
  theme(legend.position = "none", 
        axis.text.y = element_blank()) + 
  labs(
    title= "",#str_c(i), 
    subtitle =  "En tCO2 par ménage",
    caption="",
    x= "",
    y=""
  )  +
  coord_flip()


plot.mid <- ggplot(df.1 ,aes(x = 1, y = Decile)) +
  geom_text(aes(label = Decile), size = 3) +
  ggtitle("") +
  ylab(NULL) +
  ofce::theme_ofce(base_family = "Nunito") +
  theme(legend.position = "none", 
        axis.text.x = element_text(colour="white")) + 
  labs(
    title= "",#str_c(i), 
    subtitle =  "",
    caption="",
    x= "",
    y=""
  )


rep_plot[[str_c("plot")]] <- ggarrange(plot.mid, rep_plot[[str_c("plot.1")]],rep_plot[[str_c("plot.2")]]  , rep_plot[[str_c("plot.3")]],
                                       ncol=4, widths=c(1/10 , 3/10,3/10,3/10),
                                       nrow=1, common.legend = TRUE, legend = "none")


#### EXPORTS
for (frmt in format_img){
  ggsave(str_c(name_plot,".",frmt), rep_plot[[str_c("plot")]], device = str_c(frmt), path = str_c(path_res,path_project,name_plot,"/",frmt), width = 210 , height = 140 , units = "mm", dpi = 600)  
}
