# Importing data from external sources
library(terra)
library(imageRy)

# Per prima cosa dobbiamo creare un mirror per far capire al computer quale directory stiamo usando
C://Carlo/Documents

# per settare la directory usiamo la funzione 
setwd("C:/Users/spacc/Downloads")

# Utilizziamo la funzione rast per importare l'immagine dell'eclissi che abbiamo scaricato nella cartella della repository
eclissi <- rast("eclissi.png") 

eclissi

# Plottiamo poi i ata con im.plotRGB(eclissi, 1, 2, 3)
im.plotRGB(eclissi, 1, 2, 3)
im.plotRGB(eclissi, 3, 2, 1)
im.plotRGB(eclissi, 2, 3, 1)
im.plotRGB(eclissi, 2, 1, 3)

# Calcoliamo le differenze tra le bande 
dif = eclissi[[1]] - eclissi[[2]]
plot(dif)

# Scarichiamo un'immagine e ripetiamo il processo
ocean <- rast("oceanisgreening_2022.jpg")
ocean

im.plotRGB(ocean, 1, 2, 3)
im.plotRGB(ocean, 3, 2, 1)
im.plotRGB(ocean, 1, 3, 2)
im.plotRGB(ocean, 2, 1, 3)

# Copernicus ha 4 blocchi di dati (Vegetazione, energia, acqua e criosfera= e altri due (hot spots e groundbased
# VEGETAZIONE
# FAPAR quantifica la frazione della radiazione solare assorbita dalle foglie vive per la fotosintesi 

# ENERGIA
# Top of Canopy misura la riflettanza
# Surface Albedo
# Land surface temperature, è la temperatura al suolo (divers ada quella dell'aria)

# Water Cycle
# Riguarda la copertura dell'acqua di tutto quanto il pianeta
# La prima categoria è Lake Water

# Per importare i dati da Copernicus, bisogna prima fare il login, poi dal login andare su una delle risorse, fare search e scaricare un dato, si apre una finestra, scaricare il primo file
# Bisogna aver caricato la library terra
soil <- rast("c_gls_SSM1km_202404210000_CEURO_S1CSAR_V1.2.1.nc")
soil

# Se dobbiamo analizzare solo un'area e non tutta quanta la superficie del pianeta doppiamo croppare il dato, definendo con c la xmin, la xmax, la ymin e la ymax definita con un estensione
ext <- c(25,30 , 55, 58)
soilcrop <- crop(soil,ext)
plot(soilcrop)
plot(soilcrop[[1]])
