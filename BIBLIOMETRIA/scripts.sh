
cat ../bibliografia_tesis.bib | grep '^keyw' | awk 'BEGIN{FS="[{}]"}{print $2}' | sed -r "s/^\W+//g" | sed -r "s/\W+$//g" | sed -r "s/[,;.\"()^{}'\`’:]//g" | awk '{print tolower($0)}' | awk 'BEGIN{OFS="\n"}{$1=$1; print}' | grep -E -e"^[0-9]*[a-zA-Z][a-zA-Z']*$" | grep -v -w -f stop_words.txt | sort > keywords_count.txt

cat ../bibliografia_tesis.bib | grep '^keyw'| awk 'BEGIN{FS="[{}]"}{print $2}' | sed 's;,;\n;g' | sed -r "s/^\W+//g" | sed -r "s/\W+$//g" | awk '{print tolower($0)}' | sort > keywords_count_full.txt

cat ../bibliografia_tesis.bib | grep '^abst' | awk 'BEGIN{FS="[{}]"}{print $2}' | sed -r "s/^\W+//g" | sed -r "s/\W+$//g" | sed -r "s/[,;.\"()^{}'\`’:]//g" | awk '{print tolower($0)}' | awk 'BEGIN{OFS="\n"}{$1=$1; print}' | grep -E -e"^[0-9]*[a-zA-Z][a-zA-Z']*$" | grep -v -w -f stop_words.txt | sort > abstracts_count.txt

import nltk
nltk.download('wordnet')
from nltk.stem.wordnet import WordNetLemmatizer
lmtzr = WordNetLemmatizer()

words = [l.strip() for l in open("abstracts_count.txt").readlines()]
with open('abstracts_count_lemmatize.txt', 'w') as writer:
	for w in words:
		writer.write(lmtzr.lemmatize(w)+"\n")

words = [l.strip() for l in open("keywords_count.txt").readlines()]
with open('keywords_count_lemmatize.txt', 'w') as writer:
	for w in words:
		writer.write(lmtzr.lemmatize(w)+"\n")

IFS=$(echo -en "\n\b");
for f in $(ls *.pdf); do 
	pdftotext "$f" - | cut -d" " -f1 -n | sed '/^\s*$/d' | tr '[:upper:]' '[:lower:]' | sed '/[.,;]/d' | awk '{m7=m6; m6=m5; m5=m4; m4=m3; m3=m2; m2=m1; m1=$0; if(m4=="theory" || m4=="model"){print m7,m6,m5,m4,m3,m2,m1;}}'
done

import os
from os import path
from wordcloud import WordCloud
from matplotlib.pyplot import figure
import matplotlib.pyplot as plt
import matplotlib.colors as colors
import numpy as np
from collections import Counter

def truncate_colormap(cmap, minval=0.0, maxval=1.0, n=100):
    new_cmap = colors.LinearSegmentedColormap.from_list(
        'trunc({n},{a:.2f},{b:.2f})'.format(n=cmap.name, a=minval, b=maxval),
        cmap(np.linspace(minval, maxval, n)))
    return new_cmap

for f in ["keywords_count_full", "abstracts_count_lemmatize", "teoriasYmodelos.sort"]:
	cmap = plt.get_cmap('Greys')
	new_cmap = truncate_colormap(cmap, 0.0, 0.7)
	word_freq = Counter([l.strip() for l in open(f + ".txt").readlines()])
	wordcloud = WordCloud(collocations=False, width=1800, height=1200, colormap=new_cmap).generate_from_frequencies(word_freq)
	plt.axis("off")
	plt.imshow(wordcloud, interpolation='bilinear')
	plt.savefig(f + ".png", dpi=300, bbox_inches='tight')
