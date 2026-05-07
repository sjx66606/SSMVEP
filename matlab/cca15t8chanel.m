
function Acc=cca15t8chanel(EEG,T1)

[M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);
freq=[6.2,8,9.8,11.6,13.4,14.6,12.8,11,9.2,7.4,6.8,8.6,10.4,12.2,14];
load stimorder15.mat
 o7=28;
 for i=1:75
   for j=1:M-1  
        epo(j,1:T1)=EEG(j,locs(i):locs(i)+T1-1);
   end
   PO7e=epo(o7,:);PO3e=epo(o7+1,:);POZe=epo(o7+2,:);PO4e=epo(o7+3,:);PO8e=epo(o7+4,:);O1e=epo(o7+5,:);OZe=epo(o7+6,:);O2e=epo(o7+7,:);
     X=[PO3e;PO4e;PO7e;PO8e;POZe;O1e;OZe;O2e;];
% #----基线校正...带通滤波...（小波分解）---
 for k=1:size(X,1)
    base(k)=mean(X(k,:));
    EEGb(k,:)=X(k,:)-base(k);
    EEGb(k,:)=mybp(EEGb(k,:),3,40,2,45,1,10,fs);
    
%     Std(k)=std(X(k,:));EEGb(k,:)=(X(k,:)-base(k))/Std(k);
%     EEGb(k,:)=lowp(EEGb(k,:),40,50,1,10,fs); 
%     
%      [C,L]=wavedec(EEGb(k,:),6,'db3');
%      AA7(k,:)=wrcoef('a',C,L,'db3',6);
%      EEGb(k,:)=EEGb(k,:)-AA7(k,:);
 end
 X1=EEGb;
% #----CCA----
tt=(1:T1)/fs;

Y1=[sin(2*pi*freq(1)*tt);cos(2*pi*freq(1)*tt);sin(2*pi*freq(1)*2*tt);cos(2*pi*freq(1)*2*tt);];
Y2=[sin(2*pi*freq(2)*tt);cos(2*pi*freq(2)*tt);sin(2*pi*freq(2)*2*tt);cos(2*pi*freq(2)*2*tt);];
Y3=[sin(2*pi*freq(3)*tt);cos(2*pi*freq(3)*tt);sin(2*pi*freq(3)*2*tt);cos(2*pi*freq(3)*2*tt);];
Y4=[sin(2*pi*freq(4)*tt);cos(2*pi*freq(4)*tt);sin(2*pi*freq(4)*2*tt);cos(2*pi*freq(4)*2*tt);];
Y5=[sin(2*pi*freq(5)*tt);cos(2*pi*freq(5)*tt);sin(2*pi*freq(5)*2*tt);cos(2*pi*freq(5)*2*tt);];
Y6=[sin(2*pi*freq(6)*tt);cos(2*pi*freq(6)*tt);sin(2*pi*freq(6)*2*tt);cos(2*pi*freq(6)*2*tt);];
Y7=[sin(2*pi*freq(7)*tt);cos(2*pi*freq(7)*tt);sin(2*pi*freq(7)*2*tt);cos(2*pi*freq(7)*2*tt);];
Y8=[sin(2*pi*freq(8)*tt);cos(2*pi*freq(8)*tt);sin(2*pi*freq(8)*2*tt);cos(2*pi*freq(8)*2*tt);];
Y9=[sin(2*pi*freq(9)*tt);cos(2*pi*freq(9)*tt);sin(2*pi*freq(9)*2*tt);cos(2*pi*freq(9)*2*tt);];
Y10=[sin(2*pi*freq(10)*tt);cos(2*pi*freq(10)*tt);sin(2*pi*freq(10)*2*tt);cos(2*pi*freq(10)*2*tt);];
Y11=[sin(2*pi*freq(11)*tt);cos(2*pi*freq(11)*tt);sin(2*pi*freq(11)*2*tt);cos(2*pi*freq(11)*2*tt);];
Y12=[sin(2*pi*freq(12)*tt);cos(2*pi*freq(12)*tt);sin(2*pi*freq(12)*2*tt);cos(2*pi*freq(12)*2*tt);];
Y13=[sin(2*pi*freq(13)*tt);cos(2*pi*freq(13)*tt);sin(2*pi*freq(13)*2*tt);cos(2*pi*freq(13)*2*tt);];
Y14=[sin(2*pi*freq(14)*tt);cos(2*pi*freq(14)*tt);sin(2*pi*freq(14)*2*tt);cos(2*pi*freq(14)*2*tt);];
Y15=[sin(2*pi*freq(15)*tt);cos(2*pi*freq(15)*tt);sin(2*pi*freq(15)*2*tt);cos(2*pi*freq(15)*2*tt);];

        [Wx1, Wy1, r1]=cca(X1,Y1);[Wx2, Wy2, r2]=cca(X1,Y2);[Wx3, Wy3, r3]=cca(X1,Y3);[Wx4, Wy4, r4]=cca(X1,Y4);
        [Wx5, Wy5, r5]=cca(X1,Y5);[Wx6, Wy6, r6]=cca(X1,Y6);[Wx7, Wy7, r7]=cca(X1,Y7);[Wx8, Wy8, r8]=cca(X1,Y8);
        [Wx9, Wy9, r9]=cca(X1,Y9);[Wx10, Wy10, r10]=cca(X1,Y10);[Wx11, Wy11, r11]=cca(X1,Y11);[Wx12, Wy12, r12]=cca(X1,Y12);
        [Wx13, Wy13, r13]=cca(X1,Y13);[Wx14, Wy14, r14]=cca(X1,Y14); [Wx15, Wy15, r15]=cca(X1,Y15);
      
        R=[r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15];
        [a1,maxindex] = find(R==max(R(1,:)));
        result(i) = maxindex;
       
        conv_result(i)=freq(result(i));conv_stim(i)=freq(stim_order(i));
end
% myfft(PO3e,fs);myfft(X1(3,:),fs);
% myfft(O1e,fs);myfft(X1(6,:),fs);
% figure,plot(result,'*');hold on;plot(stim_order,'o');set(gca,'yticklabel',{'8Hz','13Hz','10Hz','15Hz','12Hz','9Hz','14Hz','11Hz'});
% grid on;grid minor;set(gca,'LineWidth',1);hold off;
Acc=0;
for k=1:length(locs)
    if(result(k)==stim_order(k))
        Acc=Acc+1;
    end
end
end