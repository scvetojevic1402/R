#this is a simple example of how to map languages of tweets from a specific area
#tweets were stored as jsonb in a PostgreSQL database

library(ggplot2)
library(ggmap)
library(RPostgreSQL)
ParisMap <- qmap(location="Paris", maptype = "toner-lite", source = "stamen", zoom = 13, legend = 'topleft')
ParisMap

ws2=dbConnect(PostgreSQL(), user="user", host="host",port=5432, dbname="db",password="pass")
tweets<-dbGetQuery(ws2,"SELECT (tweet#>>'{coordinates,coordinates,0}')::numeric as x
                   ,(tweet#>>'{coordinates,coordinates,1}')::numeric as y
                   ,tweet#>>'{lang}' as lang
                   ,retweets
                   FROM PARIS_TWEETS WHERE INSERT_TIME > '2015-11-13 22:00:00.000000' 
                   AND INSERT_TIME < '2015-11-13 23:00:00.000000' AND GEOM IS NOT NULL 
                   limit 100000;")

ParisMap +geom_point(aes(x = x, y = y, size = lang,colour = lang)
                     ,data = tweets[tweets$lang%in%c("en","es","fr","bn"),]) #limiting the legend and points to only most common languages

