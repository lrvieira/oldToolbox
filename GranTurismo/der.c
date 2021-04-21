# include <stdio.h>
# include <stdlib.h>
# include <math.h>
# include <string.h>
#define pi 3.14159265

int main (int argc, char *argv[]) {
	FILE *fp_in;			//file pointer
	float gps_long[512*512], gps_lat[512*512];
	float time, der_gps, ang, den;
	int i, dist;

	fp_in = fopen(argv[1], "r");
	fscanf(fp_in,"%f %i %f %f\n", &time, &dist, &gps_long[0], &gps_lat[0]);
	i=1;

	while(fscanf(fp_in,"%f %i %f %f\n", &time, &dist, &gps_long[i], &gps_lat[i])!=EOF){
		den=gps_long[i]-gps_long[i-1];
		if (den!=0.0){
			der_gps=(gps_lat[i]-gps_lat[i-1])/(gps_long[i]-gps_long[i-1]);
			ang=atan(der_gps)*180/pi;
			if (ang<0) ang=ang+180; //teste
			printf("%f %i %f %f %f\n", time, dist, gps_long[i], gps_lat[i], ang);
		}
		i++;
	}

	fclose(fp_in);
}
