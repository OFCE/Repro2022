# Installation des packages
library("pacman")
if(!require(pacman))install.packages("pacman")


pacman::p_load('tidyverse', 'gapminder','openxlsx',
               'ggalt',  'png', 'colorspace','zoo',
               'grid', 'ggpubr', 'scales', 'showtext', 'ofce')


### Ajout de la police Nunito 
font_add_google("Nunito", family = "Nunito regular")


# Loading the functions 
# source("src/functions.R")

# format image des graphes 
format_img <- c("svg", "png")

# List des palettes
rep_pal <- list()

# Creating the folder results
path_res <- "Results/Plots/"
path_project <- "PB_100/"