function [confusion_matrix]=compute_confusion_matrix(predict_label,num_in_class,name_class)
%  Matlab code for computing and visulization of confusion matrix for
%  multi-classification problem
%
% input：
%   predict_label: 预测标签
%   num_in_class:  一维数组不同类别的样本个数
%   name_class:    类别的名字
% output:
%   confusion_matrix:混淆矩阵
%
num_class=length(num_in_class);

confusion_matrix=size(num_class,num_class);

for ci=1:num_class
    for cj=1:num_class
        c_start=sum(num_in_class(1:(ci-1)))+1;
        c_end=sum(num_in_class(1:ci));
       confusion_matrix(ci,cj)=size(find(predict_label(c_start:c_end)==cj-1),1)/num_in_class(ci);
       %  confusion_matrix(ci,cj)=size(find(predict_label(c_start:c_end)==cj),1)/num_in_class(ci);
    end
end
confusion_matrix = confusion_matrix;%transpose
draw_cm(confusion_matrix,name_class,num_class);

end
