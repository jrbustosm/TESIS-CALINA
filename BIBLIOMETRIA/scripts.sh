
cat ../bibliografia_tesis.bib | grep '^keyw' | awk 'BEGIN{FS="[{}]"}{print $2}' | sed -r "s/^\W+//g" | sed -r "s/\W+$//g" | sed -r "s/[,;.\"()^{}'\`’:]//g" | awk '{print tolower($0)}' | awk 'BEGIN{OFS="\n"}{$1=$1; print}' | grep -E -e"^[0-9]*[a-zA-Z][a-zA-Z']*$" | grep -v -w -f stop_words.txt | sort > keywords_count.txt

cat ../bibliografia_tesis.bib | grep '^keyw'| awk 'BEGIN{FS="[{}]"}{print $2}' | sed 's;,;\n;g' | sed -r "s/^\W+//g" | sed -r "s/\W+$//g" | awk '{print tolower($0)}' | sort > keywords_count_full.txt

cat ../bibliografia_tesis.bib | grep '^abst' | awk 'BEGIN{FS="[{}]"}{print $2}' | sed -r "s/^\W+//g" | sed -r "s/\W+$//g" | sed -r "s/[,;.\"()^{}'\`’:]//g" | awk '{print tolower($0)}' | awk 'BEGIN{OFS="\n"}{$1=$1; print}' | grep -E -e"^[0-9]*[a-zA-Z][a-zA-Z']*$" | grep -v -w -f stop_words.txt | sort > abstracts_count.txt

IFS=$(echo -en "\n\b");
for f in $(ls *.pdf); do 
	pdftotext "$f" - | cut -d" " -f1 -n | sed '/^\s*$/d' | tr '[:upper:]' '[:lower:]' | sed '/[.,;]/d' | awk '{m7=m6; m6=m5; m5=m4; m4=m3; m3=m2; m2=m1; m1=$0; if(m4=="theory" || m4=="model"){print m7,m6,m5,m4,m3,m2,m1;}}'
done

