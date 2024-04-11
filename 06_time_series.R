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
