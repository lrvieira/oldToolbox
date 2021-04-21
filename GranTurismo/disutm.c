# include <stdio.h>
# include <stdlib.h>
# include <math.h>
# include <string.h>

int main (int argc, char *argv[]) {
	FILE *fpin;
	double x[512*512], y[512*512], z[512*512];
	double dist, dxyz;
	int i, f;

	fpin = fopen(argv[1], "r");
	dist=0.0;
	i=0;

	while(fscanf(fpin,"%lf %lf %lf\n", &x[i], &y[i], &z[i])!=EOF){
		i++;
	}

	f=i;
	fclose(fpin);

	for(i=0;i<f-1;i++){
		dxyz=sqrt(pow((x[i+1]-x[i]),2)+pow((y[i+1]-y[i]),2)+pow((z[i+1]-z[i]),2));
		dist=dist+dxyz;
		printf("\n%lf %lf %lf %lf", dist, x[i], y[i], z[i]);
	}
}
