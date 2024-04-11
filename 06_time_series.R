# Le time series sono confronti di immagini nel tempo, anche importando dati dall'esterno, molto importanti per poter svolgere il compito dell'esame; Questo è il secondo metodo per osservare
# cambiamenti nel tempo, il primo metodo era basato sulla classificazione.
# Durante la pandemia l'uomo si è dovuto fermare, e il satellite sentinel ha effettuato delle foto per vedere anche gli effetti di questo cambiamento per l'uomo
# La funzione im.plot.RGB.auto() usa le prime tre bande senza doverle stare a semplificare.
EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png")

par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

# EN01 è il bianco dei test, l'immagine è stata presa a Gennaio 2020, mentre EN13 è stata presa a Marzo 2020; 
# Creiamo un confronto basato sulla differenza tra le bande, questo più si avvicina al rosso più evidenzi il cambiamento
difEN = EN01[[1]] - EN13[[1]]
cl <- colorRampPalette(c("blue", "white", "red")) (100)
plot(difEN, col=cl)
# Il range era ad 8 bit quindi va da 0 a 255 (256 valori) quindi massimo - minimo darà 255, minimo - massimo darà -255

## Scioglimento dei ghiacci in Groenlandia
# Utilizzeremo dei proxy, una variabile più facile da misurare e utilizzare al posto di una più complessa
g2000 <- im.import("greenland.2000.tif")
g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")
clg <- colorRampPalette(c("black","blue", "white", "red")) (100)

# Il nero è perchè è più fredda la temperatura, i numeri sulla palette sono dovuti al fatto che l'immagine è a 16 bit quindi arrivano fino a 65 mila, il grafico riduce a 15mila perchè copernicus riduce

# Creiamo un par 2,2 per plottare a 4
par(mfrow=c(2,2))
plot(g2000, col=clg)
plot(g2005, col=clg)
plot(g2010, col=clg)
plot(g2015, col=clg)

# Si può anche fare come uno stack

greenland <- c(g2000, g2005, g2010, g2015)
plot(greenland, col=clg)

# Andiamo a calcolare le differenze tra il minimo livello dello stack e del massimo livello dello stack

difg = greenland [[1]] - greenland [[4]]
clh <- colorRampPalette(c("red", "white", "blue")) (100)

# Invertiamo per vedere il rosso dove è registrato un aumento di temperatura perchp sottraiamo un dato con t più basse con un dato a t più alte, quindi esce negativo

plot(difg, col=clh)

# Assegnamo ad ogni immagine una banda per creare una sovrapposizione, utilizziamo lo stack

im.plotRGB(greenland, r=1, g=2, b=4) #g2000 sul rosso, g2005 sul verde e g2015 sul blu

# La parte rossa è le zone a T più alta nel 2000, la parte verde è la T più alta del 2005 e la parte blu è la T più alta del 2015
