close all
clear;

clas_ind = '3';
for trial=1:9
    if trial ~=1
        clear EEGb epo;
    end
% #----通道：'LT','RT','LM','RM','PO7','PO3','POZ','PO4','PO8','O1','OZ','O2','HVEO' 13个通道
% filename='1tar6Hz.cnt';EEG=myloadcnt(filename,11);
if clas_ind ~= '0';
    read_ind = ['m' clas_ind];
else
    read_ind = clas_ind;
end
filename=[num2str(trial),'-ssmvep15-',read_ind ,' Data.cnt'];
if  trial==2;
          EEG0=myloadcnt(filename,66);
           o7=53;  
           channel_num = 65;
     else
         EEG0=myloadcnt(filename,62);
        o7=51;
        channel_num = 61;
    end 



% filename='08-ssmvep15-0 Data.cnt';
% EEG=myloadcnt(filename,62);%123data 66 53  or 62 51  %% 456789data 62 51 
%  load SSVEP15stim_freq_order20170921T131546.mat
[M,T]=size(EEG0);fs=1000;
mark=double(EEG0(M,:));[pks,locs]=findpeaks(mark);T1=5000;
%  freq=[8,13,10,15,12,9,14,11];

freq=[6.2,8,9.8,11.6,13.4,14.6,12.8,11,9.2,7.4,6.8,8.6,10.4,12.2,14];
load stimorder15.mat

 for i=1:75
   for j=1:M-1  
        epo(j,1:T1)=EEG0(j,locs(i):locs(i)+T1-1);
   end
   % PO7e=epo(o7,201:end);PO5e=epo(o7+1,201:end);PO3e=epo(o7+2,201:end);POZe=epo(o7+3,201:end);PO4e=epo(o7+4,201:end);PO6e=epo(o7+5,201:end);PO8e=epo(o7+6,201:end);O1e=epo(o7+7,201:end);OZe=epo(o7+8,201:end);O2e=epo(o7+9,201:end);   
%      X=[PO3e;PO4e;PO7e;PO8e;POZe;O1e;OZe;O2e;];
     X=epo;
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
 % ICA对数据进行处理
 EEG = pop_loadcnt(filename);
 EEG_channel=pop_chanedit(EEG, 'lookup','D:\\matlab tools\\eeglab2021.1\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc');
    EEG = pop_importdata('data', EEGb, 'setname', 'EEGData', 'srate', fs);
    EEG = eeg_checkset( EEG );
    EEG.chanlocs = EEG_channel.chanlocs(1:channel_num);
    EEG = eeg_checkset( EEG );
    EEG = eeg_checkset( EEG );
    dataRank = sum(eig(cov(double(EEG.data(:,:,1)'))) > 1E-6); % 求出数据的rank
    EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1, 'pca',30,...
        'stop',1E-7, 'interrupt','on'); % 排除眼电和非头皮上的参考电极
    
    EEG = pop_iclabel(EEG, 'default');
    EEG = eeg_checkset( EEG );
    EEG = pop_icflag(EEG, [0 0;0.9 1;0.9 1;0.9 1;0.9 1;0.9 1;0.9 1]);
    reject_idx = EEG.reject.gcompreject;
    reject_idx = reject_idx(1:30);   % 如果128导，只考虑前60个成分 如果64导，只考虑前30个成分  如果是32导，只考虑前20个成分 改成20
    reject_idx = find(reject_idx > 0);
    EEG = pop_subcomp(EEG, reject_idx);
    EEG = eeg_checkset( EEG );
    EEG = eeg_checkset( EEG );
 if i == 1
     X0 = EEG;
 else
     X0 = [X0, EEG];
 end

 save(['./dataset' clas_ind '/data'  num2str(trial)  '.mat'],'X0', 'stim_order');
 PO7e=EEGb(o7,201:end);
 PO5e=EEGb(o7+1,201:end);
 PO3e=EEGb(o7+2,201:end);
 POZe=EEGb(o7+3,201:end);
 PO4e=EEGb(o7+4,201:end);
 PO6e=EEGb(o7+5,201:end);
 PO8e=EEGb(o7+6,201:end);
 O1e=EEGb(o7+7,201:end);
 OZe=EEGb(o7+8,201:end);
 O2e=EEGb(o7+9,201:end);   
 X1 = [PO3e;PO4e;PO7e;PO8e;POZe;O1e;OZe;O2e;];
 
 
 
 
 
 
% #----CCA----
tt=(1:T1-200)/fs;

Y1=[sin(2*pi*freq(1)*tt);cos(2*pi*freq(1)*tt);sin(2*pi*freq(1)*0.5*tt);cos(2*pi*freq(1)*0.5*tt);];
Y2=[sin(2*pi*freq(2)*tt);cos(2*pi*freq(2)*tt);sin(2*pi*freq(2)*0.5*tt);cos(2*pi*freq(2)*0.5*tt);];
Y3=[sin(2*pi*freq(3)*tt);cos(2*pi*freq(3)*tt);sin(2*pi*freq(3)*0.5*tt);cos(2*pi*freq(3)*0.5*tt);];
Y4=[sin(2*pi*freq(4)*tt);cos(2*pi*freq(4)*tt);sin(2*pi*freq(4)*0.5*tt);cos(2*pi*freq(4)*0.5*tt)];
Y5=[sin(2*pi*freq(5)*tt);cos(2*pi*freq(5)*tt);sin(2*pi*freq(5)*0.5*tt);cos(2*pi*freq(5)*0.5*tt)];
Y6=[sin(2*pi*freq(6)*tt);cos(2*pi*freq(6)*tt);sin(2*pi*freq(6)*0.5*tt);cos(2*pi*freq(6)*0.5*tt)];
Y7=[sin(2*pi*freq(7)*tt);cos(2*pi*freq(7)*tt);sin(2*pi*freq(7)*0.5*tt);cos(2*pi*freq(7)*0.5*tt)];
Y8=[sin(2*pi*freq(8)*tt);cos(2*pi*freq(8)*tt);sin(2*pi*freq(8)*0.5*tt);cos(2*pi*freq(8)*0.5*tt)];
Y9=[sin(2*pi*freq(9)*tt);cos(2*pi*freq(9)*tt);sin(2*pi*freq(9)*0.5*tt);cos(2*pi*freq(9)*0.5*tt)];
Y10=[sin(2*pi*freq(10)*tt);cos(2*pi*freq(10)*tt);sin(2*pi*freq(10)*0.5*tt);cos(2*pi*freq(10)*0.5*tt)];
Y11=[sin(2*pi*freq(11)*tt);cos(2*pi*freq(11)*tt);sin(2*pi*freq(11)*0.5*tt);cos(2*pi*freq(11)*0.5*tt)];
Y12=[sin(2*pi*freq(12)*tt);cos(2*pi*freq(12)*tt);sin(2*pi*freq(12)*0.5*tt);cos(2*pi*freq(12)*0.5*tt)];
Y13=[sin(2*pi*freq(13)*tt);cos(2*pi*freq(13)*tt);sin(2*pi*freq(13)*0.5*tt);cos(2*pi*freq(13)*0.5*tt)];
Y14=[sin(2*pi*freq(14)*tt);cos(2*pi*freq(14)*tt);sin(2*pi*freq(14)*0.5*tt);cos(2*pi*freq(14)*0.5*tt)];
Y15=[sin(2*pi*freq(15)*tt);cos(2*pi*freq(15)*tt);sin(2*pi*freq(15)*0.5*tt);cos(2*pi*freq(15)*0.5*tt)];

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
 Accall(:,trial)= Acc;
 end