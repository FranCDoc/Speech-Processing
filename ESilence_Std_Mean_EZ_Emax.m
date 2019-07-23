function [STDZ_silence,MEANE_silence,MEANZ_silence,Emax,Esilence]=ESilence_Std_Mean_EZ_Emax(senal,fs,window,window_s,step_s,num_frames)       

N100=(100/1000)*fs;
senal100=senal(1:N100); % primeros 100 ms (silencio)
Esilence=sum(senal100.^2)

num_frames100=floor((N100-window_s)/step_s)+1;

%CALCULO DE LA ENERGIA Y LOS CRUCES POR CERO PARA LOS PRIMERO 100ms
for i=0:num_frames100-1 
    comienzo=i*step_s+1; 
    frame=senal100(comienzo:comienzo+window_s-1); 

    frameW=frame.*window; 
  
    E(i+1)=sum(frameW.^2); % Energia para esa ventana
    %A(i+1)=sum(abs(frameW));
    frameWdesp=[0; frameW(1:(end-1))];    
    diff=sign(frameW)-sign(frameWdesp);   % sgn(xi(n))-sgn(xi(n-1))
    Z(i+1)=1/(2*window_s)*sum(abs(diff)); % Cantidad de cruces por cero
end
%STDE_silence=std(E);
STDZ_silence=std(Z); %desvio estandar de los cruces por cero
MEANZ_silence=mean(Z); %promedio de los cruces por cero
%suma del promedio de los cruces por cero
MEANE_silence=mean(E); %promedio de la energia

%CALCULO ENERGIA MAXIMA DE TODA LA SEÑAL
for i=0:num_frames-1 
    comienzo=i*step_s+1; 
    frame=senal(comienzo:comienzo+window_s-1);
    frameW=frame.*window; 
    E(i+1)=sum(frameW.^2);
end
Emax=max(E);