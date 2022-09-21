# OPMA 419 Group Project 1
# Benjamin LeBlanc, Shaan Gehlot, and Nevin Sangha
# McDonald's Protein Bang for your Buck Visualization's
# Press 'Alt' + 'o' keys (not zero) to view (close) all sections
# Press 'Shift' + 'Alt' + 'o' to open all sections


# Libraries ---------------------------------------------------------------
library(tidyverse)
library(janitor)
library(writexl)

# Set working directory ---------------------------------------------------
setwd("D:/OneDrive/Notes/Winter 2021/OPMA 419/Group Project 1")

# Importing Data ----------------------------------------------------------
mcmenu <- read.csv("menu.csv") %>% 
  clean_names() %>% 
  select(category, item, price, serving_size, calories, calories_from_fat, total_fat, protein, carbohydrates,
         everything())


# Adding Protein and Carb Calories (Approximate) --------------------------
# The dataset already has a recorded calories from fat column, so we are going to approximate calories from carbs and 
# calories from protein using the following values
# https://www.nal.usda.gov/fnic/how-many-calories-are-one-gram-fat-carbohydrate-or-protein - reference
# 9 calories per gram of fat (not needed), 4 calories per gram of carbs, 4 calories per gram of protein
mcmenu_1 <- mcmenu %>% 
  mutate(calories_from_pro = protein*4,
         calories_from_carb = carbohydrates*4) %>% 
  mutate(total_calories_test = calories_from_pro + calories_from_carb +calories_from_fat) %>% 
  select(category, item, price, serving_size, calories, total_calories_test,
         calories_from_fat, calories_from_pro, calories_from_carb, 
         total_fat, protein, carbohydrates,
         everything())



# Write to Excel Sheet ----------------------------------------------------
writexl::write_xlsx(mcmenu_1, "mcmenu.xlsx")


  
