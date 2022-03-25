clear;
clc;
load dataset0\iris
[X0,T,n,d]=readData(iris(1:100,:));
c=size(unique(T),1);
X0=normalize(X0);
Class=unique(T);
%% _______________________________________partition Dataset

 [X_train,y_train,X_unlabeled,y_unlabeled,X_test,y_test,train_set,remain]=split_Data(X0,T);
% [X_train,y_train,X_unlabeled,y_unlabeled,X_test,y_test,train_set,remain]=split_Data_multi(X0,T);
%% %_______________________________________Selecting each data point which its distance less than £
% [perdict,SVMModel]=fitcsvm_f(X_train,y_train,X_test);
%  [selectU]=disFromMargin(SVMModel,X_unlabeled);
% Acu=calculateAccuracy(perdict,y_test);
%% %________________________________________________________Density Peak & Apolnios
p=5/100;  %The number of neighbors

[peaks,nPeak,k,neighbs,rho,delta,X,Y,loc,val,center,radius]=densityPeaks(size(remain,1),p,4,remain(:,1:end-1),remain(:,end));
%% %_______________________________Self training
 [ Acu_binary]=binary_svm(X_unlabeled,center,radius,nPeak,train_set,y_test,Class);
% [ Acu_multi]=multi_Class(X_unlabeled,center,radius,nPeak,train_set,X_test,y_test,Class);
