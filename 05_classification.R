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

