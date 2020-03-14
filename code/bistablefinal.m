%%
clear
global rho b K s
rho=2.5;b=0.02;s=5;K=10; %from old paramters
%rho=0.5;K=10;s=1;b=0.1;
%history = [0.62;0.46]; %initial function
%history = [0.7;1.8/5]
history =[.455; 0.477];
hisotry=[0.00002; 0.02];
tspan = [0, 200];
opts = ddeset('RelTol',1e-5,'AbsTol',1e-7);
tau=6.1;
% %%Solve equation
ddefun=@(t,y,z) feedbackfun(t,y,z,tau);
sol = dde23(ddefun, tau, history, tspan, opts);
subplot(2,2,4)
plot(sol.x, sol.y(1,:), 'b',sol.x, sol.y(2,:), 'k');
[t,y]=ode45(@odefun,tspan,history);
hold on
plot(t,y(:,1),t,y(:,2))
hold off
title(['\tau=' num2str(tau)])
%legend('u w/ delay','v w/ delay', 'u w/o delay', 'v w/o delay')
xlabel('t')
%legend('cancer','immune cells','cancer w/ delay','immune cells w/ delay')
%xlim([400,tspan(2)])

%%
% [xx,yy] = meshgrid(0:0.1:1.5,0:0.1:2.5);
% rho=3;b=1;a=0.2;K=0.1;
% s1=rho*(1-xx)-xx.*yy;
% imresp=a*yy.*(xx./(K+xx));
% s2=b-yy+imresp;
% 
% quiver(xx,yy,s1,s2)



function dydt = feedbackfun(t, y, Z,tau)
global rho b a gam K s
ylag1 = Z(1);
%ylag2 = Z(2);
imresp=ylag1/(1+ylag1^2); 
tumorgrow=rho*y(1)*(1-y(1)/K);
dydt = [tumorgrow-s*y(1)*y(2);b-y(2)+imresp];

end


function dydt=odefun(t,y)
global rho b K s
tumorgrow=rho*(1-y(1)/K)*y(1);
imresp=y(1)/(1+y(1)^2);
dydt = [tumorgrow-s*y(1)*y(2);b-y(2)+imresp];
end