clear
clc
close all
%% Choice the robot to analyze
addpath("GENERAL_FUNCTIONS\")
msg = "Choose the robot to analyze";
opts = ["IRB910sc" "IRB140" "IRB1520ID" "IRB660" "IRB1410" "LR-MATE200ic"];
choice = menu(msg,opts);

num_joint=[4,6,6,4,6,6];

joint_type_flag{1}=[0 0 1 0];
joint_type_flag{2}=[0 0 0 0 0 0];
joint_type_flag{3}=[0 0 0 0 0 0];
joint_type_flag{4}=[0 0 0 0];
joint_type_flag{5}=[0 0 0 0 0 0];
joint_type_flag{6}=[0 0 0 0 0 0];

eedisp{1} = zeros(num_joint(choice), 3);
eedisp{1}(3,:) = [20 0 0];
eedisp{2} = zeros(num_joint(choice), 3);
eedisp{3} = zeros(num_joint(choice), 3);
eedisp{4} = zeros(num_joint(choice), 3);
eedisp{5} = zeros(num_joint(choice), 3);
eedisp{6} = zeros(num_joint(choice), 3);


%% Get DH data from EXCEL_DATA

    [T]=excel_to_matlab_DH(choice,num_joint(choice));


%% Apply FARIA algorithm
if choice == 1 
    test_joints=[-80  0  0 0]; %Scara joints values, J3 in [mm]
end
if choice == 4
    test_joints=[-80 0 0 0 0 0]; %IRB 660 joints values
end
if choice == 2 || choice == 3 || choice == 5 || choice == 6
    test_joints=[-67.006 42.375 -18.204 -49.879 -22.581 53.258]; %values of joints for testing, An matrix correspond at the direct kinematic Matrix
end

[DH,An]=Faria_DH(T,num_joint(choice),joint_type_flag{choice},eedisp{choice}, test_joints)

%% DH Evaluation (only for LR-MATE200ic)
if choice == 6 %I made an evaluation of DH parameters
 

     load("DH_Teorici.mat")
     load("J_errati.mat")
        
     Robot.name="LR-MATE200ic";
     Robot.numJ=6;
     Robot.DH=DH; 
     
     RobotTeo.name="LR-MATE200ic";
     RobotTeo.numJ=6;
     RobotTeo.DH=DH_Teorici;

%   Euclidean_Error=Valutazione_DH_FANUC_ogni8(DH,TCP_real_ogni8);
    % i want to see what happen if I use DH from article in internet, I
    % plot the errors and I can note that the errors from DH found on
    % internet and DH found through Faria with data in input how the should
    % be are equals.
   
    TCP_real_ogni8=J;
    Euclidean_Error_DH_veri=Valutazione_DH_FANUC_ogni8(TCP_real_ogni8,Robot);
    grid on
    Euclidean_Error_DH_teorici=Valutazione_DH_FANUC_ogni8(TCP_real_ogni8,RobotTeo);

end


%% Testing using Trajectories: Rectangle, S, Circle, Spiral

msg1 = "Do you want to test the results on trajectoroies?";
opts1 = ["YES" "NO"];

choice1 = menu(msg1,opts1);
if choice1 == 1
    %IRB910sc
    if choice == 1
        Robot.name="IRB910sc";
        Robot.DH=DH;
        Robot.minMax= [deg2rad(-140) deg2rad(140);
                       deg2rad(-150) deg2rad(50);
                         180         0;
                       deg2rad(-400) deg2rad(400)];
        Robot.numJ=4;
    end

    %IRB140
    if choice == 2
        Robot.name="IRB140";
        Robot.DH=DH;
        Robot.minMax = [  -pi              pi;...
                          -pi/2            deg2rad(110);...
                          deg2rad(-230)   deg2rad(50);...
                          deg2rad(-165)   deg2rad(165);...
                          deg2rad(-115)   deg2rad(115);...
                          deg2rad(-163)   deg2rad(163)];
        Robot.numJ=6;
     
    end
    %IRB1520ID
    if choice == 3
        Robot.name="IRB1520ID";
        Robot.DH=DH;
        Robot.minMax=[  deg2rad(-170)  deg2rad(170);...
                        deg2rad(-90)      deg2rad(150);...
                        deg2rad(-100)   deg2rad(80);...
                        deg2rad(-155)   deg2rad(155);...
                        deg2rad(-135)   deg2rad(135);...
                        deg2rad(-200)   deg2rad(200)];
        Robot.numJ=6;

    end
    %IRB660
    if choice == 4
        Robot.name="IRB660";
        Robot.DH=DH;
        Robot.minMax = [  deg2rad(-180)  deg2rad(180);...
                          deg2rad(-42)      deg2rad(70);...
                          deg2rad(-20)   deg2rad(90);...
                          deg2rad(-300)   deg2rad(300)];...
        Robot.numJ=4;
    end
    %IRB1410
    if choice == 5
        Robot.name="IRB1410";
        Robot.DH=DH;
        Robot.numJ=6;
        %aggiungi min e max
    end

    if choice == 6
        Robot.name="LR-MATE200ic";
        Robot.DH=DH;
        Robot.numJ=6;
        %aggiungi min e max
    end

J_traj=ReadTrajJoints(Robot,choice);
TCP_traj=ReadTrajTCP(Robot,choice);

    msg2 = "Which trajectory do you want to evaluate?";
    opts2 = ["Circle","Spiral","S","Rectangle","EXIT"];


if choice == 6
    choice2 = 6 % LR - MATE 200 ic has been selected
    [E,EA,Enorm,TCP_DH,TCP_O]=EvaluateTraj(choice2,J_traj,TCP_traj,Robot);
    plot_results(choice2,E,EA,Enorm,TCP_DH,TCP_O)

else
    choice2 = 0;
    while choice2 < 5
        choice2 = menu(msg2,opts2);
        [E,EA,Enorm,TCP_DH,TCP_O]=EvaluateTraj(choice2,J_traj,TCP_traj,Robot);
        plot_results(choice2,E,EA,Enorm,TCP_DH,TCP_O)
        tra_name=Robot.name + '_' + opts2(choice2);
        tra_name120=Robot.name +'_' + opts2(choice2)+'_120';
        tra_name80=Robot.name + '_' + opts2(choice2)+'_80';
        E_tab={tra_name,mean(Enorm{1}),min(Enorm{1}),max(Enorm{1}),length(Enorm{1});
            tra_name120,mean(Enorm{2}),min(Enorm{2}),max(Enorm{2}),length(Enorm{2});
            tra_name80,mean(Enorm{3}),min(Enorm{3}),max(Enorm{3}),length(Enorm{3})}

        %xlswrite(Robot.name + '_' + opts2(choice2),E_tab) if you want to
        %create a fileexcel with robot data.
    end
end
    
end
