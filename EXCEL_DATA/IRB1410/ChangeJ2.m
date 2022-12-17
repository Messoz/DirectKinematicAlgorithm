pto_asse_J2=[160,0,453];
r=sqrt((590+200)^2+(723+200)^2);
val_J2=90+flip(linspace(-50,50,200));
for i=1:length(val_J2)
ptiJ2(i,:)=[pto_asse_J2(1)+r*cos(deg2rad(val_J2(i))),0,pto_asse_J2(3)+r*sin(deg2rad(val_J2(i)))];
plot3(ptiJ2(i,1),ptiJ2(i,2),ptiJ2(i,3),'*k')
hold  on
end
axis equal
hold on
plot3(0,0,0)
