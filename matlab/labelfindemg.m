close all
clear all;

for trial=1:9;
filename=[num2str(trial),'-ssmvep15-0 Data.cnt'];
if  trial==2;
          EEG=myloadcnt(filename,66);
           o7=53;  
     else
         EEG=myloadcnt(filename,62);
        o7=51;
end 
    t7=o7;
    T1=5000;
    stim_order=0*ones(1,75);

label=labelfindforemg(EEG,T1,t7,stim_order);
 emglabelm0(trial,:)= label;
end

for trial=1:9;
filename=[num2str(trial),'-ssmvep15-m1 Data.cnt'];
if  trial==2;
          EEG=myloadcnt(filename,66);
           o7=53;  
     else
         EEG=myloadcnt(filename,62);
        o7=51;
end 
    t7=o7;
    T1=5000;
    stim_order=1*ones(1,75);

label=labelfindforemg(EEG,T1,t7,stim_order);
 emglabelm1(trial,:)= label;
end

for trial=1:9;
filename=[num2str(trial),'-ssmvep15-m2 Data.cnt'];
if  trial==2;
          EEG=myloadcnt(filename,66);
           o7=53;  
     else
         EEG=myloadcnt(filename,62);
        o7=51;
end 
    t7=24;
    T1=5000;
    stim_order=2*ones(1,75);

label=labelfindforemg(EEG,T1,t7,stim_order);
 emglabelm2(trial,:)= label;
end


for trial=1:9;
filename=[num2str(trial),'-ssmvep15-m3 Data.cnt'];
if  trial==2;
          EEG=myloadcnt(filename,66);
           o7=53;  
     else
         EEG=myloadcnt(filename,62);
        o7=51;
end 
    t7=o7;
    T1=5000;
    stim_order=3*ones(1,75);

label=labelfindforemg(EEG,T1,t7,stim_order);
 emglabelm3(trial,:)= label;
end

save(['labelfind10dataemgnew9data51'],'emglabelm0','emglabelm1','emglabelm2','emglabelm3');