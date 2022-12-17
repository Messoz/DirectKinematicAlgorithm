%% 
close all
clear
addpath("C:\Users\messo\OneDrive\Documenti\Codice Tesi\FARIA_DH_FUNCTIONS")
%prendo dati da file FANUC_LABORATOTORIO, X Y Z W P R riguardanti ogni
%giunto si trovano nella matrice J"numgiunto"
for i=2:7
    Tab{i-1} = xlsread('FANUC_LABORATORIO_J2ogni8.xlsx',i) ;
end
   % X Y Z W R P
    J1=Tab{1}(:,2:7);
    J2=Tab{2}(:,2:7);
    J3=Tab{3}(:,2:7);
    J4=Tab{4}(:,2:7);
    J5=Tab{5}(:,2:7);
    J6=Tab{6}(:,2:7);

% Aggiungo quantità 330 in z 
    J1(:,3)=J1(:,3)+330;
    J2(:,3)=J2(:,3)+330;
    J3(:,3)=J3(:,3)+330;
    J4(:,3)=J4(:,3)+330;
    J5(:,3)=J5(:,3)+330;
    J6(:,3)=J6(:,3)+330;
%    
xc = 75;
zc = 330;
r=sqrt(375^2+400^2);
val_J2=flip([-40 -32 -24 -16 -8 0 8 16 24 32 40])+90;
ptiJ2=[];
for i=1:11
    ptiJ2(i,:)=[xc+r*cos(deg2rad(val_J2(i))),0,zc+r*sin(deg2rad(val_J2(i))),-180,-90,0];
end
%
    J{1}=J1;
   %J{2}=ptiJ2;
   J{2}=J2;
    J{3}=J3;
    J{4}=J4;
    J{5}=J5;
%     J6(:,4)= flip(J6(:,4));
%     J6(:,5)= flip(J6(:,5));
%     J6(:,6)= flip(J6(:,6));
    J{6}=J6;
    save J_errati_2 J
%%
% Scrivo la matrice di rotazione (mi servirà per l'ultimo giunto e per il quarto)
% M_pJ6=@(t6)[cos(t6) -sin(t6) 0 0 ; ...
%            sin(t6)  cos(t6)  0 0 ; ...
%            0         0       1 0; ...
%            0         0       0 1];
% % valori dell'ultimo giunto
% teta6=deg2rad([-65 -52 -39 -26 -13 0 13 26 39 52 65]);

%matrici di rotazione per W P R
M_pz=@(t6)[cos(t6) -sin(t6) 0 0 ; ...
               sin(t6)  cos(t6) 0 0 ; ...
               0         0      1 0 ; ...
               0         0      0 1];
M_py=@(t6)[cos(t6) 0 sin(t6)  0 ; ...
               0       1  0       0 ; ...
               -sin(t6) 0 cos(t6) 0 ; ...
               0 0  0 1];
M_px=@(t6)[ 1 0 0               0 ; ...
                 0 cos(t6) -sin(t6) 0 ; ...
                 0 sin(t6) cos(t6)  0 ; ...
                 0 0 0 1];
% da zero al valore TCP
M_tras=@(TCP)[ 1 0 0 TCP(1) ; ...
               0 1 0 TCP(2) ; ...
               0 0 1 TCP(3); ...
                 0 0 0 1];   

M_rot=@(rotx,roty,rotz) M_pz(rotz)*M_py(roty)*M_px(rotx);
M_tcp2base=@(rotx,roty,rotz,TCP) M_tras(TCP)*M_rot(rotx,roty,rotz);
% offset in X
M_offset=[1 0 0 0;...
          0 1 0 20;...
          0 0 1 0;...
          0 0 0 1];

% WPR1=deg2rad([-180 -90 0]); % Rotazione del TCP quando i giunti sono a zero 

for i=1:6
%     if i == 2
%         for j=1:10
%         WPR=deg2rad(J{i}(j,4:6));
%         TCP=J{i}(j,1:3); % per gli altri giunti praticamente dal TCP aggiungo l'offset in x.
%         M=M_tras(TCP)*M_pz(WPR(3),No_off)*M_py(WPR(2),No_off)*M_px(WPR(1),No_off)*[20 0 0 1]';
%         TCP_20_metodo2{i}(j,:)=M(1:3,1);
%     end

%     end
    for j=1:11
%     if i==4 || i==6  % per i giunti 4 6 ho scelto questo metodo.
%         TCP=J{i}(j,1:3);
%         M46=M_tras(TCP)*M_px(WPR1(1),No_off)*M_py(WPR1(2),No_off)*M_pz(WPR1(3),No_off)*M_pJ6(teta6(j))*[20 0 0 1]';
%         TCP_20_metodo2{i}(j,:)=M46(1:3,4);
%     else
        WPR=deg2rad(J{i}(j,4:6));
        TCP=J{i}(j,1:3); % per gli altri giunti praticamente dal TCP aggiungo l'offset in x.
        M=M_tras(TCP)*M_pz(WPR(3))*M_py(WPR(2))*M_px(WPR(1))*M_offset;
        TCP_20_metodo2{i}(j,:)=M(1:3,4);
        
       
    end
end

for i=1:6
    plot3(TCP_20_metodo2{i}(:,1),TCP_20_metodo2{i}(:,2),TCP_20_metodo2{i}(:,3),'linewidth',2)
    hold on
    axis equal
    xlabel('x')
    ylabel('y')
    zlabel('z')
    legend('J1','J2','J3','J4','J5','J6')
    axis equal
    grid on
end
hold off
%%
i=4;
figure
for j=1:11
    draw_sys_ref(J{i}(j,1:3),deg2rad(J{i}(j,4)),deg2rad(J{i}(j,5)),deg2rad(J{i}(j,6)));
    hold on
    %plot3( sum(TCP_20_metodo2{i}(:,1))/11,  sum(TCP_20_metodo2{i}(:,2))/11 , sum(TCP_20_metodo2{i}(:,3))/11,'*k')
    %pause(.01)
   
    axis equal
    
end
% 
% figure 
% draw_sys_ref([0, 0, 0],0,0,0);
% legend('xTCP','yTCP','zTCP','TCP');
% draw_sys_ref([475, 0, 705].*0.001,-pi,-pi/2,0);
% legend('xTCP','yTCP','zTCP','TCP');
% axis square
%%
% %Genero filexlsx
% for i=1:6
%     %xlswrite('TCP_FANUC',TCP_20_metodo2{i},i)
%     xlswrite('TCP_FANUCPROVALAB_ogni8_2',TCP_20_metodo2{i},i)
% end

%% Creo i punti del giunto 2 come dovrebbero essere 
xc = 75;
zc = 330;
r=sqrt(375^2+400^2);
val_J2=[-40 -32 -24 -16 -8 0 8 16 24 32 40];
ptiJ2=[];
for i=1:11
    ptiJ2(i,:)=[xc+r*cos(deg2rad(val_J2(i))),0,zc+r*sin(deg2rad(val_J2(i))),-180,-90,0];
end

plot3(ptiJ2(:,1),ptiJ2(:,2),ptiJ2(:,3),'*')
%% Plotto i punti J2
figure
plot3(J2(:,1),J2(:,2),J2(:,3),'sqk',LineWidth=5);
grid on
axis equal
hold on
Pts=MorePoints(J2(:,1:3),1000,[130 50]);
[xc,zc,r]=fit_circle_2d(Pts(:,1),Pts(:,3));
plot3(xc,0,zc,'*r')
hold on
plot3(Pts(:,1),Pts(:,2),Pts(:,3),'ob')

grid on