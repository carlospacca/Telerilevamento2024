# SPECTRAL INDICES

# Le immagini satellitari possono essere utilizzate per calcolare la biomassa, considerando che le piante ricoprono gran parte della biomassa presente. Il vicno infrarosso viene riflesso molto dalle piante
# a causa del mesofillo fogliare e delle cellule a palizzata; il rosso viene assorbito per far partire la fotosintesi e il ciclo di Calvin-Benson-Bassam. 
# Prendendo un pixel di infrarosso e un pixel del rosso e in quel pixel c'è un albero, abbiamo un range di riflettanza (compreso tra 0 e 100), la pianta nell'infrarosso ha una riflettanza molto alta (es.90)
# nel rosso invece ha una riflettanza molto bassa (es.10), si possono integrare questi due dati in un indice distribuito in un solo livello, questo indice si basa sulla sottrazione (nel nostro caso è = ad 80)
# e prende il nome di Difference Vegetation Index (DVI), attraverso questo indice possiamo calcolare la biomassa in quel pixel.
# Prendendo un pixel che non ha una pianta al suo interno, siccome non sono presenti cellule del mesofillo fogliare, la riflettanza sarà molto minore, ad esempio all'interno dell'infrarosso sarà di 60, mentre
# la riflettanza del rosso, che non viene più assorbita, sarà più alta, invece di 10 avremo 30; il DVI sarà quindi uguale a 30, attraverso questo calcolo possiamo fare comunque il calcolo della biomassa.
# Come il rosso, possiamo usare anche il blu, ma utilizziamo il rosso perchè con un grafico chiamato frima spettrale, in cui vengono prese le varie lunghezze d'onda, e si misura la riflettanza di una pianta, 
# sempre da 0 a 100, nel blu abbiamo una  bassa riflettanza, nel verde abbiamo un'altissima riflettanza, nel rosso molto bassa e nel NIR un'elevatissima riflettanza, nel caso di una pianta morta, a causa del
# collasso del mesofillo fogliare si alzano le riflettanze del blu e del rosso e si abbassano la riflettanza del verde e del NIR. Se la pendenza tra la riflettanza del Rosso e quella del NIR, chiamata RED EDGE
# è alta, la pianta è in salute, nel caso contrario la pianta non è in salute.

library (terra)
library (imageRy)

im.import(im.import( "matogrosso_l5_1992219_lrg.jpg" )
m1992 <- im.import(im.import( "matogrosso_l5_1992219_lrg.jpg" )
# Bands
# banda 1 = NIR
# banda 2 = RED
# banda 3 = GREEN
# Noi generiamom un falso colore mettendo il NIR nella banda del rosso, il rosso nella banda del verde e il verde nella banda del blu 
im.plotRGB(m1992 r=1, g=2, b=3)

# mettendo il nir sul verde
                   
im.plotRGB(m1992, 2, 1, 3)
                   
# il nir sul blu invece 

im.plotRGB(m1992, 3, 2, 1)   

# L'immagine del 2006 è stata fatta dal satellite Aster.
im.import( "matogrosso_ast_2006209_lrg.jpg")
m2006 <- im.import( "matogrosso_ast_2006209_lrg.jpg")
# L'acqua nel 2006 aveva meno solidi disciolti infatti appare di colore più scuro
# NIR on top fo green
                   im.plotRGB(m2006, 2, 1, 3)
# NIR on top of blue
                   im.plotRGB(m2006, 2, 3, 1)
                   
par(mfrow=c(2,3))
                   im.plotRGB(m1992, 1, 2, 3) #1992 nir on red
                   im.plotRGB(m1992, 2, 1, 3) #1992 nir on green
                   im.plotRGB(m1992, 3, 2, 1) #1992 nir on blue
                   im.plotRGB(m2006, 1, 2, 3) #2006 nir on red
                   im.plotRGB(m2006, 2, 1, 3) #2006 nir on green
                   im.plotRGB(m2006, 3, 2, 1) #2006 nir on blue
# I bit racchiudono delle informazioni, 1 bit da due info, 2 bit danno 4 info, 3 bit ne danno 8, la formula di base è nbit^2
# Le immagini dei satelliti ad 8 bit vanno da 0 a 255 (256 informazioni), l'ENSTAT utilizza immagini a 16 bit molto più pesanti. Questo concetto prende il nome di risoluzione radiometrica ci sono                  
# altri tipi di risoluzioni: la spaziale (che racchiude le info alla dimensione del pixel) e la risoluzione spettrale in cui sono contate le larghezze delle bande in cui l'immagine è registrata
                   
# Calculating the DVI (Difference Vegetation Index)
dvi1992 = m1992[[1]] - m1992[[2]] 
# alternative way of coding:
# dvi1992 = m1992$matogrosso~2219_lrg_1 - m1992$matogrosso~2219_lrg_2

# plotting the DVI
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl)

# 2006
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# dvi 2006
dvi2006 = m2006[[1]] - m2006[[2]] 
plot(dvi2006, col=cl)

# Exercise: plot the dvi1992 beside the dvi2006
par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

stackdvi <- c(dvi1992, dvi2006)
pairs(stackdvi)

# Normalized Difference Vegetation Index
ndvi1992 = dvi1992 / (m1992[[1]]+m1992[[2]])
ndvi2006 = dvi2006 / (m2006[[1]]+m2006[[2]])

dev.off()
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)
