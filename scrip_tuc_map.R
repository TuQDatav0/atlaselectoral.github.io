
library(tidyverse)
library(sf)
library(leaflet)
library(htmlwidgets)
library(htmltools)

tuc <- read_sf("../../ATLAS TUCUMAN/tucuman_circuitos/tucuman_circuitos.shp")


tuc

tuc %>% 
ggplot() +
  geom_sf(fill = "blue", color = "blue") +
  theme_void() +
  theme(panel.grid = element_line(color = "transparent"))

leafMap <-tuc %>%
  st_transform(4326) %>% 
  select(KEY, LOCALIDAD) %>% 
  leaflet() %>% 
  addProviderTiles(providers$Stamen.Toner) %>%
  addPolygons(weight = 1, color = "blue",
              fillOpacity=0.3,
              label= tuc$KEY,
              labelOptions= labelOptions(direction = 'auto'),
              highlightOptions = highlightOptions(
                color='#00ff00', opacity = .5, weight = 2, fillOpacity = .2,
                bringToFront = TRUE, sendToBack = TRUE))

currentWD <- getwd()
dir.create("static/leaflet", showWarnings = FALSE)
setwd("static/leaflet")
saveWidget(leafMap, "leafMap.html")
setwd(currentWD)

