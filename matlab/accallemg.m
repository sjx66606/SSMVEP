close all
clear;
for trial=1:9
% #----通道：'LT','RT','LM','RM','PO7','PO3','POZ','PO4','PO8','O1','OZ','O2','HVEO' 13个通道
% filename='1tar6Hz.cnt';EEG=myloadcnt(filename,11);
filename=[num2str(trial),'-ssmvep15-0 Data.cnt'];
if  trial==2;
          EEG=myloadcnt(filename,66);
           o7=53;  
     else
         EEG=myloadcnt(filename,62);
        o7=51;
end 
    t7=15;
    [M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);T1=5000;
stim_order=0*ones(1,75);
AmpH1=0.55;AmpL1=0.3;%Curry7 EMGanalysisNew1
% AmpH2=0.6;m=10;%Curry7 EMGanalysisNew2
    for i=1:75
   epo(1,1:T1)=EEG(15,locs(i):locs(i)+T1-1);
  X=epo(1,:);
%   RTe=epo(19,:);LMe=epo(20,:);RMe=epo(21,:);F7=epo(3,:);T7=epo(12,:);P7=epo(23,:);PO7=epo(28,:);
  [x(i,:),Index1(i),Xiemg(i,:),c1(i,:)]=EMGanalysisNew1for15(X,AmpH1,AmpL1);
 end
 m=0;
for k=1:length(locs)
      if Index1(k)==stim_order(k);
        m=m+1;
      end
end
   Accforemg0(:,trial)=m;
end

for trial=1:9
% #----通道：'LT','RT','LM','RM','PO7','PO3','POZ','PO4','PO8','O1','OZ','O2','HVEO' 13个通道
% filename='1tar6Hz.cnt';EEG=myloadcnt(filename,11);
filename=[num2str(trial),'-ssmvep15-m1 Data.cnt'];
if  trial==2;
          EEG=myloadcnt(filename,66);
           o7=53;  
     else
         EEG=myloadcnt(filename,62);
        o7=51;
end 
    t7=15;
    [M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);T1=5000;
stim_order=1*ones(1,75);
AmpH1=0.55;AmpL1=0.3;%Curry7 EMGanalysisNew1
% AmpH2=0.6;m=10;%Curry7 EMGanalysisNew2
    for i=1:75
   epo(1,1:T1)=EEG(15,locs(i):locs(i)+T1-1);
  X=epo(1,:);
%   RTe=epo(19,:);LMe=epo(20,:);RMe=epo(21,:);F7=epo(3,:);T7=epo(12,:);P7=epo(23,:);PO7=epo(28,:);
  [x(i,:),Index1(i),Xiemg(i,:),c1(i,:)]=EMGanalysisNew1for15(X,AmpH1,AmpL1);
 end
 m=0;
for k=1:length(locs)
      if Index1(k)==stim_order(k);
        m=m+1;
      end
end
   Accforemg1(:,trial)=m;
end

for trial=1:9
% #----通道：'LT','RT','LM','RM','PO7','PO3','POZ','PO4','PO8','O1','OZ','O2','HVEO' 13个通道
% filename='1tar6Hz.cnt';EEG=myloadcnt(filename,11);
filename=[num2str(trial),'-ssmvep15-m2 Data.cnt'];
if  trial==2;
          EEG=myloadcnt(filename,66);
           o7=53;  
     else
         EEG=myloadcnt(filename,62);
        o7=51;
end 
    t7=15;
    [M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);T1=5000;
stim_order=2*ones(1,75);
AmpH1=0.55;AmpL1=0.3;%Curry7 EMGanalysisNew1
% AmpH2=0.6;m=10;%Curry7 EMGanalysisNew2
    for i=1:75
   epo(1,1:T1)=EEG(15,locs(i):locs(i)+T1-1);
  X=epo(1,:);
%   RTe=epo(19,:);LMe=epo(20,:);RMe=epo(21,:);F7=epo(3,:);T7=epo(12,:);P7=epo(23,:);PO7=epo(28,:);
  [x(i,:),Index1(i),Xiemg(i,:),c1(i,:)]=EMGanalysisNew1for15(X,AmpH1,AmpL1);
 end
 m=0;
for k=1:length(locs)
      if Index1(k)==stim_order(k);
        m=m+1;
      end
end
   Accforemg2(:,trial)=m;
end

for trial=1:9
% #----通道：'LT','RT','LM','RM','PO7','PO3','POZ','PO4','PO8','O1','OZ','O2','HVEO' 13个通道
% filename='1tar6Hz.cnt';EEG=myloadcnt(filename,11);
filename=[num2str(trial),'-ssmvep15-m3 Data.cnt'];
if  trial==2;
          EEG=myloadcnt(filename,66);
           o7=53;  
     else
         EEG=myloadcnt(filename,62);
        o7=51;
end 
    t7=15;
    [M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);T1=5000;
stim_order=3*ones(1,75);
AmpH1=0.55;AmpL1=0.3;%Curry7 EMGanalysisNew1
% AmpH2=0.6;m=10;%Curry7 EMGanalysisNew2
    for i=1:75
   epo(1,1:T1)=EEG(15,locs(i):locs(i)+T1-1);
  X=epo(1,:);
%   RTe=epo(19,:);LMe=epo(20,:);RMe=epo(21,:);F7=epo(3,:);T7=epo(12,:);P7=epo(23,:);PO7=epo(28,:);
  [x(i,:),Index1(i),Xiemg(i,:),c1(i,:)]=EMGanalysisNew1for15(X,AmpH1,AmpL1);
 end
 m=0;
for k=1:length(locs)
      if Index1(k)==stim_order(k);
        m=m+1;
      end
end
   Accforemg3(:,trial)=m;
end

Accall=[Accforemg0',Accforemg1',Accforemg2',Accforemg3'];
