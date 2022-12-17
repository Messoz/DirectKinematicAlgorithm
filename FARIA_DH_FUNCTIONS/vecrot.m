function [M,theta, Nrm]=vecrot(vstart,vend)
%Find rotation carrying one vector toward another about their common perpendicular
%axis.
%           
%IN:         
%            
%    vstart: Initial vector
%      vend: Final vector
%            
%OUT:        
%            
%    M:  homogeneous 4x4 rotation matrix carrying vstart to vend in a
%        rotation about the axis Nrm=cross(vstart,vend)
%    theta:  the rotation angle in degrees
%    Nrm: the rotation axis
  vstart=vstart(:)/norm(vstart);
  vend=vend(:)/norm(vend);
 
  Nrm=cross(vstart,vend);
   
  b=vend.'*vstart;
  
  theta = atan2d(sqrt(1-b^2),b);
   M=AxelRot(theta,Nrm,[]);
