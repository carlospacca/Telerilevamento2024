# Misurare la variabilità dello spazio
# Per misurare la varianza occorre prendere un campione, ed estrarne la media, si prendono poi i singoli dati che hanno composto la media e si sottraggono ad essa ottenendo lo scarto
# portando questa differenza al quadrato e poi dividendo per il numero del capione meno uno e portando tutto sotto radice, di ottiene la deviazione standard. La deviazione standard è molto
# sensibile a dati estremi, sia aggiungendo un dato più piccolo che un dato molto più grande.

install.packages("viridis")
library(viridis)

im.list()

#Utilizziamo un'immagine chiamata sentinel.png

sent <- im.import("sentinel.png")

# plottiamo con lo schema di colori 

im.plotRGB(sent, r=1, g=2, b=3)

# Nir = banda 1
# Red = banda 2
# Green = banda 3

# Utilizzando l'immagine principale come base, creiamo una finestra mobile più ristretta in cui estraiamo un 3x3 di pixel e calcoliamo la variabilità di quei pixel per poi ripoortarlo sul pixel centrale
# se l'azione viene ripetuta più  di una volta ottengo un immagine formata da tutti pixel che hanno svolto il ruolo di pixel centrale e quindi un immagine con i valori di deviazione standard
# di varie finestre mobili, ottenendo una mappa della variabilità

# La deviazione standard si calcola solo su una variabile, nel nostro caso su una sola banda, la banda più bella di tutte è sempre la NIR che nel nostro caso è la banda 1 

nir <- sent [[1]]

# Per visualizzarla la plottiamo con 

plot (nir)

# La coloriamo con colori diversi usando colorRampPalette

colorRampPalette(c("red", "orange", "yellow"))(100)
cl <- colorRampPalette(c("red", "orange", "yellow"))(100)

plot(nir, col=cl)

# FUNZIONE FOCAL = Tira fuori delle statistiche, dei valori focali da una variabile, quindi media, varianza, deviazione standard, ecc...
# Per urilizzarla occorre creare una matrice, nel nostro caso la matrice sarà di 1/9 perchè prendiamo 9 valori e dev'essere di 3x3, aggiungendo fun=sd tra tutte le funzioni di Focal otteniamo la
# deviazione standard

sd3 <- focal(nir, matrix(1/9, 3, 3), fun =sd)
plot(sd3)

# Dato che i colori sono fastidiosi per i daltonici, usiamo il pacchetto viridis per renderlo meglio visibile anche a loro. Usiamo una colorRampPalette con viridis, il 7 serve per la legenda

viridisc <- colorRampPalette(viridis(7))(100)
plot(sd3, col=viridisc)

# Vediamo in questo modo la variabilità più alta nelle zone verde-verde chiaroc e la deviazione standard nelle varie divisioni 3x3

# calculate the sd mw of 7 pixels

sd7 <- focal(nir, matrix(1/49, 7, 7)
plot(sd7)
plot(sd7, col=viridisc)

# Lo famo anche a 13 perchè semo matti
sd13 <- focal(nir, matrix(1/169, 13, 13)
plot(sd13)
plot(sd13, col=viridis)             

# Facciamo uno stack delle tre sd e plottiamo che siamo fighissimi
sdstack <- c(sd3, sd7, sd13)
plot(sdstack, col=viridisc)

# Analisi multivariata
# Prendiamo come esempio due bande la banda 1 e la banda 2 e prendendo il riferimento dei pixel plottiamo una banda rispetto all'altra. Il primo asse spiega gran parte della varianza, poichè 
# spigea il 90% di questa
# Invece di scegliere il nir scegliamo il primo asse chiamato pc1 perchè è più rappresentativo in caso di multivariata. La correlazione che misura è quella di Perason che va da -1 ad 1.
