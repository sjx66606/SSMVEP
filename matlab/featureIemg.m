close all
clear;
for trial=1:9
filename=[num2str(trial),'-ssmvep15-0 Data.cnt'];
if  trial==2;
          EEG=myloadcnt(filename,66);
           o7=53;  
     else
         EEG=myloadcnt(filename,62);
        o7=51;
end 
    t7=o7;
    [M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);T1=5000;
stim_order=0*ones(1,75);
    for i=1:75
   epo(1,1:T1)=EEG(t7,locs(i):locs(i)+T1-1);
  X=epo(1,:);
L1=length(X);t=(1:L1)/fs;
X=(X-mean(X))/std(X);
x=mybp(X,90,180,80,190,1,20,fs);
window=50;
m=floor(L1/window);
for nn=1:m
    Xepo(nn,:)=x((nn-1)*window+1:nn*window);
    Xiemg(nn)=sum(abs(Xepo(nn,:)))/length(Xepo(nn,:));
%     Xrms(i)=sqrt(sum(Xepo(i,:).^2)/length(Xepo(i,:)));
end
    iemg=smooth(Xiemg,10);
iemg=smooth(iemg,5);
    end
 Iemg(i,:)=iemg;
   feature0(1+75*(trial-1):75*trial,:)=Iemg;
end

for trial=1:9
filename=[num2str(trial),'-ssmvep15-m1 Data.cnt'];
if  trial==2;
          EEG=myloadcnt(filename,66);
           o7=53;  
     else
         EEG=myloadcnt(filename,62);
        o7=51;
end 
    t7=o7;
    [M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);T1=5000;
stim_order=0*ones(1,75);
    for i=1:75
   epo(1,1:T1)=EEG(t7,locs(i):locs(i)+T1-1);
  X=epo(1,:);
L1=length(X);t=(1:L1)/fs;
X=(X-mean(X))/std(X);
x=mybp(X,90,180,80,190,1,20,fs);
window=50;
m=floor(L1/window);
for nn=1:m
    Xepo(nn,:)=x((nn-1)*window+1:nn*window);
    Xiemg(nn)=sum(abs(Xepo(nn,:)))/length(Xepo(nn,:));
%     Xrms(i)=sqrt(sum(Xepo(i,:).^2)/length(Xepo(i,:)));
end
iemg=smooth(Xiemg,10);
iemg=smooth(iemg,5);
    end
 Iemg(i,:)=iemg;
   feature1(1+75*(trial-1):75*trial,:)=Iemg;
end
for trial=1:9
filename=[num2str(trial),'-ssmvep15-m2 Data.cnt'];
if  trial==2;
          EEG=myloadcnt(filename,66);
           o7=53;  
     else
         EEG=myloadcnt(filename,62);
        o7=51;
end 
    t7=o7;
    [M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);T1=5000;
stim_order=0*ones(1,75);
    for i=1:75
   epo(1,1:T1)=EEG(t7,locs(i):locs(i)+T1-1);
  X=epo(1,:);
L1=length(X);t=(1:L1)/fs;
X=(X-mean(X))/std(X);
x=mybp(X,90,180,80,190,1,20,fs);
window=50;
m=floor(L1/window);
for nn=1:m
    Xepo(nn,:)=x((nn-1)*window+1:nn*window);
    Xiemg(nn)=sum(abs(Xepo(nn,:)))/length(Xepo(nn,:));
%     Xrms(i)=sqrt(sum(Xepo(i,:).^2)/length(Xepo(i,:)));
end
iemg=smooth(Xiemg,10);
iemg=smooth(iemg,5);
    end
 Iemg(i,:)=iemg;
   feature2(1+75*(trial-1):75*trial,:)=Iemg;
end
for trial=1:9
filename=[num2str(trial),'-ssmvep15-m3 Data.cnt'];
if  trial==2;
          EEG=myloadcnt(filename,66);
           o7=53;  
     else
         EEG=myloadcnt(filename,62);
        o7=51;
end 
    t7=o7;
    [M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);T1=5000;
stim_order=0*ones(1,75);
    for i=1:75
   epo(1,1:T1)=EEG(t7,locs(i):locs(i)+T1-1);
  X=epo(1,:);
L1=length(X);t=(1:L1)/fs;
X=(X-mean(X))/std(X);
x=mybp(X,90,180,80,190,1,20,fs);
window=50;
m=floor(L1/window);
for nn=1:m
    Xepo(nn,:)=x((nn-1)*window+1:nn*window);
    Xiemg(nn)=sum(abs(Xepo(nn,:)))/length(Xepo(nn,:));
%     Xrms(i)=sqrt(sum(Xepo(i,:).^2)/length(Xepo(i,:)));
end
iemg=smooth(Xiemg,10);
iemg=smooth(iemg,5);
    end
 Iemg(i,:)=iemg;
   feature3(1+75*(trial-1):75*trial,:)=Iemg;
end

save(['featureemg750enew9'],'feature0','feature1','feature2','feature3')