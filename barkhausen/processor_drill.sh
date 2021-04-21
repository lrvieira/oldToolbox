#!/bin/bash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~NOVO PROGRAMA - DRILL~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

arq=$1
name=$(echo $arq | cut -d'_' -f1)			#somente o nome do arquivo - completa depois
date=$(echo $arq | cut -d'_' -f2 | cut -d'.' -f1)	#data do arquivo
num=$(seq -w 1 10)					#sequencia de 1 a 10 do dado BN
dist='000 002 004 006 008 010 020 035 055 080 110'	#sequencia das distancias em relacao a ponta
tipo='.EA. .EB.'


#=====================================================================================================================================================
BN_formatter() {
unrar x "$arq" "temporario/"
echo -e "Formatter"
	for ntipo in $tipo; do
		for ndist in $dist; do
			echo -en "$ntipo$ndist \033[0m"
			for nnum in $num; do
				#echo -n BNf $name$ntipo$ndist"_"$nnum
				awk '{print $1" "$2}' temporario/$name$ntipo$ndist"_"$nnum.lvm > temporario/$name$ntipo$ndist"_"$nnum.txt
				rm -rf temporario/$name$ntipo$ndist"_"$nnum.lvm
			done
		echo -e "............................................... OK"
		done
	done
echo -e "FORMATTER............................................................ OK\n"
}
BN_formatter
#=====================================================================================================================================================


#=====================================================================================================================================================
RMS() {
for ntipo in $tipo; do
	for ndist in $dist; do
		for nnum in $num; do
			echo -n RMS $name$ntipo$ndist"_"$nnum
			./rms_calc temporario/$name$ntipo$ndist"_"$nnum.txt 1000 10 > temporario/$name$ntipo$ndist"_"$nnum.rms.txt	#janela passo
			echo ............................................... OK
		done
	done
done
echo -e "RMS.................................................................. OK\n"
}
RMS
#=====================================================================================================================================================


#=====================================================================================================================================================
MED() {
for ntipo in $tipo; do
	for ndist in $dist; do
		files=$(
			for nnum in $num; do
				echo -n temporario/$name$ntipo$ndist"_"$nnum.rms.txt" "
			done
			)
		echo -n MED $name$ntipo$ndist"_"$date
		./mean $files > temporario/$name$ntipo$ndist"_"$date.rms.med.txt			#alimentar com 10 arquivos por vez
		echo ............................................... OK
	done
done
echo -e "MED.................................................................. OK\n"
}
MED
#=====================================================================================================================================================


#=====================================================================================================================================================
LOW() {
for ntipo in $tipo; do
	for ndist in $dist; do
		echo -n $name$ntipo$ndist"_"$date
		awk '{print $1}' temporario/$name$ntipo$ndist"_"$date.rms.med.txt > temporario/col1.tmp
		awk '{print $2}' temporario/$name$ntipo$ndist"_"$date.rms.med.txt > temporario/col2.tmp
		~/bin2/./low121 -V0 -i3000 temporario/col1.tmp > temporario/col1.low.tmp
		~/bin2/./low121 -V0 -i3000 temporario/col2.tmp > temporario/col2.low.tmp
		paste -d " " temporario/col1.low.tmp temporario/col2.low.tmp > $name$ntipo$ndist"_"$date.rms.med.low.txt
		rm -rf temporario/*tmp
		echo ........................................... OK
	done
done
echo -e "LOW.................................................................. OK\n"
}
LOW
#=====================================================================================================================================================


#=====================================================================================================================================================
RMV() {
rm -rf temporario/
}
RMV
#=====================================================================================================================================================


##CONTAR NUMERO DE ARQUIVOS E JOGAR NA MEMORIA DA SEQUENCIA - PROCESSAR TODOS
## LST=$(ls -1 | wc -l) - diretorio atual  ls -1 -> lista um arquivo em cada linha.  wc -l -> conta todas as linhas
## NUM=$(seq -w 1 $LST)





