 clear all
 for trial=1:9
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
    for i=1:75
   epo(1,1:T1)=EEG(t7,locs(i):locs(i)+T1-1);
  X=epo(1,:);
L1=length(X);t=(1:L1)/fs;
X=(X-mean(X))/std(X);
x=mybp(X,90,180,80,190,1,20,fs);
w='M';
nc=13; 
p=floor(3*log(fs)); 
n=pow2(floor(log2(0.03*fs))); 
inc=floor(n/2);
fl=0;
fh=0.5;
[c,tc]=melcepst(x,fs,w,nc,p,n,inc,fl,fh); 
ff(i,:)=mean(c,2);
end
feature0(1+75*(trial-1):75*trial,:)=ff;
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
    t7=15;
    [M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);T1=5000;
stim_order=0*ones(1,75);
    for i=1:75
   epo(1,1:T1)=EEG(t7,locs(i):locs(i)+T1-1);
  X=epo(1,:);
L1=length(X);t=(1:L1)/fs;
X=(X-mean(X))/std(X);
x=mybp(X,90,180,80,190,1,20,fs);
w='M';
nc=13; 
p=floor(3*log(fs)); 
n=pow2(floor(log2(0.03*fs))); 
inc=floor(n/2);
fl=0;
fh=0.5;
[c,tc]=melcepst(x,fs,w,nc,p,n,inc,fl,fh); 
ff(i,:)=mean(c,2);
end
feature1(1+75*(trial-1):75*trial,:)=ff;
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
    t7=15;
    [M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);T1=5000;
stim_order=0*ones(1,75);
    for i=1:75
   epo(1,1:T1)=EEG(t7,locs(i):locs(i)+T1-1);
  X=epo(1,:);
L1=length(X);t=(1:L1)/fs;
X=(X-mean(X))/std(X);
x=mybp(X,90,180,80,190,1,20,fs);
w='M'; 
nc=13; 
p=floor(3*log(fs)); 
n=pow2(floor(log2(0.03*fs))); 
inc=floor(n/2);
fl=0;
fh=0.5;
[c,tc]=melcepst(x,fs,w,nc,p,n,inc,fl,fh); 
ff(i,:)=mean(c,2);
end
feature2(1+75*(trial-1):75*trial,:)=ff;
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
    t7=15;
    [M,T]=size(EEG);fs=1000;
mark=double(EEG(M,:));[pks,locs]=findpeaks(mark);T1=5000;
stim_order=0*ones(1,75);
    for i=1:75
   epo(1,1:T1)=EEG(t7,locs(i):locs(i)+T1-1);
  X=epo(1,:);
L1=length(X);t=(1:L1)/fs;
X=(X-mean(X))/std(X);
x=mybp(X,90,180,80,190,1,20,fs);
w='M'; 
nc=13; 
p=floor(3*log(fs)); 
n=pow2(floor(log2(0.03*fs))); 
inc=floor(n/2);
fl=0;
fh=0.5;
[c,tc]=melcepst(x,fs,w,nc,p,n,inc,fl,fh); 
ff(i,:)=mean(c,2);
end
feature3(1+75*(trial-1):75*trial,:)=ff;
    end

    save(['featureemg675mfnew13'],'feature0','feature1','feature2','feature3')