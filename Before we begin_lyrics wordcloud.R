# Load library
library(tidyverse)
library(tm)
library(wordcloud)
library(RColorBrewer)


# Set directory
setwd("../Desktop/덕질/data")

# Load Data
bwb_lyrics <- read.csv("Before we begin_lyrics.csv", encoding = 'UTF-8')

# Create text vector
text <- bwb_lyrics$Lyrics
# Create corpus
corpus <- VCorpus(VectorSource(text))

# Clean corpus
corpus <- corpus %>% 
  tm_map(removePunctuation) %>% 
  tm_map(stripWhitespace) %>% 
  tm_map(content_transformer(tolower)) %>% 
  tm_map(removeWords, c(stopwords("english"), "don’t"," ’ll", " ’re", "whoo")) %>% 
  tm_map(PlainTextDocument)

# Create tdm
tdm <- TermDocumentMatrix(corpus)
matrix <- as.matrix(tdm)

wordFreq <- sort(rowSums(matrix), decreasing = T)

# Set font
library(extrafont)
font_import()
loadfonts(device="win")
windowsFonts(yoondo=windowsFont("Yoon 초록우산어린이"))

# Create wordcloud
set.seed(881117)
dev.new(width = 1000, height = 1000, unit = "px")
wordcloud(words=names(wordFreq), freq=wordFreq,
          scale=c(10,.5),
          min.freq = 15,
          colors = brewer.pal(8,"Dark2"), family='yoondo',
          random.order = F)

