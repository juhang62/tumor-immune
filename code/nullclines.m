rho=2.5; K=10; s=5; b=0.02;
g=@(x) b+x./(x.^2+1);
f=@(x) (1-x/K)*rho/s;
eq=@(x) f(x)-g(x);
xe(1)=0;
xe(2)=fzero(eq,0);
xe(3)=fzero(eq,2);
xe(4)=fzero(eq,6);
ye=g(xe);
x=0:0.01:10;
plot(x,f(x),'b-',[0 0],[0 0.6], 'b-', x,g(x),'r--','LineWidth',1)
hold on
scatter(xe([1 3]),ye([1 3]),'k','LineWidth',2)
scatter(xe([2 4]),ye([2 4]),'k','filled')
str = {'E_0','E_1','E_2','E_3'};
text(xe+0.15,ye+0.005,str)
xlabel('u')
ylabel('v')
h(1) = plot(NaN,NaN,'b');
h(2) = plot(NaN,NaN,'--r');
L=legend(h, 'f(u,v)=0','g(u,v)=0','Location','best');
