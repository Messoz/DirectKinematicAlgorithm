
%% pochi punti
close all
alfa11=linspace(-deg2rad(80),deg2rad(80),11);
r=300;
x11=r*cos(alfa11);
y11=r*sin(alfa11);

xm11=sum(x11)/length(x11);
ym11=sum(y11)/length(y11);
figure
plot(x11,y11,'sqr',LineWidth=5)
hold on
plot(xm11,ym11,'*r')
hold on
%% tanti punti
alfa=linspace(-deg2rad(80),deg2rad(80),1000);
r=300;
x=r*cos(alfa);
y=r*sin(alfa);

xm=sum(x)/length(x);
ym=sum(y)/length(y);

Ex=abs(xm-xm11)
plot(x,y,'ok')
hold on
plot(xm,ym,'*k')
xlabel('x')
ylabel('y')
axis equal
grid on