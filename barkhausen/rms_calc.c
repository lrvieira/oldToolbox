# include <stdio.h>
# include <stdlib.h>
# include <math.h>
# include <string.h>

int main (int argc, char *argv[]) {
	FILE *fp_in, *fp_out;		//file pointer
	float pri[512*512],sec[512*512];
	float rms, pmed;
	int i, j, window, step;			//i = line

//==================================================================================================================================================
	if(argc<=3){
	printf("Sintaxe: %s files.txt (Janela) (Passo)\n",argv[0]);
	exit(0);
	}
//==================================================================================================================================================

	window=atoi(argv[2]);					//atoi = ASC to Integer
	step=atoi(argv[3]);
	fp_in = fopen(argv[1], "r");
	//fp_out = fopen("hue.txt", "w");
	i=0;

	while(fscanf(fp_in,"%f %f\n", &pri[i], &sec[i])!=EOF){	//encontra o fim do arquivo (END Of File)
		i++;
		if(i==window-1) {				//quando i for igual ao tamanho da janela o prog quebra a sequencia e zera rms e pm
			rms=0;
			pmed=0;
			for(j=0;j<window;j++){			//executa a logica do rms e media para a janela atual de 1000 pontos
				rms=rms+sec[j]*sec[j];
				pmed=pmed+pri[j];
			}
			rms=sqrt(rms/j);			//j=tamanho da janela
			pmed=pmed/j;
			//fprintf(fp_out, "%f %f\n",pmed, rms);	//registra valores do rms da janela de 1000 pontos no arq de saida
			printf("%f %f\n",pmed, rms);

			for(j=step;j<window;j++){		//essa logica coloca os valores iniciais das memorias pri e sec 10 linhas adiante
				pri[j-step]=pri[j];		//passo necessario pq identifica para o programa que ele deve 'mover' a janela
				sec[j-step]=sec[j];		//o novo '0' será '10' ... o novo '1000' será '1010'
			}
			i=window-step-1;			//novo valor de i será a janela menos o passo
		}						//o prox rms acontecera 10 linhas a partir daqui
	}
	fclose(fp_in);
	//fclose(fp_out);
}

/*Esse programa executa a logica na janela de 1000 pontos que começa junto com o arquivo. Depois ele desconta 10 linhas do contador e incrementa
até chegar no tamanho da janela de 1000 pontos novamente (daqui a 10 linhas). Isso significa que ele move a janela de 10 em 10, pq ele executa o 
processo do rms sempre quando i=1000, ao fim do processo ele desconta 10 e espera i=1000 novamente. */
