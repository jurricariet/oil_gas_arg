library(tidyverse)
library(sf)
data <- read_csv("http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/231c39b3-e81e-4398-af8d-b115807f2c25/download/produccin-de-pozos-de-gas-y-petrleo-2023.csv")

pozos <- read_csv("http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/cbfa4d79-ffb3-4096-bab5-eb0dde9a8385/download/listado-de-pozos-cargados-por-empresas-operadoras.csv")

prod_pozo_2023 <- data %>% 
  group_by(idempresa,empresa,idpozo,formacion,tipo_de_recurso,tipoextraccion) %>% 
  summarise(gas = sum(prod_gas,na.rm=T),
            petroleo = sum(prod_pet,na.rm=T)) %>% 
  ungroup() %>% 
  left_join(pozos %>% select(idpozo,sigla,coordenadax,coordenaday)) %>% 
  filter(!is.na(coordenaday) & !is.na(coordenadax)) %>% 
  st_as_sf(coords = c("coordenadax","coordenaday"))

write_rds(prod_pozo_2023,"data/prod_pozos_2023.rds")

prod_empresa_mes <- data %>% 
  group_by(idempresa,empresa,anio,mes,tipo_de_recurso) %>% 
  summarise(petroleo = sum(prod_pet,na.rm = T),
            gas = sum(prod_gas,na.rm=T))

write_rds(prod_empresa_mes,"data/prod_empresa_2023.rds")
# Datos geo
library(geoAr)
geo <- get_geo("ARGENTINA", level = "provincia") %>%
  add_geo_codes() %>% 
  rename(province = name_iso) %>% 
  mutate(province = ifelse(province=="Ciudad Autónoma de Buenos Aires","CABA",province)) %>% 
  distinct()
write_rds(geo,"data/geo_ar.rds")
