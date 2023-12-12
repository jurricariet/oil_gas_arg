function(request){
  navbarPage(
    title = div(  #### NavBar #####
                           div(
                             id = "img-id",
                             tags$a(img(src="https://github.githubassets.com/assets/GitHub-Mark-ea2971cee799.png",width = 30),href="https://github.com/jurricariet/oil_gas_arg",target = '_blank'
                             )),
                           "", id = "title", class = "navbar1"),
             id="navbar",
             position = "fixed-top",
             windowTitle = "", 
             collapsible = TRUE,
             header = includeCSS("styles.css"),
    tabPanel("Oil & Gas Argentina",
             #useWaiter(),
             waiter_show_on_load(html = loading_screen, color = "lightgrey"),
             #autoWaiter(html = loading_screen, color = "lightgrey", fadeout = T),
             #waiter_show_on_load(html = loading_screen, color = "white"),
             
             uiOutput("welcome_dialog"),
             div(br(),
                 br(),
                 br(),
                 h4("Producción de petróleo y gas por empresa en 2023")),
                 fluidPage(
                   fluidRow(column(6,
                                   selectInput("empresa",
                                               "Empresa",
                                               choices=sort(unique(prod_pozo_2023$empresa)),
                                              selected = "YPF S.A."
                                   ))),
                 fluidRow(column(6,
                                 plotOutput("graf_pet")
                 ),
                 column(6,
                        plotOutput("graf_gas"))
                 ),
                 div(br(),
                     br(),
                     ),
                 fluidRow(column(6,h5(tags$b("Mapa: "),"Pozos de producción de petróleo" )),
                          
                          column(6,h5(tags$b("Mapa: "),"Pozos de producción de gas" ))),
                 fluidRow(
                   
                   # Show a plot of the generated distribution
                   column(6,
                          leafletOutput("prod_petroleo")
                   ),
                   column(6,
                          leafletOutput("prod_gas"))
                 )
                 
                 )
                   
    )
  )
    
  }
