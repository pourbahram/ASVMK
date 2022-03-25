function [X_train,y_train,X_unlabeled,y_unlabeled,X_test,y_test,train_set,remain]=split_Data(X0,T)

 c=unique(T);

 dataset=[X0,T];
%split in 0/1 samples
dataset_0 = dataset(dataset(:, end) == c(1,1), :);
dataset_1 = dataset(dataset(:, end) == c(2,1), :);

%test
split_te_0 = round(length(dataset_0)*0.3);
split_te_1 = round(length(dataset_1)*0.3);
test_0 = dataset_0(1:split_te_0,:);
test_1 = dataset_1(1:split_te_1,:);
test_set = vertcat(test_0, test_1);
test_set = test_set(randperm(length(test_set)),:);
% joda sazi test az dadeha
remain=setdiff(dataset,test_set,'rows');
remain_0 = remain(remain(:, end) == c(1,1), :);
remain_1 = remain(remain(:, end) == c(2,1), :);
remain = vertcat(remain_0, remain_1);
% remain = remain(randperm(length(remain)),:);
%train
split_train_0 = round(length(remain_0)*0.1);
split_train_1 = round(length(remain_1)*0.1);
train_0 = remain_0(1:split_train_0,:);
train_1 = remain_1(1:split_train_1,:);
train_set = vertcat(train_0, train_1);
train_set = train_set(randperm(size(train_set,1)),:);

% %unlabeld
% split_train_0 = split_te_0 + round(length(winedataset_0)*0.1);
% split_train_1 = split_te_1 + round(length(winedataset_1)*0.1);
% train_0 = winedataset_0(split_te_0+1:split_train_0,:);
% train_1 = winedataset_1(split_te_1+1:split_train_1,:);
% train_set = vertcat(train_0, train_1);
% train_set = train_set(randperm(length(train_set)),:);
%unlabeled
unlabeled_0 = remain_0(split_train_0+1:end,:);
unlabeled_1 = remain_1(split_train_1+1:end,:);
unlabeled_set = vertcat(unlabeled_0, unlabeled_1);
unlabeled_set = unlabeled_set(randperm(length(unlabeled_set)),:);


%Split into X and y
X_train = train_set(:,1:end-1);
y_train = train_set(:,end);

X_unlabeled = unlabeled_set(:,1:end-1);
y_unlabeled = unlabeled_set(:,end);

X_test = test_set(:,1:end-1);
y_test = test_set(:,end);
end