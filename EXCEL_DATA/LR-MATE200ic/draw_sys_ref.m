function  draw_sys_ref(TCP_m,W,P,R)
%%
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
p_off=[1 0 0 0;...
          0 1 0 20;...
          0 0 1 0;...
          0 0 0 1];
M_rot=@(rotx,roty,rotz) M_pz(rotz)*M_py(roty)*M_px(rotx);
M_tcp2base=@(rotx,roty,rotz,TCP) M_tras(TCP)*M_rot(rotx,roty,rotz);
%%
freccia=300;
            
%             mArrow3([0 0 0],[1 0 0].*freccia,'color','blue','stemWidth',2,'facealpha',0.5)
%             hold on
%             mArrow3([0 0 0],[0 1 0].*freccia,'color','green','stemWidth',2,'facealpha',0.5)
%             hold on
%             mArrow3([0 0 0],[0 0 1].*freccia,'color','red','stemWidth',2,'facealpha',0.5)
t_w=5;
s_w=2;
           

            P1 = M_tcp2base(W,P,R,TCP_m)*[freccia;0;0;1];
            P2 = M_tcp2base(W,P,R,TCP_m)*[0;freccia;0;1];
            P3 = M_tcp2base(W,P,R,TCP_m)*[0;0;freccia;1];
            hold on

  
            mArrow3(TCP_m,P1(1:3),'color','blue','tipWidth', t_w,'stemWidth',s_w,'facealpha',1)
            hold on
            mArrow3(TCP_m,P2(1:3),'color','green','tipWidth', t_w,'stemWidth',s_w,'facealpha',1)
            hold on
            mArrow3(TCP_m,P3(1:3),'color','red','tipWidth', t_w,'stemWidth',s_w,'facealpha',1)
            hold on 
            grid on
            plot3(TCP_m(1),TCP_m(2),TCP_m(3),'ko',LineWidth=2)
            hold on
            
           
            
            % disegno il sistema di riferimento sul punto P

            P1_off = M_tcp2base(W,P,R,TCP_m)*p_off*[freccia*0.3;0;0;1];
            P2_off = M_tcp2base(W,P,R,TCP_m)*p_off*[0;freccia*0.3;0;1];
            P3_off = M_tcp2base(W,P,R,TCP_m)*p_off*[0;0;freccia*0.3;1];
            hold on

            TCP_p=M_tcp2base(W,P,R,TCP_m)*p_off;
            TCP_p=TCP_p(1:3,4);
            mArrow3(TCP_p,P1_off(1:3),'color','#4DBEEE','tipWidth', t_w,'stemWidth',s_w,'facealpha',1)
            hold on
            mArrow3(TCP_p,P2_off(1:3),'color','#77AC30','tipWidth', t_w,'stemWidth',s_w,'facealpha',1)
            hold on
            mArrow3(TCP_p,P3_off(1:3),'color','#EDB120','tipWidth', t_w,'stemWidth',s_w,'facealpha',1)
            hold on 
            grid on
            plot3(TCP_p(1),TCP_p(2),TCP_p(3),'rsq',LineWidth=2)
            legend('xTCP','yTCP','zTCP','TCP','xp','yp','zp','P')
            xlabel('x [m]')
            ylabel('y [m]')
            zlabel('z [m]')
%              axis equal
            rotate3d on




end