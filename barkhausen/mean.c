# include <stdio.h>
# include <stdlib.h>
# include <math.h>
# include <string.h>

FILE *fp_int;
int main (int argc, char *argv[]){
									//file pointer
	float pri[512*512],sec[512*512],colx,coly;
        int i,k,N;							//l=linha	F=aux	a=numero de argumentos
	
	for(k=1;k<argc;k++){						//abre todos os arquivos do argumento
	fp_int=fopen(argv[k],"r");

		i=0;
		while(fscanf(fp_int, "%f %f", &colx, &coly )!=EOF){
		pri[i]=pri[i]+colx;
		sec[i]=sec[i]+coly;
		i++;
		}
	fclose(fp_int);
	N=i;
	}

	for(i=0;i<N;i++) printf ("%f %f\n",pri[i]/(argc-1),sec[i]/(argc-1));
}












