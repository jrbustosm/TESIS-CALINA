for i in `seq 0 0`; do 
	w=$(identify symbol$i.svg | awk '{print $3}' | awk -Fx '{print $1}')
	h=$(identify symbol$i.svg | awk '{print $3}' | awk -Fx '{print $2}')
	D1=$(echo "scale=2; $w/$h" | bc)
	D2=$(echo "scale=2; 235/160" | bc)
	if (( $(echo "$D1 > $D2" |bc -l) ));
	then
		inkscape -w 235 symbol$i.svg -o symbol$i.png
	else
		inkscape -h 160 symbol$i.svg -o symbol$i.png
	fi
done
