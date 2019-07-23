function [f0]=f0_Autocorrelacion(senal,fs,window,window_s,step_s,num_frames)

f0=zeros(1,num_frames);

curPos=1;
for i=1:num_frames % for each frame    
    R=zeros(1,length(window));
    frame  = senal(curPos:curPos+window_s-1);   % get current frame:  SEÑAL DEL TIEMPO DE FRAME  
    frameW = frame.*window;
    frameW=frameW';
    mu=mean(frameW);
    alpha=0.97;
    frameW=frameW-mu-alpha;
%    Den=sum(frameW.^2); no se tiene en cuenta para la forma 2, ya que la
%    funcion autocorr ya normaliza dividiendo por el valor maximo.
     
%     %FORMA 1
%     for k=1:length(frameW)
%         frameWk=[zeros(1,k), frameW(1:(end-k))];  
%         R(k)=sum(frameW.*frameWk);
%         R(k)=R(k)/Den;
%     end
%     kRmax=max(R);
%     f0(i)=fs/kRmax;
     
  %FORMA 2. Utilizada para el informe
  Ri=autocorr(frameW,window_s-1);
  Ri=Ri(2:length(Ri)); %se borre el primer valor del vector Ri para no terner en cuneta la autocorrelacion con lag 0.
  kRmax=max(Ri);
  f0(i)=fs/(kRmax);
    
    curPos = curPos + step_s;
end