function [X,Y,loc,val,C,r]=calculateFarpoint(peaks,TM_DIS,nPeak,X0,disTarget,dis,T)
X=[];
Y=[];
n=size(TM_DIS,2);
farpoint=zeros(nPeak,n);
% sort kardane target ha 2 be 2
[Target_Sort,I]=sort(disTarget,2);
Pair_Target = I(:,2);
for i=1:nPeak/2
    Target_index(i,:)=[peaks(i) peaks(Pair_Target(i,1))];
    AB(:,:,i)=[X0(Target_index(i,1),:);X0(Target_index(i,2),:)];
    disTarget_sorted(i)=pdist2(AB(1,:,i),AB(2,:,i));
%     A=X0(Target_index(i,1),:);
%     B=X0(Target_index(i,2),:);
end

for i=1:nPeak
    for j=1:n
        for l=1:nPeak
            if( ~ismember(X0(peaks(i),:),X0(j,:),'rows') &&  l~=i && TM_DIS(i,j)<TM_DIS(l,j) && TM_DIS(i,j)<disTarget_sorted(ceil(i/2)))
                farpoint(i,j)=TM_DIS(i,j);  
            end
        end
    end
end
[val,loc] = max(farpoint');
loc=loc';
% for i=1:nPeak
% 
% fp_peak=X0(loc(i,1),:);%far point from peaki
% 
% end
%% _________________________________mokhtasate first target
peaks=[peaks;peaks(1)];
for i=1:nPeak
    k(i)=dis(peaks(i,1),loc(i,1))./dis(peaks(i+1,1),loc(i,1));
    X1(i)=X0(peaks(i,1),1);
    X2(i)=X0(peaks(i+1,1),1);
    Cx(i)=(X1(i)-(k(i)^2*X2(i)))./(1-(k(i)^2));% tole markaz
Y1(i)=X0(peaks(i,1),2);
Y2(i)=X0(peaks(i+1,1),2);
Cy(i)= (Y1(i)-(k(i)^2*Y2(i)))./(1-(k(i)^2));% arze markaz
r(i)=k(i)*(sqrt((X1(i)-X2(i))^2)+((Y1(i)-Y2(i))^2))./(abs(1-(k(i)^2)));
t=0:0.1:6.3;
    
   XX=r(i).*sin(t)+Cx(i);
   YY=r(i).*cos(t)+Cy(i);
   X=[X XX];
   Y=[Y YY];
  C{i}= [Cx(i),Cy(i)];

end




% %% __________________________rasme dayere
%  center=[C_1;C_2];
%  radius=[r_1;r_2];
% circle(center,r,X0,peaks,nPeak,T,loc);