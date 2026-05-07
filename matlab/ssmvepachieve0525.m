clear all

load  labelfind10datassmvep.mat

load  stimorder15.mat


for p = 1:10
 labeleach=labelm0(p,:);
    
for k = 1:75     
       if labeleach(k)==stim_order(k);
           predict(k)=0;
       else
           predict(k)=1;
       end 
end
 ssmveplabel0(p,:)=predict;
end


for p = 1:10
 labeleach=labelm1(p,:);
     
for k = 1:75     
       if labeleach(k)==stim_order(k) ;
           predict(k)=0;
       else
           predict(k)=1;
       end 
end
 ssmveplabel1(p,:)=predict;
end

for p = 1:10
 labeleach=labelm2(p,:);
       
for k = 1:75     
       if labeleach(k)==stim_order(k) ;
           predict(k)=0;
       else
           predict(k)=1;
       end 
end
 ssmveplabel2(p,:)=predict;
end


for p = 1:10
 labeleach=labelm3(p,:);
       
for k = 1:75     
       if labeleach(k)==stim_order(k) ;
           predict(k)=0;
       else
           predict(k)=1;
       end 
end
 ssmveplabel3(p,:)=predict;
end

save(['labelfind10datassmvep0525'],'ssmveplabel0','ssmveplabel1','ssmveplabel2','ssmveplabel3');

m0_1=[15-sum(ssmveplabel0(:,1:15),2)]/15;
m1_1=[15-sum(ssmveplabel1(:,1:15),2)]/15;
m2_1=[15-sum(ssmveplabel2(:,1:15),2)]/15;
m3_1=[15-sum(ssmveplabel3(:,1:15),2)]/15;

m0_2=[15-sum(ssmveplabel0(:,16:30),2)]/15;
m1_2=[15-sum(ssmveplabel1(:,16:30),2)]/15;
m2_2=[15-sum(ssmveplabel2(:,16:30),2)]/15;
m3_2=[15-sum(ssmveplabel3(:,16:30),2)]/15;

m0_3=[15-sum(ssmveplabel0(:,31:45),2)]/15;
m1_3=[15-sum(ssmveplabel1(:,31:45),2)]/15;
m2_3=[15-sum(ssmveplabel2(:,31:45),2)]/15;
m3_3=[15-sum(ssmveplabel3(:,31:45),2)]/15;

m0_4=[15-sum(ssmveplabel0(:,46:60),2)]/15;
m1_4=[15-sum(ssmveplabel1(:,46:60),2)]/15;
m2_4=[15-sum(ssmveplabel2(:,46:60),2)]/15;
m3_4=[15-sum(ssmveplabel3(:,46:60),2)]/15;

m0_5=[15-sum(ssmveplabel0(:,61:75),2)]/15;
m1_5=[15-sum(ssmveplabel1(:,61:75),2)]/15;
m2_5=[15-sum(ssmveplabel2(:,61:75),2)]/15;
m3_5=[15-sum(ssmveplabel3(:,61:75),2)]/15;

allassmvepachieve=[m0_1,m1_1,m2_1,m3_1;m0_2,m1_2,m2_2,m3_2;m0_3,m1_3,m2_3,m3_3;m0_4,m1_4,m2_4,m3_4;m0_5,m1_5,m2_5,m3_5;];

