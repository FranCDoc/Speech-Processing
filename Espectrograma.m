function [B,f,t]=Espectrograma(senal,fs,window,step_s,window_s)

% Ventaneo con Hanning de 30ms y overlap variable en el main.
% Ventaneo con Hanning de 5ms y overlap variable en el main.

noverlap=window_s-step_s; % PARÁMETRO 
nfft=window_s; % PARÁMETRO 

[B,f,t] = spectrogram(senal,window,noverlap,nfft,fs);