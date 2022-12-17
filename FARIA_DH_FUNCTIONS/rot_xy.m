 function [w,w_k,w_l,w_jk,w_kl ] = rot_xy( x,y,z)
% theta_x=-atand(y/sqrt(x^2+z^2));
% theta_y=pi-atand(x/z);
w_k=-atan(y/sqrt(x^2+z^2));
w_l=pi-atan(x/z);
%rot about y: tilt rotation
w_jk = [  cos(w_k)     0      sin(w_k) ;
             0         1         0     ;
         -sin(w_k)     0      cos(w_k) ];
%rot about x: twist rotation 
w_kl =  [     1         0         0      ;
              0      cos(w_l) -sin(w_l)  ;
              0      sin(w_l)  cos(w_l)  ]; 
        
         
   w = w_jk * w_kl;
 end


