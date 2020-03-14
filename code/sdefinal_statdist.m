clear
%rng(4);

% %%%%%%%%bistable switching
rho=2.5;b=0.02;gam=5;K=10; %from old paramters
sig1=.65;%.9 good bistable switching
tmax=100;dt=0.001; 
iplot=4;


% %%%%single stable 
% rho=1.5;b=0.02;gam=5;K=10; %from old paramters
% sig1=.65; %.9 good bistable switching
% dt=0.001;tmax=400;
% iplot=3;

%%%%%%extinction small noise rho=0.09..0.145
% rho=0.12;b=0.02;gam=5;K=10; %from old paramters
% sig1=.3;
% tmax=400;dt=0.001; 
% iplot=1;

% % %%%%%%%extinction big noise  sig^2>0.12
% rho=2.5;b=0.02;gam=5;K=10; %from old paramters
% sig1=sqrt(32);
% dt=0.001;tmax=5; 
% iplot=2;

nmc=1000;
U=zeros(nmc,1);V=U;
t=0:dt:tmax;
n=length(t);

u=0.1;v=0.03;
for imc=1:1000
    imc
for i=1:n
xi=normrnd(0,1,1,1);
uold=u; vold=v;
u=uold+dt*(rho*uold*(1-uold/K)-gam*uold*vold)+...
    sig1*uold*(1-uold/K)*sqrt(dt)*xi(1)+...
    0.5*sig1^2*(uold-uold^2/K)*(1-2*uold/K)*(xi(1)^2-1)*dt;
v=vold+dt*(b-vold+uold/(1+uold^2));
% U(i)=u;V(i)=v;
% Ud(i)=ud; Vd(i)=vd;
end
U(imc)=u;V(imc)=v;

end

% %plot(t,Ud,t,U,t,Vd,t,V)
% subplot(2,2,iplot)
% tit={'(a)','(b)','(c)','(d)'};
% plot(t,U,'b',t,V,'k',t,Ud,t,Vd)
% legend('u','v','u_d','v_d')
% xlabel('t')
% title(tit{iplot})