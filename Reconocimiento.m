%% Algoritmo de reconocimiento de voz
function [N1,N2]=Reconocimiento(senal,ITL,ITU,IZCT,fs,window,window_s,step_s,num_frames,E,Z)

N1=0;
while(N1==0)
    curPosm=1;
    m=1;
    while(m<=num_frames)

        Eframe=E(m); % Energia para esa ventana
        
        if Eframe>=ITL
            i=m;
            curPosi=curPosm;
            a=0;
        
            while(a==0)
                Eframe=E(i);
                if Eframe<ITL
                    m=i;
                    curPosm=curPosi;
                    a=1;
                else
                    if Eframe>=ITU
                        N1=m;
                        a=1;
                        m=num_frames+1;
                    else
                        i=i+1;
                        curPosi=curPosi + step_s;
                    end
                end
            end
        end
        m=m+1;
        curPosm=curPosm + step_s;
    end
end

Einv=[];
for (j=num_frames:-1:1)
    Einv(num_frames-j+1)=E(j);
end

N2=0;
while(N2==0)
    curPosm=1;
    m=1;
   
    while(m<=num_frames)
        Eframe=Einv(m); % Energia para esa ventana
    
        if Eframe>=ITL
            i=m;
            curPosi=curPosm;
            a=0;
        
            while(a==0)
                Eframe=Einv(i);
                if Eframe<ITL
                    m=i;
                    curPosm=curPosi;
                    a=1;
                else
                    if Eframe>=ITU
                        N2=m;
                        N2=num_frames-N2;
                        a=1;
                        m=num_frames+1;
                    else
                        i=i+1;
                        curPosi=curPosi + step_s;
                    end
                end
            end
        end
        m=m+1;
        curPosm=curPosm + step_s;
    end
end 

%nos movemos 250ms hacia atras de N1 (4000 muestras o 45 frames)
N250=(250/1000)*fs;
num_frames250=floor((N250-window_s)/step_s)+1;
umbral=floor((num_frames250*3)/25); %el paper busca superar 3 veces en 25 frames

count=0;
for j=N1:-1:N1-num_frames250
    if (Z(j)>IZCT)
        count=count+1;
        J1=j;
    end
end

if(count>=umbral)
    N1=J1;
end

count=0;
for j=N2:N2+num_frames250
    if (Z(j)>IZCT)
        count=count+1;
        J2=j;
    end
end

if(count>=umbral)
    N2=J2;
end