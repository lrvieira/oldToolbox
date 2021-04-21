#!/bin/bash

name_file=$1
PAR1=$2			#parametros: form rms med low
PAR2=$3
PAR3=$4
PAR4=$5
PAR5=$6

#-k - keep all files

NUM=$(seq -w 1 10)		#-w indica que é para completar com '0' antes dos numeros. $ indica q o comando é um vetor
name=$(echo $name_file | cut -d'_' -f-1,2)
type=$(echo $name_file | rev | cut -d'.' -f1 | rev)
date_aux=$(echo $name_file | rev | cut -d'_' -f1 | rev)
date=$(echo $date_aux | rev | cut -d'.' -f2 | rev)

	if [ "$name_file" = "-h" ]; then
		echo -e "Parameters:\n[-f] BN formatter\n[-r] RMS\n[-m] Mean\n[-s] Smoothing\n[-k] Keep files"
		exit
	fi

	if [ ! -f "$name_file" ]; then
		echo -e "There is no such file. $name_file"
		exit
	fi


#========================================================================================================================
if [ "$type" = "hst" ]; then
	awk -F, '{if (line++>23) print $1 " " $2}' $name_file > $name"_"$date.hst.txt
	awk '{print $1}' $name"_"$date.hst.txt > col1.tmp
	awk '{print $2}' $name"_"$date.hst.txt > col2.tmp
	~/bin2/./low121 -V0 -i20 col1.tmp > col1.low.tmp
	~/bin2/./low121 -V0 -i20 col2.tmp > col2.low.tmp
	paste -d " " col1.low.tmp col2.low.tmp > $name"_"$date.hst.low.txt
	rm -rf *tmp $name"_"$date.hst.txt
	exit
fi
#========================================================================================================================


#========================================================================================================================
BN_formatter() {
if [ "$PAR1" = "-f" ] || [ "$PAR2" = "-f" ] || [ "$PAR3" = "-f" ] || [ "$PAR4" = "-f" ]; then
	dirf="$name"_"$date/"
	echo "diretorio = $dirf"
	unrar x "$name_file" "$dirf"
		for n in $NUM; do
			awk '{print $1" "$2}' $name"_"$date/$name"_"$n.lvm > $name"_"$date/$name"_"$n.txt
			rm -rf $name"_"$date/$name"_"$n.lvm
		done
	echo -e "FORMATTER............................................................ OK\n"
fi
}
BN_formatter
#========================================================================================================================



#========================================================================================================================
RMS() {
if [ "$PAR1" = "-r" ] || [ "$PAR2" = "-r" ] || [ "$PAR3" = "-r" ] || [ "$PAR4" = "-r" ]; then
	for n in $NUM; do
		echo -n RMS $name"_"$n
		./rms_calc $name"_"$date/$name"_"$n.txt 1000 10 > $name"_"$date/$name"_"$n.rms.txt		#janela passo
		echo ............................................... OK
	done
fi
}
RMS
#========================================================================================================================



#========================================================================================================================
MED() {
if [ "$PAR1" = "-m" ] || [ "$PAR2" = "-m" ] || [ "$PAR3" = "-m" ] || [ "$PAR4" = "-m" ]; then
	echo -n MED $name"_"$date
	files=$(					#files é um vetor com os nomes dos arquivos
		for n in $NUM; do
		echo -n $name"_"$date/$name"_"$n.rms.txt" "
		done
		)
	./mean $files > $name"_"$date/$name"_"$date.rms.med.txt
	echo ........................................... OK
fi
}
MED
#========================================================================================================================



#========================================================================================================================
LOW() {
if [ "$PAR1" = "-s" ] || [ "$PAR2" = "-s" ] || [ "$PAR3" = "-s" ] || [ "$PAR4" = "-s" ]; then
	echo -n LOW $name"_"$date
	awk '{print $1}' $name"_"$date/$name"_"$date.rms.med.txt > $name"_"$date/col1.tmp	#OK
	awk '{print $2}' $name"_"$date/$name"_"$date.rms.med.txt > $name"_"$date/col2.tmp	#OK
	~/bin2/./low121 -V0 -i3000 $name"_"$date/col1.tmp > $name"_"$date/col1.low.tmp
	~/bin2/./low121 -V0 -i3000 $name"_"$date/col2.tmp > $name"_"$date/col2.low.tmp
	paste -d " " $name"_"$date/col1.low.tmp $name"_"$date/col2.low.tmp > $name"_"$date/$name"_"$date.rms.med.low.txt
	rm -rf $name"_"$date/*tmp
	echo ........................................... OK
fi
}
LOW
#========================================================================================================================



#========================================================================================================================
RMV() {
if [ "$PAR1" = "-k" ] || [ "$PAR2" = "-k" ] || [ "$PAR3" = "-k" ] || [ "$PAR4" = "-k" ] || [ "$PAR5" = "-k" ]; then
	echo "Files won't be erased"
else
	for n in $NUM; do
		rm -rf $name"_"$date/$name"_"$n.txt
		rm -rf $name"_"$date/$name"_"$n.rms.txt
	done
	rm -rf $name"_"$date/$name"_"$date.rms.med.txt
fi
}
RMV
#========================================================================================================================

echo -e "\nParameters [$PAR1] [$PAR2] [$PAR3] [$PAR4] [$PAR5] \ncomputer............................................................. OK\n"



##CONTAR NUMERO DE ARQUIVOS E JOGAR NA MEMORIA DA SEQUENCIA - PROCESSAR TODOS
## LST=$(ls -1 | wc -l) - diretorio atual  ls -1 -> lista um arquivo em cada linha.  wc -l -> conta todas as linhas
## NUM=$(seq -w 1 $LST)



