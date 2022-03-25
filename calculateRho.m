function rho=calculateRho(d,k)  %%d hamon disFromNeighb
    rho=sum(d.^2,2);
    rho=rho/k;
    rho=exp(-rho);
end