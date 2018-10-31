library(tidyverse)
library(DT)
library(htmlwidgets)
library(widgetframe)

dat <- read_csv('data/2018_election_chambers.csv')

head(dat)
    
#create data table as R object
election_table <- 
  datatable(dat, rownames = FALSE,
                             colnames=c("Chamber Name", "State","# of Officials", "Districts/Seats", 
                                        "Term Start Date", "Party Control", "New Districts"), 
                             extensions = 'Responsive',
                             class = 'compact hover row-border',
                             options = list(
                              dom = 'ftp',
                              autowidth = TRUE,
                              order = list(list(4, 'asc')),
                              columnDefs = list(
                                (list(className = 'dt-left', targets = c(0,1,2,3,4,5)) ),
                                (list(targets = c(3,6), visible = FALSE)),
                                (list(targets = 0, width = '300px')),
                                (list(targets = 4, width = '120px')),
                                (list(targets = 2, width = '90px'))
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
                                       'background-color': '#27323d'});",
                                   "}"
                                 ))) %>% 
  formatStyle(
    'Party Control',
    backgroundColor = styleEqual(c('Democrat', 'Republican', 'Coalition', 'Nonpartisan', 'Independent'), c('lightblue', 'pink', '#f1b210', '#f4f6f8', '#d45db0'))
  ) %>%
  formatStyle(c('Chamber Name'), fontWeight = 'bold')

saveWidget(frameableWidget(election_table), "index.html", selfcontained = FALSE, libdir = "src/")
