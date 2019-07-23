function [E,A,Z]=Energia_Amplitud_CruceZ(senal,window_s,window,step_s,num_frames,t)

% Energía, Amplitud y Cruces por 0 para cada una de las 298 frames.
E=zeros(1,num_frames); % Energia de tiempo corto 
A=zeros(1,num_frames); % Amplitud de tiempo corto
Z=zeros(1,num_frames); % Tasa de cruces por cero

% Para c/una de las frames vas a realizar las mismas operaciones
for i=0:num_frames-1 
    comienzo=i*step_s+1; 
    frame=senal(comienzo:comienzo+window_s-1); 

    frameW=frame.*window; 
  
    E(i+1)=sum(frameW.^2); % Energia para esa ventana
    A(i+1)=sum(abs(frameW)); % Amplitud para esta ventana
  
    frameWdesp=[0; frameW(1:(end-1))];    
    diff=sign(frameW)-sign(frameWdesp);   % sgn(xi(n))-sgn(xi(n-1))
    Z(i+1)=sum(abs(diff))/(2*window_s); % Cantidad de cruces por cero
end