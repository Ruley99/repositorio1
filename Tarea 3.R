#Syuzhet

# Instala los paquetes:
install.packages("syuzhet")
install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("tm")

# Carga los paquetes
library(syuzhet)
library(RColorBrewer)
library(wordcloud)
library(tm)


Data_IMDB <- read_excel("C:/RStudio/Data IMDB.xlsx")
View(Data_IMDB)

df_IMDB <- data.frame(
  "Text_ES" = Data_IMDB$review_es,
  "Text_EN" = Data_IMDB$review_en
)

View(df_IMDB)
text_Cadena = df_IMDB$Text_ES

#Paso 2 tokenizar
texto_palabras <- get_tokens(text_Cadena)
head(texto_palabras)
length(texto_palabras)

#Paso 3 crear oraciones test
oraciones_vector <- get_sentences(text_Cadena)
length(oraciones_vector)

#Paso 4 Extracci?n de datos con el L?xico de Sentimientos NRC

sentimientos_df <- get_nrc_sentiment(texto_palabras, lang="spanish")

View(sentimientos_df)

summary(sentimientos_df)

