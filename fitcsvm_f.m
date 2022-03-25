function [perdict_label,SVMModel]=fitcsvm_f(X_train,y_train,X_test)

SVMModel = fitcsvm(X_train,y_train,'Standardize', true);
[perdict_label] = predict(SVMModel,X_test);

end