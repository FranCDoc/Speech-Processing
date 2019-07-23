close all;clear all; clc;
%% OBTENGO LA SEÑAL EN TIEMPO
filename='./Datos/001.wav';
[senal,fs]=audioread(filename);
N=length(senal);
tsenal=(1:N)/fs;
figure(1)
plot(tsenal,senal);
xlim([0,tsenal(end)]);
xlabel('Tiempo (s)');
title('Audio');

%% VENTANEO DE LA SEÑAL
window_t=30/1000; %duracion de la ventana
overlappercent=100*(1/3); %overlap de 33%
[window_s,step_s,step_t,num_frames,window,t,f]=Ventaneo(fs,N,window_t,overlappercent);

%% Ejercicio 1
[E,A,Z]=Energia_Amplitud_CruceZ(senal,window_s,window,step_s,num_frames,t);
%Graficos
figure(2)
subplot(3,1,1);
plot(t,E);
xlabel('Tiempo (s)');
title('Energía en tiempo corto');
subplot(3,1,2);
plot(t,A);
xlabel('Tiempo (s)');
title('Amplitud en tiempo corto');
subplot(3,1,3);
plot(t,Z);
xlabel('Tiempo (s)');
title('Tasa de cruces de cero');

%% Ejercicio 2
% Banda angosta (30ms) o banda ancha (5ms). Se debe cambiar la banda de la
% ventana en window_t cuando se define el ventaneo
[B,f,t]=Espectrograma(senal,fs,window,step_s,window_s);
% Grafico
figure(3)
mesh(t,f,abs(B));
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
title ('Espectrograma');
figure(4)
contourf(t,f,abs(B));
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');