#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main () 
{
	FILE *fp_in, *fp_out;
	float pri[512*512],sec[1024];
	float rms,pm,aux;
	int i, j, m;

	fp_in = fopen("BN_toro.sc.05Hz_01.lvm2", "r");
	fp_out = fopen("BN_toro.sc.05Hz_01.txt", "w");

	m=0;

	for(i=0;i<500000;i=i+10){
		rms=0;
		pm=0;
		for(j=0;j<1000;j++);{
			fscanf(fp_in,"%f %f\n", &pri[j], &sec[j])
			rms=rms+sec[j]*sec[j]
			pm=pm+pri[j];
		}
	rms=sqrt(rms/1000);
	pm=pm/1000
	fprintf(fp_out, "%f %f\n",pm, rms);

	/*for(j=10;m<1000;m++);{ //logica para dizer a linha q o programa deve comecar
		pri[j-10]=pri[j];
		sec[j-10]=sec[j];
		}*/
	
	}

	fclose(fp_in);
	fclose(fp_out);
}
