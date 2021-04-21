# include <stdio.h>
# include <stdlib.h>
# include <math.h>
# include <string.h>

int main (int argc, char *argv[]) {
	FILE *fpin;
	double S[256*256], x[256*256], y[256*256], z[256*256];
	double dxdS, dydS, dzdS, d2xdS, d2ydS, d2zdS, num1, num2, num3, num4, num5, num6, num7, num8, den1, den2, den3, den4;
	int i, j;

	fpin = fopen(argv[1], "r");
	i=1;

	while(fscanf(fpin,"\n%lf %lf %lf %lf", &S[i], &x[i], &y[i], &z[i])!=EOF){
		if(i==3){
			dxdS=(2*S[2]-S[2]-S[3])*x[1]/((S[1]-S[2])*(S[1]-S[3])) + (2*S[2]-S[1]-S[3])*x[2]/((S[2]-S[1])*(S[2]-S[3])) + (2*S[2]-S[1]-S[2])*x[3]/((S[3]-S[1])*(S[3]-S[2]));
			dydS=(2*S[2]-S[2]-S[3])*y[1]/((S[1]-S[2])*(S[1]-S[3])) + (2*S[2]-S[1]-S[3])*y[2]/((S[2]-S[1])*(S[2]-S[3])) + (2*S[2]-S[1]-S[2])*y[3]/((S[3]-S[1])*(S[3]-S[2]));
			dzdS=(2*S[2]-S[2]-S[3])*z[1]/((S[1]-S[2])*(S[1]-S[3])) + (2*S[2]-S[1]-S[3])*z[2]/((S[2]-S[1])*(S[2]-S[3])) + (2*S[2]-S[1]-S[2])*z[3]/((S[3]-S[1])*(S[3]-S[2]));

			d2xdS=2*x[1]/((S[1]-S[2])*(S[1]-S[3])) + 2*x[2]/((S[2]-S[1])*(S[2]-S[3])) + 2*x[3]/((S[3]-S[1])*(S[3]-S[2]));
			d2ydS=2*y[1]/((S[1]-S[2])*(S[1]-S[3])) + 2*y[2]/((S[2]-S[1])*(S[2]-S[3])) + 2*y[3]/((S[3]-S[1])*(S[3]-S[2]));
			d2zdS=2*z[1]/((S[1]-S[2])*(S[1]-S[3])) + 2*z[2]/((S[2]-S[1])*(S[2]-S[3])) + 2*z[3]/((S[3]-S[1])*(S[3]-S[2]));
			
			printf("\n%lf %lf %lf %lf %lf %lf", dxdS, dydS, dzdS, d2xdS, d2ydS, d2zdS);

			i--;
		}
		for(j=1;j<=2;j++){
		S[j]=S[j+1];
		x[j]=x[j+1];
		y[j]=y[j+1];
		z[j]=z[j+1];
		}
		i++;
	}
	fclose(fpin);
}





			//num1=pow(3*S[2],2)-2*S[2]*(S[2]+S[3]+S[4])+S[2]*S[3]+S[2]*S[4]+S[3]*S[4];
			//num2=pow(3*S[2],2)-2*S[2]*(S[1]+S[3]+S[4])+S[1]*S[3]+S[1]*S[4]+S[3]*S[4];
			//num3=pow(3*S[2],2)-2*S[2]*(S[1]+S[2]+S[4])+S[1]*S[2]+S[1]*S[4]+S[2]*S[4];
			//num4=pow(3*S[2],2)-2*S[2]*(S[1]+S[2]+S[3])+S[1]*S[2]+S[1]*S[3]+S[2]*S[3];
			//den1=(S[1]-S[2])*(S[1]*S[3])*(S[1]*S[4]);
			//den2=(S[2]-S[1])*(S[2]*S[3])*(S[2]*S[4]);
			//den3=(S[3]-S[1])*(S[3]*S[2])*(S[3]*S[4]);
			//den4=(S[4]-S[1])*(S[4]*S[2])*(S[4]*S[3]);
			//num5=6*S[2]-2*(S[2]+S[3]+S[4]);
			//num6=6*S[2]-2*(S[1]+S[3]+S[4]);
			//num7=6*S[2]-2*(S[1]+S[2]+S[4]);
			//num8=6*S[2]-2*(S[1]+S[2]+S[3]);
			
			//dxdS=num1*x[1]/den1 + num2*x[2]/den2 + num3*x[3]/den3 + num4*x[4]/den4;
			//dydS=num1*y[1]/den1 + num2*y[2]/den2 + num3*y[3]/den3 + num4*y[4]/den4;
			//dzdS=num1*z[1]/den1 + num2*z[2]/den2 + num3*z[3]/den3 + num4*z[4]/den4;

			//d2xdS=num5*x[1]/den1 + num6*x[2]/den2 + num7*x[3]/den3 + num8*x[4]/den4;
			//d2ydS=num5*y[1]/den1 + num6*y[2]/den2 + num7*y[3]/den3 + num8*y[4]/den4;
			//d2zdS=num5*z[1]/den1 + num6*z[2]/den2 + num7*z[3]/den3 + num8*z[4]/den4;
