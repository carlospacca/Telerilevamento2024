# Per prima cosa occorre avvviare le due librerie che mi serviranno per il progetto: terra e imageRy

library(terra)

library(imageRy)

# Dato che utilizzerò delle immagini importate dal portale di Copernicus, occorre impostare una directory con la funzione setwd

setwd("C:/Users/spacc/Downloads")

# Una volta impostata la directory dalla quale R prenderà i file importiamo le sigole immagini una per una. Le immagini rappresentano la zona dell'Ecorifugio della Cicerana in Abruzzo, sono 6 immagini poichè
# ho scaricato un immagine in True Color e una in False Color per le 3 annate utilizzate, in modo da avere anche la banda 8, ovvero quella del Vicino Infrarossi (NIR).
# Per importare l'immagine sfrutto la funzione raster e procedo ad assegnare funzione e argomento ad un oggetto.

cic2020tc <- rast("CiceranaTC2020.jpg") # Si tratta dell'immagine True Color della Cicerana a Maggio 2020; R=1, G=2, B=3
cic2020fc <- rast("CiceranaFC2020.jpg") # Immagine False Color della Cicerana a Maggio 2020; NIR = 1, G=2, B=3
cic2024tc <- rast("CiceranaTC2024.jpg") # Immagine TC Cicerana Maggio 2024; R=1, G=2, B=3
cic2024fc <- rast("CiceranaFC2024.jpg") # Immagine FC Cicerana Maggio 2024; NIR = 1, G=2, B=3
cic2017tc <- rast("CiceranaTC2017.jpg") # Immagine TC Cicerana Maggio 2017; R=1, G=2, B=3
cic2017fc <- rast("CiceranaFC2017.jpg") # Immagine FC Cicerana Maggio 2017; NIR = 1, G=2, B=3

# Ora che ho importato tutte le immagini, occorre andare a creare un'immagine estraendo le bande una per una da ogni immagine, in modo da avere la banda rossa, la banda verde, la banda blu e il NIR di ogni
# immagine. All'interno delle immagini FC il NIR è la prima banda, in qunanto tramite il portale di Copernicus sono andato ad impostarla manualmente sul Rosso.

b2020r <- cic2020tc[[1]] # Banda rossa dell'immagine Cicerana del 2020
b2020g <- cic2020tc[[2]] # Banda verde dell'immagine Cicerana del 2020
b2020b <- cic2020tc[[3]] # Banda blu dell'immagine Cicerana del 2020
b2020nir <- cic2020fc[[1]] # Banda nir dell'immagine Cicerana del 2020

cic2020 <- c(b2020r, b2020g, b2020b, b2020nir) # In questo modo cic2020 avrà il la banda del rosso sull'1, la banda del verde sul 2, la banda del blu sul 3 e la banda del nir sul 4

# Ripeto la stessa operazione anche per le altre annate

b2024r <- cic2024tc[[1]] # Banda rossa dell'immagine Cicerana del 2024
b2024g <- cic2024tc[[2]] # Banda verde dell'immagine Cicerana del 2024
b2024b <- cic2024tc[[3]] # Banda blu dell'immagine Cicerana del 2024
b2024nir <- cic2024fc[[1]] # Banda nir dell'immagine Cicerana del 2024

cic2024 <- c(b2024r, b2024g, b2024b, b2024nir) # In questo modo cic2024 avrà il la banda del rosso sull'1, la banda del verde sul 2, la banda del blu sul 3 e la banda del nir sul 4

b2017r <- cic2017tc[[1]] # Banda rossa dell'immagine Cicerana del 2017
b2017g <- cic2017tc[[2]] # Banda verde dell'immagine Cicerana del 2017
b2017b <- cic2017tc[[3]] # Banda blu dell'immagine Cicerana del 2017
b2017nir <- cic2017fc[[1]] # Banda nir dell'immagine Cicerana del 2017

cic2017 <- c(b2017r, b2017g, b2017b, b2017nir)

# Per controllare le correlazioni tra le varie bande dei nostri oggetti andiamo a calcolare quelli che sono gli indici di correlazione tra le bande attraverso la funzione pairs

pairs(cic2017)

pairs(cic2020)

pairs(cic2024)

# Fatto ciò vado a creare un reticolo che mi permette di confrontare le tre immagini con i colori naturali, per controllare se a vista d'occhio si vedono delle differenze nella vegetazione.

par(mfrow=c(2,2)) # La funzione par mi peremtte di creare un reticolo, specificando mfrow con c(2,2) creo un reticolo di 2x2

im.plotRGB.auto(cic2017) # La funzione im.plotRGBauto è una funzione che plotta l'immagine seguendo il normale schema di colori RGB, ovvero con la prima banda, che in condizioni standard è il rosso, sul rosso
# la seconda banda che di norma è il verde sul verde e la terza banda che di norma è il blu sul blu

im.plotRGB.auto(cic2020)

im.plotRGB.auto(cic2024)

# Dato che l'obiettivo è quello di misurare la perdita di vegetazione del Fagus sylvatica presente nelle zone della Cicerana procedo con il calcolare i DVI di ogni annata per poi confrontarli
# Il Difference Vegetation Index, che poi normalizzerò, serve a calcolare, pur non essendo una grandezza fisica, la quantità di vegetazione viva presente in un'area basandosi sulla differenza tra
# la banda del NIR e la banda del rosso.

DVIcic2017 <- cic2017[[4]] - cic2017[[1]]
DVIcic2020 <- cic2020[[4]] - cic2020[[1]]
DVIcic2024 <- cic2024[[4]] - cic2024[[1]]

