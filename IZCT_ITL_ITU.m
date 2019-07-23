function [IZCT,ITL,ITU]=IZCT_ITL_ITU(window_s,window_t,STDZ_silence,MEANZ_silence,Emax,Esilence)

IZC=MEANZ_silence;
IF=(window_t*25)/(10/1000);
IF=IF/(2*window_s);
%IF=25/(2*0.01*fs); %25cruces en 10ms
IZCT=min(IF,IZC + 2*STDZ_silence);

%Energías del paper
IMX=Emax;
IMN=Esilence;
I1=0.03*(IMX-IMN)+IMN; %nivel con el 30% del pico de energia (ajustada por la energia del silencio)
I2=4*IMN; %4veces la energia del silencio
ITL=min(I1,I2); %umbral minimo de energia 
ITU=2*ITL; %umbral maximo de energía