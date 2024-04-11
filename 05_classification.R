# L'algoritmo k-means provvede a calcolare la distanza tra un immagine originale strutturata in cluster per ottenere un'immagnine classificata con parti di foresta, parti di suolo nudo ecc..
# Questo ci permette di calcolare gli indici differenziati per la classificazione.

# Quantifyng land cover variability

install.packages("ggplot2")
library(ggplot2)
library(terra)
library(imageRy)

# Listing images
im.list()

# Importing data
m1992 <- im.import ( "matogrosso_l5_1992219_lrg.jpg" )

m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# All'interno dell'immagine possiamo vedere tre livelli energetici differenti, uno giallo che è il più alto, uno marroncino che è intermedio e uno nero che è il più basso dei tre
# Con im.classify noi diamo un imput di quanti clusters riusciamo a distinguere, poi il software crea tutto quando

sunc <- im.classify(sun, num_clusters=3)

# Si genera un cluster che prende dei pixel casuali selezionati dall'algoritmo, la prima classe sono i livelli più bassi, la seconda quelli intermedi e la terza sono quelli più alto
# in quello del prof la prima classe è gialla nella mia è verde

# Classificazione mato grosso, mettiamo solo due clusters uno per la foresta e uno per il suolo nudo e acqua

 m1992c <- im.classify (m1992, num_clusters=2 )

# class 1 = human
# class 2 = forest

# Da me la classe numero 1 è il suolo nudo e la classe numero due sono le foreste. Nel caso del prof sono l'opposto.

 m2006c <- im.classify (m2006, num_clusters=2 )

# class 1 = forest
# class 2 = human

# Il prossimo passaggio sarà di capire il numero di pixel di un cluster su un altro, sarà un calcolo di frequenza, da cui tireremo fuori le percentuali

f1992 <- freq(m1992c)
f1992
  layer value   count
1     1     1  304437
2     1     2 1495563

# Queste frequenza possono variare poichè il campionamento dei pixel è casuale, però si sarà sempre nell'ordine del milione e mezzo di pixel per la foresta e 300 mila pixel per il suolo nudo
# Si possono poi calcolare anche le proporzioni calcolandosi il totale e dividendolo per le frequenze

tot1992 <- ncell(m1992c)
prop1992 = f1992 / tot1992
prop1992
         layer        value     count
1 5.555556e-07 5.555556e-07 0.1691317
2 5.555556e-07 1.111111e-06 0.8308683

# Calcoliamo le percentuali 
perc1992 = prop1992 * 100

# 17% human, 83% forest

f2006 <- freq(m2006c)

# proportions
tot2006 <- ncell(m2006c)
prop2006 = f2006 / tot2006

# percentages
perc2006 = prop2006 * 100

# 1992: 17% human, 83% forest
# 2006: 55% human, 45% forest

# Ci costruiamo poi un dataset con la funzione data.frame, class saranno i nomi che userermo, y1992 e y2006 saranno le annate in cui metteremo le percentuali

class <- c("Forest", "Human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)

tabout <- data.frame(class, y1992, y2006)

tabout
   class y1992 y2006
1 Forest    83    45
2  Human    17    55

# Plottiamo con ggplot2, aes sta per aestethic, con questo creiamo uno scheletro

ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")

# Facciamolo anche per il 2006

ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")

# Cappiamo la Y per avere dei grafici più precisi, aggiungiamo dopo ogni dicitura
+ ylim(c(0,100))

# Creiamo un patchwork

p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2

