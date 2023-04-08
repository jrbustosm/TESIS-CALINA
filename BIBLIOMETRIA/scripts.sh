
cat ../bibliografia_tesis.bib | grep '^keyw' | awk 'BEGIN{FS="[{}]"}{print $2}' | sed -r "s/^\W+//g" | sed -r "s/\W+$//g" | sed -r "s/[,;.\"()^{}'\`’:]//g" | awk '{print tolower($0)}' | awk 'BEGIN{OFS="\n"}{$1=$1; print}' | grep -E -e"^[0-9]*[a-zA-Z][a-zA-Z']*$" | grep -v -w -f stop_words.txt | sort > keywords_count.txt

cat ../bibliografia_tesis.bib | grep '^keyw'| awk 'BEGIN{FS="[{}]"}{print $2}' | sed 's;,;\n;g' | sed -r "s/^\W+//g" | sed -r "s/\W+$//g" | awk '{print tolower($0)}' | sort > keywords_count_full.txt

cat ../bibliografia_tesis.bib | grep '^abst' | awk 'BEGIN{FS="[{}]"}{print $2}' | sed -r "s/^\W+//g" | sed -r "s/\W+$//g" | sed -r "s/[,;.\"()^{}'\`’:]//g" | awk '{print tolower($0)}' | awk 'BEGIN{OFS="\n"}{$1=$1; print}' | grep -E -e"^[0-9]*[a-zA-Z][a-zA-Z']*$" | grep -v -w -f stop_words.txt | sort > abstracts_count.txt

