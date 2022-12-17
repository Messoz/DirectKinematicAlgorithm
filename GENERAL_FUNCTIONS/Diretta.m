function TCP = Diretta(Robot,Q,num_joints)
    if Robot.name=="IRB910sc"
          An = eye(4);
            for i=1:num_joints
                if i==3
                   Tn(:,:,i) = dh_matrix(Robot.DH(i,1), Robot.DH(i,2), Robot.DH(i,3)+ Q(i), Robot.DH(i,4)); 
                   An = An * Tn(:,:,i);
                else
                   Tn(:,:,i) = dh_matrix(Robot.DH(i,1), Robot.DH(i,2), Robot.DH(i,3), Robot.DH(i,4) + Q(i)); 
                   An = An * Tn(:,:,i);
                end
            end
         TCP=An(1:3,4)';
    else
        An = eye(4);
            for i=1:num_joints
               Tn(:,:,i) = dh_matrix(Robot.DH(i,1), Robot.DH(i,2), Robot.DH(i,3), Robot.DH(i,4) + Q(i)); 
               An = An * Tn(:,:,i);
               
            end
         TCP=An(1:3,4)';
         
    end
end

