#!/bin/bash

arq=$1
utm=$2



FMT() {
	#substitui " por 'nada' do $arq | linhas 1-16 coloca # no começo | linhas 18-fim substitui 'virgula' por 'espaço'
	#'s'=>substituir 'g'=>global (todas as ocorrencias da lina) '^'=> começo ou '^algo' '$'=>ultima linha
	#nao sei pq '/,/\ /' do ultimo comando, mas funcionou =D

	#sed -e s/'"'/''/g $arq | sed -e 1,16s/^/#/ | sed -e '18,$s/,/\ /g' > $arq.fmt.tmp

	sed '1,18d' $arq | sed s/'"'/''/g | sed '1,$s/,/\ /g' > $arq.fmt.tmp

	if [ "$utm" = "" ]; then
		awk '{print $16 " " $17}' $arq.fmt.tmp > $arq.lonlat
	else
		paste -d" " $arq.fmt.tmp $utm > $arq.utm
		rm -rf *.lonlat
	fi

	rm -rf *tmp

	#Converter lonlat->utm http://www.zonums.com/online/coords/cotrans.php?module=13  Zona 31
}
FMT



#DAQUI PRA FRENTE SÓ ARQUIVOS .utm

PAR() {

	#./deleta $arq.tmp > $arq.edi.tmp
	#./media $arq.tmp > $arq.mean.tmp

	awk '{print $20 " " $21 " " $18}' $arq.utm > col.dis.utm.tmp
	./disutm col.dis.utm.tmp > col.dis.xyz.tmp
	awk '{print $1}' col.dis.xyz.tmp > dis.tmp
	./Lagrange col.dis.xyz.tmp > der.lag.tmp
	#awk '{if(l++>20) print $1 " " $2 " " $3 " " $4 " " $5 " " $6}' der.lag.tmp > der.lag.fmt.tmp
	./Rcurv der.lag.tmp > rcurv.tmp
	paste -d" " $arq.utm dis.tmp der.lag.tmp rcurv.tmp | sed -e '1d' > $arq.rcurv

	#./derDC2 col.dis.xyz.tmp > col.der.tmp
	#./derDC4 col.dis.xyz.tmp > col.der.tmp
	#./derDC6 col.dis.xyz.tmp > col.der.tmp

	#awk '{print $1}' col.der.tmp > col1.tmp
	#awk '{print $2}' col.der.tmp > col2.tmp
	#awk '{print $3}' col.der.tmp > col3.tmp
	#awk '{print $4}' col.der.tmp > col4.tmp
	#awk '{print $5}' col.der.tmp > col5.tmp
	#awk '{print $6}' col.der.tmp > col6.tmp
	#awk '{print $7}' col.der.tmp > col7.tmp
	#~/bin2/./low121 -V0 -i2 col5.tmp > dx.low.tmp
	#~/bin2/./low121 -V0 -i2 col6.tmp > dy.low.tmp
	#~/bin2/./low121 -V0 -i2 col7.tmp > dz.low.tmp
	#paste -d" " col1.tmp col2.tmp col3.tmp col4.tmp dx.low.tmp dy.low.tmp dz.low.tmp > der.tmp

	#./der2DC2 col.der.tmp > der2.tmp
	#./der2DC4 col.der.tmp > der2.tmp
	#./der2DC6 col.der.tmp > der2.tmp

	#awk '{print $1 " " $5 " " $6 " " $7 " " $8 " " $9 " " $10}' der2.tmp > der2.fmt.tmp
	#./Rcurv der2.fmt.tmp > col.curv.tmp
	#./Rcurv2 der2.fmt.tmp > col.curv.tmp
	#paste -d" " $arq.utm der2.fmt.tmp col.curv.tmp | sed -e '1d' > $arq.curv

	rm -rf *tmp
	rm -rf $arq.utm
}
PAR




TAN() {


	awk '{if (line++>17) print $1 " " $2 " "  $16 " " $17}' $arq.dplot > $arq.tmp
	./der $arq.tmp > $arq.der.tmp
	awk '{print $5}' $arq.der.tmp > col5.tmp
	~/bin2/./low121 -V0 -i100 col5.tmp > col5.low.tmp
	paste -d " " $arq.der.tmp col5.low.tmp > $arq.tan2
	
	rm -rf *tmp
}
#TAN




RCV() {

	awk '{print $20 " " $21 " " $18}' $arq.utm > col.dis.utm.tmp
	./disutm col.dis.utm.tmp > col.dis.xyz.tmp

	sed -e 's/,/./g' $arq.coefx | awk '{print $3 " " $2*2}' > coefx.tmp
	sed -e 's/,/./g' $arq.coefy | awk '{print $3 " " $2*2}' > coefy.tmp
	sed -e 's/,/./g' $arq.coefz | awk '{print $3 " " $2*2}' > coefz.tmp

	./raio coefx.tmp coefy.tmp coefz.tmp > raiocurv.tmp
	awk '{print $1}' col.dis.xyz.tmp > pos.tmp
	paste -d" " $arq.utm pos.tmp coefx.tmp coefy.tmp coefz.tmp raiocurv.tmp > $arq.rcurv

	./

	rm -rf *tmp


}
#RCV













#gnuplot 
#set palette defined (0 "black", 0.25 "blue", 0.5 "red", 0.75 "yellow", 1 "green")
#gnuplot> splot 'gt6.teste.txt.dplot' u 16:17:18 w p palette pt 6 ps 0.1

#unset border
#set polar
#set angles degrees
#set grid polar 20
#set size square
#plot 'data.dat' u ang:dist w l



