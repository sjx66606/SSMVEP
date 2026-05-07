
clear all 
load  labelfind10dataemgnew51.mat


% load numinclass;    % instance number of each class
% load actuallabel;    % actual label of each instance
% load predictlabel;   % predicted label of your experiments
% load decision_values; % deccision values of each instance in your classification experiments(e.g. dec_values of Libsvm)
% load nameclass;  % 1....15

nameclass={'m0','m1','m2','m3'}';
numinclass=[750;750;750;750];
load mfcc624.mat
actuallabel=[1*ones(1,750),2*ones(1,750),3*ones(1,750),4*ones(1,750)]';
% actuallabel=[0*ones(1,750),1*ones(1,750),2*ones(1,750),3*ones(1,750)]';

m0=reshape(emglabelm0,750,1);
m1=reshape(emglabelm1,750,1);
m2=reshape(emglabelm2,750,1);
m3=reshape(emglabelm3,750,1);

predictlabel=predictindice;
% predictlabel=[m0;m1;m2;m3];

 [confusion_matrix]=compute_confusion_matrix(predictlabel,numinclass,nameclass);