# Prima di plottare gli indici andiamo a creare una palette di colori che mi permette di vedere al meglio ciò che sto analizzando, utilizzerò la funzione colorRampPalette per creare una nuova gamma

ccl <- colorRampPalette ( c ("beige" , "chocolate1", "darkolivegreen1", "chartreuse"))(100)

# Adesso posso plottare gli indici seguendo la colorazione appena creata con la funzione plot e aggiungendo la specifica col = ccl

plot(DVIcic2017, col=ccl)
plot(DVIcic2020, col=ccl)
plot(DVIcic2024, col=ccl)

# Fatto questo e verifcato che il DVI è stato calcolato correttamente vado a normalizzare l'indice usando la formula del NDVI ovvero REF_NIR - REF_Red / REF_NIR + REF_Red, dove REF_NIR sono i valori di 
# riflettanza della banda del NIR, e REF_red sono i valori di riflettanza della banda del Rosso. Nel nostro caso i valori in posizione 4  e 1

NDVIcic2017 <- DVIcic2017 / cic2017[[4]] + cic2017[[1]]
NDVIcic2020 <- DVIcic2020 / cic2020[[4]] + cic2020[[1]]
NDVIcic2024 <- DVIcic2024 / cic2024[[4]] + cic2024[[1]]

# Adesso creo un reticolo 2x2 in cui inserisco i plot dei vari NDVI per trare le conclusioni circa la riduzione o l'aumento della massa vegetale viva.

par(mfrow = c(3, 1))
plot(NDVIcic2017, col=ccl)
plot(NDVIcic2020, col=ccl)
plot(NDVIcic2024, col=ccl)

# Per capire però meglio, quando l'NDVI ha raggiunto i suoi valori maggiori, creo un' immagine che abbia come componenti i tre indici dei rispettivi tre anni

cicNDVI <- c(NDVIcic2017, NDVIcic2020, NDVIcic2024)

# Una volta fatto ciò plotto in RGB l'oggetto appena creato mettendo i valori del 2017 nel rosso, i valori del 2020 nel verde e quelli del 2024 nel blu, in base a quale dei tre colori è più espresso posso 
# trarre le mie conclusioni su dove e quando si è registrato un valore di NDVI maggiore.

im.plotRGB(cicNDVI, r=1, g=2, b=3)


# Si può anche ottenere un risultato simile usando il metodo della classificazione, questo prevede una selezione da parte dell'operatore del numero di livelli energetici presenti nell'immagine, al fine di 
# capirne la copertura vegetale. Questo processo può poi essere applicato per poter fare dei confronti nel tempo e vedere quanto è variata la copertura. Occorre per prima cosa lanciare il pacchetto "ggplot2"

library(ggplot2)

# Lanciato il pacchetto provvedo a dichiarare il numero di classi visibili nell'immagine attraverso la funzione im.classify e inoltre assegno la funzione con il relativo argomento ad un oggetto.

c2017 <- im.classify(cic2017, num_clusters=2) # Segno due classi poichè con una identifico la copertura vegetale e con l'altra il suolo nudo, la classe 1 sarà quella della vegetazione e la classe 2 sarà 
# quella del suolo nudo

# Si genera un cluster che prende dei pixel casuali selezionati dall'algoritmo, la prima classe sono i livelli più bassi, la seconda sono quelli più alti. Ripeto l'operazione anche per il 2024

c2024 <- im.classify(cic2024, num_clusters=2) # Classe 1 vegetazione, Classe 2 suolo nudo

# Procedo poi a calcolare il numero di pixel di un cluster su un altro, utilizzo la funzione freq, per calcolare la frequenza assoluta dei pixel di ogni classe

f2017 <- freq(c2017)

f2024 <- freq(c2024)

# Per calcolarci le frequenze assolute, occorre ottenere il numero totale di celle presenti, per questo ocorre la funzione ncell, sempre del pacchetto ggplot2, e poi dividere le frequenze assolute per il
# totale ottenuto. Calcolerò poi anche le percentuali moltiplicando il risultato ottenuto per cento.

tot2017 <- ncell(c2017)

tot2024 <- ncell(c2024)

prop2017 = f2017 / tot2017

prop2024 = f2024 / tot2024

perc2017 = prop2017 * 100

perc2024 = prop2024 * 100

# Otteniamo che le percentuali differentemente da quanto ottenuto con il risultato precedente in cui il colore blu sembrava prevalere sui tre anni, dal 2017 al 2024 le percentuali sono rimaste più o meno 
# le stesse in 7 anni.

#Possiamo calcolarci la deviazione standard dell'NDVI per poter confrontare il dato del 2017 con il dato del 2024. per farlo utilizziamo la funzione focal.

sd2017 <- focal(b2017nir, matrix(1/9, 3, 3), fun= sd)

sd2024 <- focal(b2024nir, matrix(1/9, 3, 3), fun= sd)

# Raggruppo i due risultati ottenuti con uno stack, per poi plottarli

sdstack <- c(sd2017, sd2024)

plot(sdstack, col=ccl)


# Per rendere le informazioni accessibili anche a coloro che soffronto di daltonismo, posso però plottare solo i valori DVI e NDVI.

par(mfrow = c(3,1))
plot(DVIcic2017, col=viridis(100))
plot(DVIcic2020, col=viridis(100))
plot(DVIcic2024, col=viridis(100))

par(mfrow = c(3,1))
plot(NDVIcic2017, col=viridis(100))
plot(NDVIcic2020, col=viridis(100))
plot(NDVIcic2024, col=viridis(100))
