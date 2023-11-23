#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
shinyServer(function(input, output) {
  
  output$welcome_dialog <- renderUI({
    showModal(
      modalDialog(
        title = "Pozos de petróleo y gas en Argentina",
        HTML("<p>Producción de petróleo y gas por empresa<br> http://datos.gob.ar/</p>"),
        easyClose = T,
        size = "m",
        footer = modalButton("Ok")
      )
    )
  })
  top_100_petroleo <- reactive(prod_pozo_2023 %>% 
                             filter(empresa == input$empresa ) %>% 
                               arrange(petroleo) %>% 
                               top_n(100,petroleo) %>% 
                               mutate(etiqueta=glue::glue("empresa: {empresa}<br> tipo: {tipo_de_recurso}<br>producción: {round(petroleo)}") %>% 
                                       lapply(htmltools::HTML))
                               
                             )
  top_100_gas <- reactive(prod_pozo_2023 %>% 
                            filter(empresa == input$empresa ) %>% 
                            arrange(gas) %>% 
                            top_n(100,gas) %>% 
                            mutate(etiqueta=glue::glue("empresa: {empresa}<br> tipo: {tipo_de_recurso}<br>producción: {round(gas)}") %>% 
                                    lapply(htmltools::HTML))
  )
  
  pal_petroleo <- reactive(colorBin("Reds", domain = top_100_petroleo()$petroleo))
  pal_gas <- reactive(colorBin("Reds", domain = top_100_gas()$gas))
  # labels <- reactive(sprintf(
  #   "<strong>%s</strong><br/>%g </sup>",
  #   puestos_rama()$nombre_departamento_indec, puestos_rama()$peso_rama
  # ) %>% lapply(htmltools::HTML))
  output$prod_petroleo <- 
    renderLeaflet(
      leaflet()%>%
        addTiles(urlTemplate = "https://wms.ign.gob.ar/geoserver/gwc/service/tms/1.0.0/mapabase_gris@EPSG%3A3857@png/{z}/{x}/{-y}.png",
                 options = providerTileOptions(minZoom = 2), attribution = "ign") %>%
        setView(lng = -64.5, lat = -40, zoom = 3.8) %>%
        setMaxBounds(lat1 = 85, lat2 = -85.05, lng1 = 180, lng2 = -180) %>% 
        addPolygons(data = geo %>% st_as_sf(), 
                    fillOpacity = 0, weight = .5, color="black"
        ) %>% 
        addCircles(data =top_100_petroleo(),
                  #color = ~idempresa,
                   color = ~pal_petroleo()(petroleo),
                   label = ~etiqueta,
                   labelOptions = labelOptions(
                     style = list("font-weight" = "normal", padding = "3px 8px"),
                     textsize = "15px",
                     direction = "auto"))
    )
}
)