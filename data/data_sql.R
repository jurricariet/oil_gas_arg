library(RSQLite)
library(tidyverse)
library(glue)

# Descarga de los datos de http://datos.energia.gob.ar/ y conversión a sqlite


pozos <- read_csv("http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/cbfa4d79-ffb3-4096-bab5-eb0dde9a8385/download/listado-de-pozos-cargados-por-empresas-operadoras.csv")


prod_2006 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/4e1c55e5-1f1b-4fc8-aa37-2080d9795f29/download/produccin-de-pozos-de-gas-y-petrleo-2006.csv'
prod_2007 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/be663a63-f020-4e28-8f31-c5f81d47554d/download/produccin-de-pozos-de-gas-y-petrleo-2007.csv'
prod_2008 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/3430b5a8-a516-42ca-a47d-2e1ce45925fb/download/produccin-de-pozos-de-gas-y-petrleo-2008.csv'
prod_2009 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/48585038-055a-4437-bb1d-4fe36073f453/download/produccin-de-pozos-de-gas-y-petrleo-2009.csv'
prod_2010 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/364ca28e-d069-4bd6-8771-925f0db152a8/download/produccin-de-pozos-de-gas-y-petrleo-2010.csv'
prod_2011 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/4817272c-7365-4bdd-b02d-75b118218b10/download/produccin-de-pozos-de-gas-y-petrleo-2011.csv'
prod_2012 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/0dce0e75-1556-47ee-8615-1955fbd54ade/download/produccin-de-pozos-de-gas-y-petrleo-2012.csv'
prod_2013 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/bc7ac8fe-2cec-4dab-acdd-322ea1ccc887/download/produccin-de-pozos-de-gas-y-petrleo-2013.csv'
prod_2014 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/cd9813a7-1e19-4f60-a02a-7903dd81aff7/download/produccin-de-pozos-de-gas-y-petrleo-2014.csv'
prod_2015 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/e375aa35-fd8d-41d6-aa0c-e6879ca567a1/download/produccin-de-pozos-de-gas-y-petrleo-2015.csv' 
prod_2016 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/d8539ae8-0a71-4339-a16c-139b21bd2cd0/download/produccin-de-pozos-de-gas-y-petrleo-2016.csv'
prod_2017 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/df4857e1-7c3f-4980-b5b5-184fe78bfcf0/download/produccin-de-pozos-de-gas-y-petrleo-2017.csv'
prod_2018 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/333fd72a-9b83-4bc1-bc94-0f5940b52331/download/produccin-de-pozos-de-gas-y-petrleo-2018.csv'
prod_2019 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/8bc0d61c-0408-43d4-a7bc-7178fcb5d37e/download/produccin-de-pozos-de-gas-y-petrleo-2019.csv'
prod_2020 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/c4a4a6a0-e75a-4e12-ae5c-54d53a70348c/download/produccin-de-pozos-de-gas-y-petrleo-2020.csv'
prod_2021 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/465be754-a372-4c31-b855-81dc5fe3309f/download/produccin-de-pozos-de-gas-y-petrleo-2021.csv'
prod_2022 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/876b3746-85e2-4039-adeb-b1354436159f/download/produccin-de-pozos-de-gas-y-petrleo-2022.csv'
prod_2023 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/231c39b3-e81e-4398-af8d-b115807f2c25/download/produccin-de-pozos-de-gas-y-petrleo-2023.csv'
prod_2024 <- 'http://datos.energia.gob.ar/dataset/c846e79c-026c-4040-897f-1ad3543b407c/resource/43a09dce-1742-44d0-bc13-f193deaab563/download/produccin-de-pozos-de-gas-y-petrleo-2024.csv'

for (i in 2006){
  glue('prod_{i}') <- read_csv(paste('prod',i,collapse='_'))
}

