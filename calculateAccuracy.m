function accuracy=calculateAccuracy(perdict_label,y_test)
correct=0;
for i=1:size(y_test,1)
        if(perdict_label(i)==y_test(i))
            correct=correct+1;
        end
       
  end
accuracy=(correct)/size(y_test,1);


end