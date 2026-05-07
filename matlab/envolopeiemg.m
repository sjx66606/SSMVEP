
clear all
filename='3-ssmvep15-m1 Data.cnt';EEG=myloadcnt(filename,62);
[M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);T1=5000;

 i=26;
 j=51;
epo(j,1:T1)=EEG(j,locs(i):locs(i)+T1-1);
T7=epo(51,:);
x=T7;
L1=length(x);t=(1:L1)/fs;
x=(x-mean(x))/std(x);
figure
subplot(411)
plot(x);
hold on 
x=mybp(x,90,180,80,190,1,20,fs);
window=20;
m=floor(L1/window)-1;
for i=1:m
    Xepo(i,:)=x((i-1)*window+1:i*window);
    Xiemg(i)=sum(abs(Xepo(i,:)))/length(Xepo(i,:));

%     Xrms(i)=sqrt(sum(Xepo(i,:).^2)/length(Xepo(i,:)));
end
subplot(412)
plot(Xiemg);
iemg=smooth(Xiemg,10);
iemg=smooth(iemg,5);
% iemg=smooth(Xiemg,5);

hold on 



AmpH1=0.2;AmpL1=0.1;%Curry7 EMGanalysisNew1
% AmpH2=0.6;m=10;%Curry7 EMGanalysisNew2
AmpH=AmpH1;
AmpL=AmpL1;

subplot(413)
plot(iemg)
hold on 
amph=AmpH*ones(1,250);
ampl=AmpL*ones(1,250);
plot(amph,'r')
hold on
plot(ampl,'r')


for i=1:m
     c1(i)=0;  
     if (Xiemg(i)>AmpH)||((AmpL<Xiemg(i))&&(Xiemg(i)<AmpH)&&(i>1)&&(c1(i-1)==1))
        c1(i)=1;
     end

end

subplot(414)
for i=1:m-1
    diff(i)=c1(i+1)-c1(i);
end


 plot(c1);



