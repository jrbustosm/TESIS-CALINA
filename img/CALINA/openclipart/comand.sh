
#for i in `seq 1 404`; do rsvg-convert --keep-aspect-ratio -w 235 -f pdf -o item$i.pdf item$i.svg; done
for i in `seq 278 278`; do 
	w=$(identify item$i.svg | awk '{print $3}' | awk -Fx '{print $1}')
	h=$(identify item$i.svg | awk '{print $3}' | awk -Fx '{print $2}')
	D1=$(echo "scale=2; $w/$h" | bc)
	D2=$(echo "scale=2; 235/160" | bc)
	if (( $(echo "$D1 > $D2" |bc -l) ));
	then
		inkscape -w 235 item$i.svg -o item$i.png
	else
		inkscape -h 160 item$i.svg -o item$i.png
	fi
done
