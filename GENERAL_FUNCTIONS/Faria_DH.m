function [DH,An] = Faria_DH(T,num_joints,joint_type_flag,ee_disp,test_joints)

addpath('./FARIA_DH_FUNCTIONS/');


for i=1:num_joints
home_joint_pos(i)=0; %offset da cui parte la movimentazione per me è sempre 0.
end

plot=true;

% center and normals to each joint
c = zeros(3,num_joints);
n = zeros(3,num_joints);

if(plot)
    % Plot the saved points and the corresponding best-fitting-circles
    figure();
    hold on
    % axis equal
    grid on
end

% color of the plots (up to 7)
    colors = [0    0.4470    0.7410;
    0.8500    0.3250    0.0980;
    0.9290    0.6940    0.1250;
    0.4940    0.1840    0.5560;
    0.4660    0.6740    0.1880;
    0.3010    0.7450    0.9330;
    0.6350    0.0780    0.1840];

% plot handle vector
lh = gobjects(num_joints,1); %returns a M-by-N matrix of default graphics objects.
% range=[-180 180;
%         180 -180;
%         -180 180;
%         180 -180;
%         -180 180;
%         -180 180];
%range reale
% range=[-80 80;
%        130 50;
%        -65 65;
%        -65 65;
%        -45 +45;
%        -65 65];
% range=[-90 90;
%        180 0;
%        90 -90;
%        85 -85;
%        -90 +90;
%        -65 65;]
for i=1:num_joints
    if(joint_type_flag(i))
        [c(:,i), n(:,i), lh(i)] = best_fitting_line(T{i}, ee_disp(i,:), true, colors(3,:));
        
    else
        [c(:,i), n(:,i), lh(i)] = best_fitting_circle(T{i}, plot, colors(i,:));
    end
end

if(plot)
    for i=1:num_joints
        mArrow3(c(:,i), c(:,i)+ 0.2*2000*n(:,i), 'color', colors(i,:), ...
            'tipWidth', 12, 'stemWidth', 10);
        scatter3(c(1,i), c(2,i), c(3,i), 'filled', 'CData', colors(i,:));
    end
    hold off 
end

% Relative coordinate frames matrix from base to flange between each joint
F = zeros(4,4,num_joints+1);
F(:,:,1) = eye(4);

% Iterative determination of the relative coordinate frames 
for i=1:num_joints-1
    F(:,:,i+1) = pc_revolute(n(:,i), n(:,i+1), c(:,i), c(:,i+1), F(1:3,1,i), F(1:3,4,i));
    %% 
end

% Provide origin of last frame
F(:,:,num_joints+1) = F(:,:,num_joints);
F(1:3,4,num_joints+1) = c(:,num_joints); 

% Extrapolate the Denavit-Hartenberg parameters from the relative
% coordinate frame matrices
dh_meas = zeros(num_joints, 4);
for i=1:num_joints
   dh_meas(i,3) = dot(F(1:3,4,i+1) - F(1:3,4,i), F(1:3,3,i));        % d
   dh_meas(i,4) = pc_angle(F(1:3,1,i), F(1:3,1,i+1), F(1:3,3,i));    % theta
   dh_meas(i,1) = dot(F(1:3,4,i+1) - F(1:3,4,i), F(1:3,1,i+1));      % a
   dh_meas(i,2) = pc_angle(F(1:3,3,i), F(1:3,3,i+1), F(1:3,1,i+1));  % alpha
end

% Compensate for the joint positions of the manipulator during trajectory
% execution.
for i=1:num_joints
    dh_meas(i,4) = dh_meas(i,4) - degtorad(home_joint_pos(i));
end

% Relative coordinate frames transformation for Forward Kinematics
Tn = zeros(4,4,num_joints);
%Tr = zeros(4,4,num_joints);
% Cumulative Forward Kinematics matrix
An = eye(4);
%Ar = eye(4);

test_joints =degtorad(test_joints);

% Forward Kinematics
for i=1:num_joints
   Tn(:,:,i) = dh_matrix(dh_meas(i,1), dh_meas(i,2), dh_meas(i,3), dh_meas(i,4) + test_joints(i));
   %Tr(:,:,i) = dh_matrix(dh_real(i,1), dh_real(i,2), dh_real(i,3), dh_real(i,4) + test_joints(i));
   
   An = An * Tn(:,:,i);
   %Ar = Ar * Tr(:,:,i);
end

% % Position Errors
% PosError = Ar(1:3,4) - An(1:3,4)
% SumPosError = norm(PosError)
% 
% dh_real
% dh_meas
DH=dh_meas;
% title(folder)
xlabel('X [mm]')
ylabel('Y [mm]')
zlabel('Z [mm]')
legend(lh, 'J1', 'J2', 'J3', 'J4', 'J5', 'J6');
axis auto
view(70,20)

% If you want to export a figure
% exp_fig_name = strcat(folder,'.png');
% export_fig exp_fig_name -m2 -nocrop -svg

disp('done')

end

