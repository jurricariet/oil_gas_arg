library(tidyverse)
library(sf)
library(leaflet)
library(geoAr)
library(waiter)
library(fontawesome)
library(highcharter)
library(ggtext)

prod_pozo_2023 <- read_rds("data/prod_pozos_2023.rds") 
prod_empresa_2023 <- read_rds("data/prod_empresa_2023.rds") %>% 
  mutate(fecha = as.Date(paste0(anio,"-",mes,"-01")))
geo <- read_rds("data/geo_ar.rds")

#############
# pozos_100_petroleo_2023 <- prod_pozo_2023 %>% 
#     mutate(etiqueta=glue::glue("empresa: {empresa}<br> tipo: {tipo_de_recurso}<br>producción: {round(petroleo)}") %>% 
#            lapply(htmltools::HTML))
# pozos_100_gas_2023 <- prod_pozo_2023 %>% 
#   arrange(gas) %>% 
#   top_n(100,gas) %>% 
#   mutate(etiqueta=glue::glue("empresa: {empresa}<br> tipo: {tipo_de_recurso}<br>producción: {round(gas)}") %>% 
#            lapply(htmltools::HTML))

loading_screen <- tagList(
  h3("Cargando...", style = "color:gray;"))


leafIcons <- icons(
  iconUrl = "https://uxwing.com/wp-content/themes/uxwing/download/transportation-automotive/barrel-icon.png",
  iconWidth = 38, iconHeight = 55,
  iconAnchorX = 22, iconAnchorY = 94,
 shadowWidth = 50, shadowHeight = 64,
  shadowAnchorX = 4, shadowAnchorY = 62
)