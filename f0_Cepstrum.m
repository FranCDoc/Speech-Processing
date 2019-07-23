function [f0]=f0_Cepstrum(senal,fs,window,window_s,step_s,num_frames)

Cmax=zeros(1,num_frames);
f0=zeros(1,num_frames);

curPos=1;
for i=1:num_frames % for each frame    
    frame  = senal(curPos:curPos+window_s-1);
    frameW = frame.*window;
    frameW=frameW';
    Xi=fft(frameW); 
    Xiabs=abs(Xi.^2);
    L=log(Xiabs);
    C=ifft(L).^2;
%   ni=[step_s*(i-1):step_s*(i-1) + window_s - 1]*(1/fs);
    Cmax(i)=max(C);
    f0(i)=fs/Cmax(i);
    
    curPos=curPos+step_s;
end