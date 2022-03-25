function [Acu_binary]=binary_svm(X_unlabeled,center,radius,nPeak,train_set,y_test,Class)
class1=0;
class2=0;
% class3=0;
un_p=[];
tr_p=[];
label_un_p=[];
indis=[];
selectU=X_unlabeled;
N=fix(size(selectU,1)/5);% size set of unlabel that add to train in each step
repeat=0;
while (~isempty(selectU))
    repeat=repeat+1;
    
    [r,t]=size(selectU);
    if(r>=N)
        Sub_Slect=selectU(randsample(length(selectU),N),:);
        selectU = setdiff(selectU, Sub_Slect,'rows') ;
    else
        Sub_Slect=selectU;
        selectU = setdiff(selectU, Sub_Slect,'rows') ;
    end

    % label detection
    for i=1:nPeak
        for j=1:size(Sub_Slect,1)
            if(sqrt(Sub_Slect(j,1)-center{1,i}(1,1))+(Sub_Slect(j,2)-center{1,i}(1,2))<=radius(1,i))
                un_p(end+1,:)= Sub_Slect(j,1:end);
              indis(end+1)=j;
            end
        end
        indis=indis';
        for j=1:size(train_set,1)
             if(sqrt(train_set(j,1)-center{1,i}(1,1))+(train_set(j,2)-center{1,i}(1,2))<=radius(1,i))
                 tr_p(end+1,:)=train_set(j,1:end);
             end
        end
             for j=1:size(tr_p,1)
                 if(tr_p(j,end)==Class(1))
                     class1=class1+1;
                 elseif (tr_p(j,end)==Class(2))
                     class2=class2+1;
%                  else
%                      class3=class3+1;
                 end
             end
%         un_p(:,end+1)=nan;
        if ((0.9)*class2>class1 )
            for j=1:size(un_p,1)
                label_un_p(j)=Class(2);
         
            end
        elseif ((0.9)*class1>class2 )
             for j=1:size(un_p,1)
            label_un_p(j)=Class(1);
             end
%         else
%             un_p(j,end)=Class(3);
        end
        [perdict_label,SVMModel]=fitcsvm_f(train_set(:,1:end-1),train_set(:,end),Sub_Slect);
        for j=1:size(perdict_label)
            for q=1:size(un_p)
                if (j==indis(q) && perdict_label(j)==label_un_p(q))
              
                  train_set=vertcat(train_set, [un_p,label_un_p(q)]);
                end
                 
            end
        end
           
         
         train_set = train_set(randperm(length(train_set)),:);
    end
    
   end






    Acu_binary(repeat)=calculateAccuracy(perdict_label,y_test);
    

end