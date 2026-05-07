
clear all 
load  labelfind10dataemgnew9data51.mat


% load numinclass;    % instance number of each class
% load actuallabel;    % actual label of each instance
% load predictlabel;   % predicted label of your experiments
% load decision_values; % deccision values of each instance in your classification experiments(e.g. dec_values of Libsvm)
% load nameclass;  % 1....15

nameclass={'m0','m1','m2','m3'}';
numinclass=[675;675;675;675];
% load mfcc624.mat
actuallabel=[0*ones(1,675),1*ones(1,675),2*ones(1,675),3*ones(1,675)]';
% actuallabel=[0*ones(1,675),1*ones(1,675),2*ones(1,675),3*ones(1,675)]';

m0=reshape(emglabelm0,675,1);
m1=reshape(emglabelm1,675,1);
m2=reshape(emglabelm2,675,1);
m3=reshape(emglabelm3,675,1);

% predictlabel=predictindice;
predictlabel=[m0;m1;m2;m3];

 [confusion_matrix]=compute_confusion_matrix(predictlabel,numinclass,nameclass);