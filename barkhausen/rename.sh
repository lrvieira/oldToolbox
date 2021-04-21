#!/bin/bash

path=~/Documents/BIC-CNPq/Processing/rename
path2=~/Documents/BIC-CNPq/Processing/renamed

Erro_Processo() {                  #P11 -> P10
for arq in $path/*.lvm
	do
		part1=$(echo $arq | cut -d'/' -f7 | cut -d'.' -f-1,2)
		part2=$(echo $arq | rev | cut -d'.' -f-1,2,3 | rev)
		#echo "$part1.P11.$part2"
		mv $path/$part1.P11.$part2 $path2/$part1.P10.$part2 
	done
}
#Erro_Processo

Erro_Drill() {                  #dirll -> drill
for arq in $path/*.lvm
	do
		part1=$(echo $arq | cut -d'/' -f8 | rev | cut -d'.' -f-1,2,3,4,5 | rev)
		#echo drill.$part1
		mv $path/dirll.$part1 $path2/drill.$part1
	done
}
#Erro_Drill

