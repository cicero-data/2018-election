library(tidyverse)
library(DT)
library(htmlwidgets)
library(widgetframe)

dat <- read_csv('data/2018_election_chambers.csv')

head(dat)


    
    # Blue to Dark Pink range
    #dark_pink <- '#F07272'
    #light_pink <- '#FFB0B0'
    #light_blue <- '#C2DDF7'
    #dark_blue <- '#64A9E2'

gop_red <- '#DA4D63'
dem_blue <- '509CC8'

    
#create data table as R object
election_table <- 
  datatable(dat, rownames = FALSE,
                             colnames=c("Chamber Name", "State","# of officials", "Districts/Seats", 
                                        "Term Start Date", "Party Control", "New Districts"), 
                             extensions = 'Responsive',
                             class = 'compact hover row-border',
                             options = list(
                              dom = 'ftp',
                              autowidth = TRUE,
                              order = list(list(4, 'asc')),
                              columnDefs = list(
                                (list(className = 'dt-left', targets = c(0,1,2,3,4,5)) ),
                                (list(targets = c(3,6), visible = FALSE))
                                ),
                              #scrollCollapse=TRUE,
                               pageLength = 10,
                               paging = TRUE,
                               searching = TRUE,
                               initComplete = JS(
                                   "function(settings, json) {",
                                   "$('body').css({
                                        'font-family': 'Libre Franklin',
                                        'font-size': '14px',
                                        'color': '#222222'});",
                                   "$(this.api().table().header()).css({
                                       'color': 'white', 
                                       'font-family': 'Libre Franklin',
                                       'font-size': '14px',
                                       'background-color': 'black'});",
                                   "}"
                                 ))) %>% 
  formatStyle(
    'Party Control',
    backgroundColor = styleEqual(c('D', 'R', 'C', 'N', 'I'), c('lightblue', 'pink', 'yellow', 'grey', 'purple'))
  ) %>%
  formatStyle(c('Chamber Name'), fontWeight = 'bold')

saveWidget(frameableWidget(election_table), "index.html", selfcontained = FALSE, libdir = "src/")

