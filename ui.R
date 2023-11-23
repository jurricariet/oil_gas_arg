function(request){
  navbarPage(
    title = div(  #### NavBar #####
                  "",
                  id = "title", class = "navbar1"),
    id="navbar",
    position = "fixed-top",
    windowTitle = "Oil & gas Argentina",
    collapsible = TRUE,
    fluid = TRUE,
    #header = includeCSS("styles.css"),
    tabPanel("Oil & Gas Argentina",
             #useWaiter(),
             waiter_show_on_load(html = loading_screen, color = "lightgrey"),
             #autoWaiter(html = loading_screen, color = "lightgrey", fadeout = T),
             #waiter_show_on_load(html = loading_screen, color = "white"),
             
             uiOutput("welcome_dialog"),
             div(br(),
                 h4("Producción de petróleo y gas de los 100 pozos más productivos. Seleccione la empresa que desea explorar"),
             ),
                 fluidPage(
                   fluidRow(column(6,
                                   selectInput("empresa",
                                               "Empresa",
                                               choices=sort(unique(prod_pozo_2023$empresa)),
                                              selected = "YPF S.A."
                                   ))),
                 h5(tags$b("Mapa: "),"Pozos de producción de petróleo" ),
                 fluidRow(
                   
                   # Show a plot of the generated distribution
                   column(6,
                          leafletOutput("prod_petroleo")
                   )
                 )
                   )
                   
    )
  )
    
  }
