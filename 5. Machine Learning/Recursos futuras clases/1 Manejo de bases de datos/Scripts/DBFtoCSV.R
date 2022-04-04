rm(list=ls())
setwd("~")

#########################
# Oscar Elton           #
# DBF to CSV en un loop #
#########################

require(foreign)

csv <- "/Users/oscarelton/Dropbox (Personal)/Curso Machine Learning/1 Intro y manejo de bases de datos/Datos/Inp/csv"

path <- "/Users/oscarelton/Dropbox (Personal)/Curso Machine Learning/1 Intro y manejo de bases de datos/Datos/Inp/dbf"

file.names <- dir(path, pattern=".dbf")

pb <- txtProgressBar(min=1, max=length(file.names), style=3)
for(i in 1:length(file.names)){
  data <- read.dbf(paste(path, file.names[i], sep="/"), as.is=T)
  new.file <- gsub(".dbf", ".csv", file.names[i]) 
  write.csv(data, paste(csv, new.file, sep="/"), row.names = F, fileEncoding = "UTF-8")
  rm(data, new.file)
  setTxtProgressBar(pb, i)
}
close(pb)
rm(pb, i)