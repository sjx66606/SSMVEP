function label=labelfindforemg(EEG,T1,t7,stim_order)

[M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);

AmpH1=0.4;AmpL1=0.25;%Curry7 EMGanalysisNew1
%AmpH1=0.55;AmpL1=0.3;%Curry7 EMGanalysisNew1%standard
% AmpH2=0.6;m=10;%Curry7 EMGanalysisNew2
 for i=1:75
   epo(1,1:T1)=EEG(t7,locs(i):locs(i)+T1-1);
  X=epo(1,:);
%   RTe=epo(19,:);LMe=epo(20,:);RMe=epo(21,:);F7=epo(3,:);T7=epo(12,:);P7=epo(23,:);PO7=epo(28,:);
  [x(i,:),Index1(i),Xiemg(i,:),c1(i,:)]=EMGanalysisNew1for15(X,AmpH1,AmpL1);
 label=Index1;
end




