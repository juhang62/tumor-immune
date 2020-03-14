clear
rng(4);

% %%%%%%%%bistable switching
rho=2.5;b=0.02;gam=5;K=10; %from old paramters
sig1=.65;%.9 good bistable switching
tmax=400;dt=0.001; 
iplot=4;


% %%%%single stable 
% rho=1.5;b=0.02;gam=5;K=10; %from old paramters
% sig1=.65; %.9 good bistable switching
% dt=0.001;tmax=400;
% iplot=3;

% %%%%extinction small noise rho=0.09..0.145
% rho=0.12;b=0.02;gam=5;K=10; %from old paramters
% sig1=.3;
% tmax=400;dt=0.001; 
% iplot=1;

% % %%%%%%%extinction big noise  sig^2>0.12
% rho=2.5;b=0.02;gam=5;K=10; %from old paramters
% sig1=sqrt(32);
% dt=0.001;tmax=5; 
% iplot=2;

u=0.1;v=0.03;
ud=u;vd=v;
t=0:dt:tmax;
n=length(t);
U=zeros(n,1);V=U;
Ud=U;Vd=V;

for i=1:n
xi=normrnd(0,1,1,1);
udold=ud; vdold=vd;
uold=u; vold=v;
ud=udold+dt*(rho*udold*(1-udold/K)-gam*udold*vdold);
vd=vdold+dt*(b-vdold+udold/(1+udold^2));
u=uold+dt*(rho*uold*(1-uold/K)-gam*uold*vold)+...
    sig1*uold*(1-uold/K)*sqrt(dt)*xi(1)+...
    0.5*sig1^2*(uold-uold^2/K)*(1-2*uold/K)*(xi(1)^2-1)*dt;
v=vold+dt*(b-vold+uold/(1+uold^2));
U(i)=u;V(i)=v;
Ud(i)=ud; Vd(i)=vd;
end

%plot(t,Ud,t,U,t,Vd,t,V)
subplot(2,2,iplot)
tit={'(a)','(b)','(c)','(d)'};
plot(t,U,'r',t,V,'b',t,Ud,'r--',t,Vd,'b--')
if iplot==1
legend('u w/ noise','v w/ noise','u w/0 noise','v w/o noise')
end
xlabel('t')
title(tit{iplot})