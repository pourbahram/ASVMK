function [peaks,nPeak,k,neighbs,rho,delta,X,Y,loc,val,center,radius]=densityPeaks(n,p,tetha,X0,T)
k=fix(p*n);
dis=pdist2(X0(:,:),X0(:,:));
[disFromNeighb,neighbs]=neighborhood(n,k,dis);
rho=calculateRho(disFromNeighb,k);
delta=calculateDelta(rho,dis);
peaks=selectPeak(rho,delta,tetha);
nPeak=size(peaks,1);
target=X0(peaks,:);
disTarget=pdist2(target(:,:),target(:,:));
for i=1:nPeak
    for j=1:n
       TM_DIS(i, j) = pdist2(target(i,:),X0(j,:));  %distance targets from far points
    end
end

    [X,Y,loc,val,center,radius]=calculateFarpoint(peaks,TM_DIS,nPeak,X0,disTarget,dis,T);
%     [X,Y,Label,clustered_points]=Groupapollonius2(peaks,nPeak,dis,n,X0);
%     Finalgroups=densityApollonius(peaks,nPeak,X,Y,Label,clustered_points,dis,X0,n)
end