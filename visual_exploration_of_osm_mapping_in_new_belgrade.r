install.packages("osmar")
library(osmar)
nbgd <- get_osm(center_bbox(20.4080,44.8302, 1000, 1000),all=True)

summary(nbgd)

#first we check what kind of rel, ways and nodes the file contains
summary(nbgd$relations)
summary(nbgd$ways)
summary(nbgd$nodes)

highway_ids <- find(nbgd, way(tags(k == "highway")))
highway_ids <- find_down(nbgd, way(highway_ids))
highways <- subset(nbgd, ids = highway_ids)

traffic_signals_ids <- find(nbgd, node(tags(v == "traffic_signals")))
traffic_signals <- subset(nbgd, node_ids = traffic_signals_ids)

busstop_ids <- find(nbgd, node(tags(v %agrep% "busstop")))
busstop <- subset(nbgd, node_ids = busstop_ids)

buildings_ids <- find(nbgd, way(tags(k == 'building')))
buildings_ids <- find_down(nbgd, way(buildings_ids))
buildings <- subset(nbgd, ids = buildings_ids)

plot(nbgd,way_args = list(col = gray(0.7)),node_args = list(pch = 25, cex = 0.1, col = gray(0.3)))
plot_ways(highways, add = TRUE, col = "purple")
plot_nodes(traffic_signals, add = TRUE, col = "red")
plot_nodes(buildings, add = TRUE, col = "yellow")
plot_ways(str,add=TRUE,col="blue")
