#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
shinyServer(function(input, output) {
  
  output$welcome_dialog <- renderUI({
    showModal(
      modalDialog(
        title = "Pozos de petróleo y gas en Argentina",
        HTML("<p>Producción de petróleo y gas por empresa a partir de datos de  <a href= 'http://datos.energia.gob.ar/' target='_blank'> http://datos.energia.gob.ar/</a></p>"),
        easyClose = T,
        size = "m",
        footer = modalButton("Ok")
      )
    )
  })
  top_100_petroleo <- reactive(prod_pozo_2023 %>% 
                             filter(empresa == input$empresa & petroleo >0) %>% 
                               arrange(petroleo) %>% 
                               #top_n(100,petroleo) %>% 
                               mutate(etiqueta=glue::glue("empresa: {empresa}<br> formación: {formacion}<br>tipo: {tipo_de_recurso}<br>producción 2023: {round(petroleo)} m3") %>% 
                                       lapply(htmltools::HTML))
                               
                             )
  top_100_gas <- reactive(prod_pozo_2023 %>% 
                            filter(empresa == input$empresa & gas > 0 ) %>% 
                            arrange(gas) %>% 
                            #top_n(100,gas) %>% 
                            mutate(etiqueta=glue::glue("empresa: {empresa}<br> formación: {formacion}<br>tipo: {tipo_de_recurso}<br>producción 2023: {round(gas)} miles de m3") %>% 
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
        addMarkers(data =top_100_petroleo(),
                   clusterOptions = markerClusterOptions(),
                   icon = leafIcons,
                  #color = ~idempresa,
                   #color = ~pal_petroleo()(petroleo),
                   label = ~etiqueta,
                   labelOptions = labelOptions(
                     style = list("font-weight" = "normal", padding = "3px 8px"),
                     textsize = "15px",
                     direction = "auto"))
    )
  output$prod_gas <-  renderLeaflet(
    leaflet()%>%
      addTiles(urlTemplate = "https://wms.ign.gob.ar/geoserver/gwc/service/tms/1.0.0/mapabase_gris@EPSG%3A3857@png/{z}/{x}/{-y}.png",
               options = providerTileOptions(minZoom = 2), attribution = "ign") %>%
      setView(lng = -64.5, lat = -40, zoom = 3.8) %>%
      setMaxBounds(lat1 = 85, lat2 = -85.05, lng1 = 180, lng2 = -180) %>% 
      addPolygons(data = geo %>% st_as_sf(), 
                  fillOpacity = 0, weight = .5, color="black"
      ) %>% 
      addMarkers(data =top_100_gas(),
                 clusterOptions = markerClusterOptions(),
                 icon = leafIcons,
                 #color = ~idempresa,
                 #color = ~pal_petroleo()(petroleo),
                 label = ~etiqueta,
                 labelOptions = labelOptions(
                   style = list("font-weight" = "normal", padding = "3px 8px"),
                   textsize = "15px",
                   direction = "auto"))
  )
  output$graf_pet <- renderPlot(
    prod_empresa_2023 %>% 
      filter(empresa == input$empresa) %>% 
      ggplot(aes(x=fecha,y=petroleo,group=tipo_de_recurso,fill=tipo_de_recurso))+
      geom_col()+
      scale_y_continuous(labels = scales::number_format(scale=1/1e+3,suffix = " m"))+
      scale_x_date(date_breaks = "month",date_labels = "%b %Y")+
      scale_fill_manual(values = c("CONVENCIONAL"="#208c7c",
                                   "NO CONVENCIONAL"="#a55869"),
                        guide="none")+
      theme_minimal()+
      theme(plot.subtitle = element_markdown())+
      labs(x="",y="",title=glue::glue("{top_100_petroleo()$empresa}: producción total de petróleo"),
           subtitle="En miles de m3. <span style='color:#208c7c'>**Convencional**</span> y <span style='color:#a55869'>**no convencional**</span>")
    
  )
  output$graf_gas <- renderPlot(
    prod_empresa_2023 %>% 
      filter(empresa == input$empresa) %>% 
      ggplot(aes(x=fecha,y=gas,group=tipo_de_recurso,fill=tipo_de_recurso))+
      geom_col()+
      scale_y_continuous(labels = scales::number_format(scale=1/1e+3,suffix = " M"))+
      scale_x_date(date_breaks = "month",date_labels = "%b %Y")+
      scale_fill_manual(values = c("CONVENCIONAL"="#208c7c",
                                   "NO CONVENCIONAL"="#a55869"),
                        guide="none")+
      theme_minimal()+
      theme(plot.subtitle = element_markdown())+
      labs(x="",y="",title=glue::glue("{top_100_gas()$empresa}: producción total de gas"),
           subtitle="En millones de m3. <span style='color:#208c7c'>**Convencional**</span> y <span style='color:#a55869'>**no convencional**</span>")
    
  )
}
)