 # Mutlivariate Analysis
# Spesso si lavora con centinaia di bande ed è impossibile sceglierne una su cui lavorare, per prima cosa dobbiamo ridurre le 3 dimensioni in due dimensioni, nel nostro sistema tridimensionale però
# ne esiste una quarta in cui degli oggetti che normalmente non sono relazionati tra loro lo sono, questo lo si può applicare anche nella relazione tra immagini bidimensionali
# e immagini tridimensionali, in generale due oggetti che sembrano non essere linkati in realtà lo sono in un altra direzione.
# Dali lo ha fatto con l'ipercubo, rappresentandolo come una croce
# In analisi multivariata possiamo prendere varie dimensioni che descrivono una situazione e racchiuderla in un'unica. Nel nostroc aso se prendiamo due bande che descrivono ognuna il 50% della 
# variabilità, si descrive un asse chiamato pc1 che passa per le due bande e descrive il 90% della variabilità, mentre la pc2, tangenziale alla pc1, copre solo il 10% della variabilità
# Per questo scartiamo la pc2 prendendo in analisi solo la pc1 e riducendo le due dimensioni in una sola. Noi passiamo ad un nuovo sistema di assi più ampi in modo che contenga un quantitiativo
# maggiore di dati, PC sta per principal component, utilizziamo quindi questo nuovo sistema affinchè abbiamo un range maggiore di dati.

library(terra)
library(imageRy)
library(viridis)

# Importiamo le immagini delle dolomiti, ricordiamo che le bande possiamo controllarle sul sito di sentinel, la banda 2 sarà sempre il blu, la banda 3 sarà sempre il verde, la banda 4 sarà sempre
# il rosso e la banda 8 il nir

b2 <- im.import("sentinel.dolomites.b2.tif") #blue
b3 <- im.import("sentinel.dolomites.b3.tif") #green
b4 <- im.import("sentinel.dolomites.b4.tif") #red
b8 <- im.import("sentinel.dolomites.b8.tif") #nir

sentdo <-c(b2, b3, b4, b8)
im.plotRGB(sentdo, r=4, g=3, b=2) # in questo modo abbiamo messo il nir (che ha valore 4 se preso da 1 a 4) nel rosso, il rosso nel verde e il verde nel blu. In questo sistema
# Blu = 1, Verde = 2, Rosso = 3, NIR = 4

im.plotRGB(sentdo, r=3, g=4, b=2) # in questo modo abbiamo messo il nir nel verde, l'immagine infatti è molto verde

# Calcoliamo la correlazione di Pearson di sentdo, con il comando pairs, questo ci aiuta a capire quanto le bande sono correlate tra loro, la banda del blu e quella del verde sono molto correlate
# abbiamo infatti una correlazione di circa 0,99, il verde con il rosso ha una grande correlazione molto prossima all'1, le correlazioni con il nir sono particolari.

pairs(sentdo)

# PCA
# Si tratta della Prcincipal Component Analysis, ovvero l'analisi delle Componenti Principali (traduco perchè so che hai un A2 e dall'alto del mio C1 posso darti una mano)
# con im.pca calcoliamo i valori delle componenti principali delle 4 bande. im.pca nella visualizzazione delle immagini da sempre le prime 3 del plot, nel nostro caso PC4 la esclude.

im.pca(sentdo)
pcaimage <- im.pca(sentdo)

# Ci escono i valori delle singole deviazioni standard, da qui calcoliamo la somma di tutte le sd

tot <- sum(1615.46852, 466.56130, 49.35619, 25.28757)

# Ci calcoliamo poi la percentuale di variabilità spiegata dall'asse per ogni singolo asse con un banale calcolo percentuale

1615.46852*100/tot

466.56130*100/tot

49.35619*100/tot

25.28757*100/tot

# La prima componente principale spiega circa il 70% della variabilità infatti l'immagine è molto simile all'immagine satellitare, se la compariamo alla terza dove viene spiegato circa il 2% della
# informmazione l'immagine è quasi totalmente ruore di fondo

# Plottiamo la quarta solo per il meme

plot(pcimage[[4]], col=vir)
