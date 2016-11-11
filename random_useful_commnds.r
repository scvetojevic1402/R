#count of columns that contain NA in data frame named e.g. df
count<-0
for (i in 1:ncol(df)){
  if (TRUE %in% is.na(df[i]))
    count<-count+1
}
View(coun)

#list of columns that contain NA values
naCols<-c()
for (i in 1:ncol(df)){
  if (TRUE %in% is.na(df[i]))
    naCols<-append(naCols,names(df[i]))
}
View(naCols)

#count of NA values in each column of a df
sapply(df,function(x) length(which(is.na(x))))
