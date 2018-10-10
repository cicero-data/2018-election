library(tidyverse)
library(DT)
library(htmlwidgets)
library(widgetframe)

# unloadNamespace('data.table')
# unloadNamespace('reshape2')
# unloadNamespace('plyr')

dat <- read_csv('data/2018_election_chambers.csv')

head(dat)

#dat <- dat %>% 
          #mutate(pd_lawyer_ratio_15 = pd_cases_2015/pd_lawyers_2015)

#dat_clean <- dat %>% select(County, total_cases_2015, pd_cases_2015_pct, 
                            #pd_lawyer_ratio_15, pd_budget_per_capita_2015)

# avg_budget <- mean(dat_clean$budget_case_pd_2015)

#q1 <- quantile(dat_clean$pd_budget_per_capita_2015)[[2]]
#q2 <- quantile(dat_clean$pd_budget_per_capita_2015)[[3]]
#q3 <- quantile(dat_clean$pd_budget_per_capita_2015)[[4]]
#q4 <- quantile(dat_clean$pd_budget_per_capita_2015)[[5]]


#dat_clean <- dat_clean %>% mutate(budget_per_capita_rank = case_when(
#  pd_budget_per_capita_2015 <= q4 & pd_budget_per_capita_2015 > q3 ~ 4,
#  pd_budget_per_capita_2015 <= q3 & pd_budget_per_capita_2015 > q2 ~ 3,
#  pd_budget_per_capita_2015 <= q2 & pd_budget_per_capita_2015 > q1 ~ 2,
#  pd_budget_per_capita_2015 <= q1 ~ 1
  
#))

# Colors for rank

    # Dark red, orange, to blue range
   # dark_red <- '#FF0000'
    #orange <- '#FF8000'
    #bright_blue <- '#0481e8'
    #bright_purple <- '#0000FF'
    
    
    # Blue to Dark Pink range
    #dark_pink <- '#F07272'
    #light_pink <- '#FFB0B0'
    #light_blue <- '#C2DDF7'
    #dark_blue <- '#64A9E2'

    
#create data table as R object
election_table <- 
  datatable(dat, rownames = FALSE,
                             colnames=c("Chamber Name", "State","# of officials", "Districts/Seats", 
                                        "Term Start Date", "Party Control", "New Districts"), 
                             extensions = 'Responsive',
                             class = 'compact hover row-border',
                             options = list(
                              dom = 'ft',
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
                                       'color': '#222222', 
                                       'font-family': 'Libre Franklin',
                                       'font-size': '14px'});",
                                   "}"
                                 ))) %>% 
  formatStyle(
    'Party Control',
    backgroundColor = styleEqual(c('D', 'R', 'C', 'N'), c('blue', 'red', 'yellow', 'grey'))
  ) %>%
  formatStyle(c('Chamber Name'), fontWeight = 'bold')

saveWidget(frameableWidget(election_table), "index.html", selfcontained = FALSE, libdir = "src/")


# Font
## do fonts in order, it will pick as it goes
## try to use their online font library, its like a cdn, needs to be put into the html

# Graphics
## putting the text from the graphics as headers on the website instead of on the png
## could also snip sections of their page and put into figma to see how it would look, can edit the actual text using the inspect tool and the chrome extension


# Chrome Extension -- chontent editable -- little blue box icon -- can type stuff into the page

# Ai2html
## make everything in ai and then that tool converts all of the text to html/css so its crisp and can be read by screen reader

# On the right track to look at other people's work
# Labeling a select few points is the way to go
# Think about font size and where its going on the page, how big will it actually be
# Stripped down version of the table looks pretty good



