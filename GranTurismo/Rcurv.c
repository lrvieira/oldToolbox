# include <stdio.h>
# include <stdlib.h>
# include <math.h>
# include <string.h>

int main (int argc, char *argv[]) {
	FILE *fpin;
	double a[2][2], b[2][2], c[2][2];
	double S, dxdS, dydS, dzdS, d2xdS, d2ydS, d2zdS, A, B, C, k, R;
	int pos;

	fpin = fopen(argv[1], "r");

	while(fscanf(fpin,"\n%lf %lf %lf %lf %lf %lf", &dxdS, &dydS, &dzdS, &d2xdS, &d2ydS, &d2zdS)!=EOF){

		//dzdS=0.0;
		//d2zdS=0.0;

		a[0][0]=dydS;
		a[0][1]=dzdS;
		a[1][0]=d2ydS;
		a[1][1]=d2zdS;

		b[0][0]=dzdS;
		b[0][1]=dxdS;
		b[1][0]=d2zdS;
		b[1][1]=d2xdS;

		c[0][0]=dxdS;
		c[0][1]=dydS;
		c[1][0]=d2xdS;
		c[1][1]=d2ydS;

		A=(a[0][0]*a[1][1])-(a[0][1]*a[1][0]);
		B=(b[0][0]*b[1][1])-(b[0][1]*b[1][0]);
		C=(c[0][0]*c[1][1])-(c[0][1]*c[1][0]);

		k=sqrt((A*A)+(B*B)+(C*C))/pow(((dxdS*dxdS)+(dydS*dydS)+(dzdS*dzdS)),(3/2));
		R=1/k;

		printf("\n%lf", R);
	}
	fclose(fpin);
}
