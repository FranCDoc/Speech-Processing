close all;clear all; clc;
%% OBTENGO LA SEÑAL EN TIEMPO
filename='./Datos/001.wav';
[senal,fs]=audioread(filename); % Toda la señal (silencio + speech)
N=length(senal); 
t_orig=(1:N)/fs;
f_orig=(0:N-1)*fs/N;

%% VENTANEO LA SEÑAL
window_t=16/1000; %duracion de la ventana
overlappercent=100*(1/3); %overlap de 33%
[window_s,step_s,step_t,num_frames,window,t,f]=Ventaneo(fs,N,window_t,overlappercent);

%% CALCULO LOS PARAMETROS NECESARIOS PARA DETECTAR EL HABLA
%Energía, amplitud de tiempo corto, cruces por zero
[E,A,Z]=Energia_Amplitud_CruceZ(senal,window_s,window,step_s,num_frames,t);
%Energía máxima, Energia en el silencio (1ros 100ms), STD de los cruces por
%zero en el silencio, MEAN de la energía y los cruces por cero en el silencio
[STDZ_silence,MEANE_silence,MEANZ_silence,Emax,Esilence]=ESilence_Std_Mean_EZ_Emax(senal,fs,window,window_s,step_s,num_frames);
%Parametros umbrales para detectar habla 
[IZCT,ITL,ITU]=IZCT_ITL_ITU(window_s,window_t,STDZ_silence,MEANZ_silence,Emax,Esilence);
%Detección comienzo y fin del habla
[N1,N2]=Reconocimiento(senal,ITL,ITU,IZCT,fs,window,window_s,step_s,num_frames,E,Z);

%% SEÑAL 1 MUESTRA POR FRAME
senal=senal.';
curPos=1;
senal2=zeros(1,num_frames);
for i=1:num_frames
    senali = senal(round((2*curPos+window_s-1)/2));
    senal2(i)=senali;
    curPos=curPos+step_s;
end
senal=senal.';

%% GRAFICO TODA LA SEÑAL
figure(1)
% Señal original
subplot(3,1,1);
plot(t_orig,senal);
xlim([0,t_orig(end)]);
ylim([min(senal) max(senal)]);
xlabel('Tiempo (s)');
title('Audio');
% Habla de la señal 
subplot(3,1,2)
plot(t(N1:N2),senal2(N1:N2),'k')
xlim([0 t(end)]);
ylim([min(senal2) max(senal2)]);
xlabel('Tiempo (s)');
title('Habla de la señal')
% Rudio de la señal
subplot(3,1,3);
plot(t(1:N1),senal2(1:N1),'k',t(N2:end),senal2(N2:end),'k')
xlim([0 t(end)]);
ylim([min(senal2) max(senal2)]);
xlabel('Tiempo (s)');
title('Ruido de la señal')

%% GRAFICOS DETECCION DEL HABLA
figure(2)
% Ruido Cruces por 0
subplot(4,1,1)
plot(t(1:N1),Z(1:N1),'k',t(N2:end),Z(N2:end),'k')
xlim([0 t(end)]);
ylim([0 max(Z)]);
xlabel('Tiempo (s)');
title('Ruido: tasa de cruces por cero')
% Speach cruces por 0
subplot(4,1,2)
plot(t(N1:N2),Z(N1:N2),'k')
xlim([0 t(end)]);
ylim([0 max(Z)]);
xlabel('Tiempo (s)');
title('Habla: tasa de cruces por cero')
% Ruido energia
subplot(4,1,3)
plot(t(1:N1),E(1:N1),'k',t(N2:end),E(N2:end),'k')
xlim([0 t(end)]);
ylim([0 max(E)]);
xlabel('Tiempo (s)');
title('Ruido: energía de tiempo corto')
% Speach energia
subplot(4,1,4)
plot(t(N1:N2),E(N1:N2),'k')
xlim([0 t(end)]);
ylim([0 max(E)]);
xlabel('Tiempo (s)');
title('Habla: energía de tiempo corto')