
close all
clear all
for trial=1:10;
 filename=[num2str(trial),'-ssmvep15-0 Data.cnt'];
EEG=myloadcnt(filename,39);
[M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);
T1=3000;
stim_order=0*ones(1,75);
AmpH1=0.2;AmpL1=0.1;%Curry7 EMGanalysisNew1
AmpH2=0.6;m=10;%Curry7 EMGanalysisNew2
 for i=1:75
   epo(1,1:T1)=EEG(18,locs(i):locs(i)+T1-1);
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
   Accforemg(:,trial)=m;
end
save(['Accforemg10data'],'Accforemg');

close all
clear all
% for trial=1:10;
%  filename=[num2str(trial),'-ssvep15-m1 Data.cnt'];
% EEG=myloadcnt(filename,39);
% [M,T]=size(EEG);fs=1000;
% mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);
% T1=3000;
% stim_order=1*ones(1,75);
% AmpH1=0.2;AmpL1=0.1;%Curry7 EMGanalysisNew1
% AmpH2=0.6;m=10;%Curry7 EMGanalysisNew2
%  for i=1:75
%    epo(1,1:T1)=EEG(18,locs(i):locs(i)+T1-1);
%   X=epo(1,:);
% %   RTe=epo(19,:);LMe=epo(20,:);RMe=epo(21,:);F7=epo(3,:);T7=epo(12,:);P7=epo(23,:);PO7=epo(28,:);
%   [x(i,:),Index1(i),Xiemg(i,:),c1(i,:)]=EMGanalysisNew1for15(X,AmpH1,AmpL1);
%  end
%  m=0;
% for k=1:length(locs)
%       if Index1(k)==stim_order(k);
%         m=m+1;
%       end
% end
%    Accforemg(:,trial)=m;
% end
% save(['Accforemg10datam1'],'Accforemg');
% 
% close all
% clear all
% for trial=1:10;
%  filename=[num2str(trial),'-ssvep15-m2 Data.cnt'];
% EEG=myloadcnt(filename,39);
% [M,T]=size(EEG);fs=1000;
% mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);
% T1=3000;
% stim_order=2*ones(1,75);
% AmpH1=0.2;AmpL1=0.1;%Curry7 EMGanalysisNew1
% AmpH2=0.6;m=10;%Curry7 EMGanalysisNew2
%  for i=1:75
%    epo(1,1:T1)=EEG(18,locs(i):locs(i)+T1-1);
%   X=epo(1,:);
% %   RTe=epo(19,:);LMe=epo(20,:);RMe=epo(21,:);F7=epo(3,:);T7=epo(12,:);P7=epo(23,:);PO7=epo(28,:);
%   [x(i,:),Index1(i),Xiemg(i,:),c1(i,:)]=EMGanalysisNew1for15(X,AmpH1,AmpL1);
%  end
%  m=0;
% for k=1:length(locs)
%       if Index1(k)==stim_order(k);
%         m=m+1;
%       end
% end
%    Accforemg(:,trial)=m;
% end
% save(['Accforemg10datam2'],'Accforemg');

close all
clear all
for trial=1:10;
 filename=[num2str(trial),'-ssvep15-h1 Data.cnt'];
EEG=myloadcnt(filename,39);
[M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);
T1=3000;
stim_order=1*ones(1,75);
AmpH1=0.2;AmpL1=0.1;%Curry7 EMGanalysisNew1
AmpH2=0.6;m=10;%Curry7 EMGanalysisNew2
 for i=1:75
   epo(1,1:T1)=EEG(37,locs(i):locs(i)+T1-1);
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
   Accforemg(:,trial)=m;
end
save(['Accforemg10datah1'],'Accforemg');

close all
clear all
for trial=1:10;
 filename=[num2str(trial),'-ssvep15-h2 Data.cnt'];
EEG=myloadcnt(filename,39);
[M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);
T1=3000;
stim_order=2*ones(1,75);
AmpH1=0.2;AmpL1=0.1;%Curry7 EMGanalysisNew1
AmpH2=0.6;m=10;%Curry7 EMGanalysisNew2
 for i=1:75
   epo(1,1:T1)=EEG(37,locs(i):locs(i)+T1-1);
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
   Accforemg(:,trial)=m;
end
save(['Accforemg10datah2'],'Accforemg');

