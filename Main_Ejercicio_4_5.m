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
window_t=16/1000; %duracion de la ventana
overlappercent=100*(1/3); %overlap de 33%
[window_s,step_s,step_t,num_frames,window,t,f]=Ventaneo(fs,N,window_t,overlappercent);

%% CALCULO VECTOR f0 CON METODO CEPSTRUM
[f0c]=f0_Cepstrum(senal,fs,window,window_s,step_s,num_frames);
figure(2);
plot(t,f0c);
xlabel('Tiempo (s)');
ylabel('f0');
title('F0 calculada con Cepstrum');

%% CALCULO VECTOR f0 CON METODO AUTOCORRELACION
[f0a]=f0_Autocorrelacion(senal,fs,window,window_s,step_s,num_frames);
figure(3);
plot(t,f0a);
xlabel('Tiempo (s)');
ylabel('f0');
title('F0 calculada con autocorrelación');

%% COMPARO AMBOS METODOS
figure(4);
plot(t,f0a, 'blue');
hold on;
plot(t,f0c,'red');
xlabel('Tiempo (s)');
ylabel('f0');

%% RANGO F0 ACOTADO
[f0c]=f0_Cepstrum(senal,fs,window,window_s,step_s,num_frames);
for j=1:length(f0c)
    if(f0c(j)<50)
        f0c(j)=50;
    end
    if (f0c(j)>350)
        f0c(j)=350;
    end
end
figure(5);
plot(t,f0c);
xlabel('Tiempo (s)');
ylabel('f0');
title('f0 calculada con Cepstrum. Acotada');