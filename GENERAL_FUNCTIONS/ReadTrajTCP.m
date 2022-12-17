function TCP_traj= ReadTrajTCP(Robot,choice)
numOfTraj=12;
folder_DH = "EXCEL_DATA\"+Robot.name+"\";

 %IRB910sc
    if choice == 1   
        for i=1:numOfTraj
            T{i} = xlsread(strcat(folder_DH,Robot.name,"TrajPulito"),i);
            TCP_traj{i}(:,1) = T{i}(:,6);
            TCP_traj{i}(:,2) = T{i}(:,7);
            TCP_traj{i}(:,3) = T{i}(:,8);
        end
    end

    %IRB140
    if choice == 2
       for i=1:numOfTraj
            T{i} = xlsread(strcat(folder_DH,Robot.name,"TrajPulito"),i);
            TCP_traj{i}(:,1) = T{i}(:,8);
            TCP_traj{i}(:,2) = T{i}(:,9);
            TCP_traj{i}(:,3) = T{i}(:,10);
        end
    end

    %IRB1520ID
    if choice == 3
       for i=1:numOfTraj
            T{i} = xlsread(strcat(folder_DH,Robot.name,"TrajPulito"),i);
            TCP_traj{i}(:,1) = T{i}(:,8);
            TCP_traj{i}(:,2) = T{i}(:,9);
            TCP_traj{i}(:,3) = T{i}(:,10);
       end
    end

    %IRB660
    if choice == 4
        for i=1:numOfTraj
         T{i} = xlsread(strcat(folder_DH,Robot.name,"TrajPulito"),i);
            TCP_traj{i}(:,1) = T{i}(:,6);
            TCP_traj{i}(:,2) = T{i}(:,7);
            TCP_traj{i}(:,3) = T{i}(:,8);
        end
    end

    %IRB1410
    if choice == 5
        for i=1:numOfTraj
            T{i} = xlsread(strcat(folder_DH,Robot.name,"TrajPulito"),i);
            TCP_traj{i}(:,1) = T{i}(:,8);
            TCP_traj{i}(:,2) = T{i}(:,9);
            TCP_traj{i}(:,3) = T{i}(:,10);
       end
    end

     %LRMATE200ic
    if choice == 6
        TCP_rett=[0.042	-517.574	187.493;
            -100.015	-517.576	187.495;
            -100.011	-442.473	187.484;
            -100.007	-367.487	187.492;
            0.103	-367.487	187.488;
            100.048	-367.487	187.485;
            100.053	-442.517	187.466;
            100.048	-517.557	187.479];


        TCP_circle=[0.042	-517.574	187.493;
            17.579	-517.574	217.541;
            60.014	-517.579	247.493;
            102.426	-517.579	217.474;
            120.025	-517.578	187.517;
            102.437	-517.575	157.5;
            60.013	-517.575	127.508;
            17.563	-517.573	157.558];

        TCP_s=[0.042	-517.574	187.493;
            30.013	-499.988	187.479;
            60.001	-457.477	187.474;
            30.028	-415.079	187.467;
            0.029	-397.464	187.463;
            -30.026	-379.906	187.455;
            -60.017	-337.536	187.447;
            -30.023	-295.084	187.445;
            -0.007	-277.510	187.458];

        for i=1:3
              if i==1
                    T{i}=TCP_circle;
                elseif i==2
                    T{i}=TCP_s;
                else 
                    T{i}=TCP_rett;
             end
            TCP_traj{i}(:,1) = T{i}(:,1);
            TCP_traj{i}(:,2) = T{i}(:,2);
            TCP_traj{i}(:,3) = T{i}(:,3)+330;
       end
    end
end

