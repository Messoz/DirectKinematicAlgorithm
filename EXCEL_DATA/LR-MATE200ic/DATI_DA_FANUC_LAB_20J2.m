%% 
close all
clear
%prendo dati da file FANUC_LABORATOTORIO, X Y Z W P R riguardanti ogni
%giunto si trovano nella matrice J"numgiunto"
for i=2:7
    Tab{i-1} = xlsread('FANUC_LABORATORIO_20J2.xlsx',i) ;
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
    
    J{1}=J1;
    J{2}=J2;
    J{3}=J3;
    J{4}=J4;
    J{5}=J5;
    J{6}=J6;
    
%%
% Scrivo la matrice di rotazione (mi servirà per l'ultimo giunto e per il quarto)
% M_pJ6=@(t6)[cos(t6) -sin(t6) 0 0 ; ...
%            sin(t6)  cos(t6)  0 0 ; ...
%            0         0       1 0; ...
%            0         0       0 1];
% % valori dell'ultimo giunto
% teta6=deg2rad([-65 -52 -39 -26 -13 0 13 26 39 52 65]);

%matrici di rotazione per W P R
M_pz=@(t6,TCP)[cos(t6) -sin(t6) 0 0 ; ...
               sin(t6)  cos(t6) 0 0 ; ...
               0         0      1 0 ; ...
               0         0      0 1];
M_py=@(t6,TCP)[cos(t6) 0 sin(t6)  0 ; ...
               0       1  0       0 ; ...
               -sin(t6) 0 cos(t6) 0 ; ...
               0 0  0 1];
M_px=@(t6,TCP)[ 1 0 0               0 ; ...
                 0 cos(t6) -sin(t6) 0 ; ...
                 0 sin(t6) cos(t6)  0 ; ...
                 0 0 0 1];
% da zero al valore TCP
M_tras=@(TCP)[ 1 0 0 TCP(1) ; ...
               0 1 0 TCP(2) ; ...
               0 0 1 TCP(3); ...
                 0 0 0 1];   
% offset in X
M_offset=[1 0 0 20;...
          0 1 0 0;...
          0 0 1 0;...
          0 0 0 1];

No_off=[0 0 0];
% WPR1=deg2rad([-180 -90 0]); % Rotazione del TCP quando i giunti sono a zero 

for i=1:6
    if i == 2
        for j=1:21
        WPR=deg2rad(J{i}(j,4:6));
        TCP=J{i}(j,1:3); % per gli altri giunti praticamente dal TCP aggiungo l'offset in x.
        M=M_tras(TCP)*M_pz(WPR(3),No_off)*M_py(WPR(2),No_off)*M_px(WPR(1),No_off)*[20 0 0 1]';
        TCP_20_metodo2{i}(j,:)=M(1:3,1);
    end
    
    end
    for j=1:11
%     if i==4 || i==6  % per i giunti 4 6 ho scelto questo metodo.
%         TCP=J{i}(j,1:3);
%         M46=M_tras(TCP)*M_px(WPR1(1),No_off)*M_py(WPR1(2),No_off)*M_pz(WPR1(3),No_off)*M_pJ6(teta6(j))*[20 0 0 1]';
%         TCP_20_metodo2{i}(j,:)=M46(1:3,4);
%     else
        WPR=deg2rad(J{i}(j,4:6));
        TCP=J{i}(j,1:3); % per gli altri giunti praticamente dal TCP aggiungo l'offset in x.
        M=M_tras(TCP)*M_pz(WPR(3),No_off)*M_py(WPR(2),No_off)*M_px(WPR(1),No_off)*[20 0 0 1]';
        TCP_20_metodo2{i}(j,:)=M(1:3,1);
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

%%
%Genero filexlsx
for i=1:6
    %xlswrite('TCP_FANUC',TCP_20_metodo2{i},i)
    xlswrite('TCP_FANUCPROVALAB_DH20',TCP_20_metodo2{i},i)
end
