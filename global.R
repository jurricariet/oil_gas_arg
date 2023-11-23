library(tidyverse)
library(sf)
library(leaflet)
library(geoAr)
library(waiter)

prod_pozo_2023 <- read_rds("data/prod_pozos_2023.rds") 
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



# ### PRUEBAS
# top100 <- prod_pozo_2023 %>% 
#   filter(empresa == "YPF S.A." ) %>% 
#   arrange(petroleo) %>% 
#   top_n(100,petroleo) %>% 
#   mutate(etiqueta=glue::glue("empresa: {empresa}<br> tipo: {tipo_de_recurso}<br>producción: {round(petroleo)}") %>% 
#            lapply(htmltools::HTML)) %>%
#   mutate(lon = sf::st_coordinates(.)[,1],
#          lat = sf::st_coordinates(.)[,2])
#   st_as_sf()
# leaflet()%>%
#   addTiles(urlTemplate = "https://wms.ign.gob.ar/geoserver/gwc/service/tms/1.0.0/mapabase_gris@EPSG%3A3857@png/{z}/{x}/{-y}.png",
#            options = providerTileOptions(minZoom = 2), attribution = "ign") %>%
#   setView(lng = -64.5, lat = -40, zoom = 3.8) %>%
#   setMaxBounds(lat1 = 85, lat2 = -85.05, lng1 = 180, lng2 = -180) %>%
#   addPolygons(data = geo %>% st_as_sf(),
#               fillOpacity = 0, weight = .5, color="black"
#   ) %>%
#   addCircles(data =top100,
#              #color = ~idempresa,
#              labelOptions = labelOptions(
#                style = list("font-weight" = "normal", padding = "3px 8px"),
#                textsize = "15px",
#                direction = "auto"))
