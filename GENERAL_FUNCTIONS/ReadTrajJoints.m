function J_traj = ReadTrajJoints(Robot,choice)
numOfTraj=12;
folder_DH = "EXCEL_DATA\"+Robot.name+"\";

 %IRB910sc
    if choice == 1   
        for i=1:numOfTraj
            T{i} = xlsread(strcat(folder_DH,Robot.name,"TrajPulito"),i);
            J_traj{i}(:,1) = deg2rad(T{i}(:,2));
            J_traj{i}(:,2) = deg2rad(T{i}(:,3));
            J_traj{i}(:,3) = T{i}(:,4);
            J_traj{i}(:,4) = deg2rad(T{i}(:,5));
        end
    end

    %IRB140
    if choice == 2
       for i=1:numOfTraj
            T{i} = xlsread(strcat(folder_DH,Robot.name,"TrajPulito"),i);
            J_traj{i}(:,1) = deg2rad(T{i}(:,2));
            J_traj{i}(:,2) = -deg2rad(T{i}(:,3));
            J_traj{i}(:,3) = -deg2rad(T{i}(:,4));
            J_traj{i}(:,4) = deg2rad(T{i}(:,5));
            J_traj{i}(:,5) = -deg2rad(T{i}(:,6));
            J_traj{i}(:,6) = deg2rad(T{i}(:,7));
        end
    end

    %IRB1520ID
    if choice == 3
       for i=1:numOfTraj
            T{i} = xlsread(strcat(folder_DH,Robot.name,"TrajPulito"),i);
            J_traj{i}(:,1) = deg2rad(T{i}(:,2));
            J_traj{i}(:,2) = -deg2rad(T{i}(:,3));
            J_traj{i}(:,3) = -deg2rad(T{i}(:,4));
            J_traj{i}(:,4) = deg2rad(T{i}(:,5));
            J_traj{i}(:,5) = -deg2rad(T{i}(:,6));
            J_traj{i}(:,6) = deg2rad(T{i}(:,7));
       end
    end

    %IRB660
    if choice == 4
        for i=1:numOfTraj
         T{i} = xlsread(strcat(folder_DH,Robot.name,"TrajPulito"),i);
            J_traj{i}(:,1) = deg2rad(T{i}(:,2));
            J_traj{i}(:,2) = -deg2rad(T{i}(:,3));
            J_traj{i}(:,3) = -deg2rad(T{i}(:,4));
            J_traj{i}(:,4) = deg2rad(T{i}(:,5));
        end
    end

    %IRB1410
    if choice == 5
        for i=1:numOfTraj
            T{i} = xlsread(strcat(folder_DH,Robot.name,"TrajPulito"),i);
            J_traj{i}(:,1) = deg2rad(T{i}(:,2));
            J_traj{i}(:,2) = -deg2rad(T{i}(:,3));
            J_traj{i}(:,3) = -deg2rad(T{i}(:,4));
            J_traj{i}(:,4) = deg2rad(T{i}(:,5));
            J_traj{i}(:,5) = -deg2rad(T{i}(:,6));
            J_traj{i}(:,6) = deg2rad(T{i}(:,7));
       end
    end

     %LRMATE200ic
    if choice == 6
        J_rett=[ -89.924	20.372	-15.692	0.503	-67.284	-1.013;
            -101.073	22.319	-15.044	-0.969	-67.979	10.61;
            -102.935	7.986	-18.464	-1.245	-64.596	12.629;
            -105.525	-5.913	-18.693	-1.593	-64.427	15.356;
            -89.882	-8.552	-18.389	0.518	-64.592	-0.081;
            -74.28	-5.844	-18.7	2.584	-64.685	-17.485;
            -76.902	8.052	-18.459	2.243	-64.825	14.702;
            -78.785	22.368	-15.03	1.948	-68.183	-12.6];
       J_circle=[ -89.924	20.372	-15.692	0.503	-67.284	-1.013;
           -87.946	20.453	-10.427	0.74	-72.573	-3.002;
           -83.189	21.779	-4.739	1.31	-78.345	-7.768;
           -78.527	22.558	-9.733	1.919	-73.487	-12.676;
           -76.633	23.243	-14.714	2.216	-68.576	-14.82;
           -78.526	22.925	-20.076	2.062	-63.152	-13.059;
           -83.189	22.601	-25.497	1.52	-57.6	-8.31;
           -87.947	20.959	-20.742	0.799	-62.268	-3.144];
       J_s=[ -89.924	20.372	-15.692	0.503	-67.284	-1.013;
           -86.422	17.077	-16.661	0.973	-66.36	-4.683;
           -82.287	9.478	-18.259	1.537	-64.851	-9.052;
           -85.673	0.851	-18.971	1.093	-64.067	-5.515;
           -89.902	-2.740	-18.917	0.520	-64.065	-1.068;
           -94.54	-5.904	-18.7	-0.11	-64.268	3.812;
           -100.269	-13.419	-17.547	-0.878	-65.471	9.813;
           -95.881	-22.894	-14.851	-0.284	-68.124	5.199;
           -89.865	-26.943	-13.292	0.503	-69.695	-1.051];

        for i=1:3
            if i==1
                T{i}=J_circle;
                elseif i==2
                    T{i}=J_s;
                else 
                    T{i}=J_rett;
            end

            J_traj{i}(:,1) = deg2rad(T{i}(:,1));
            J_traj{i}(:,2) = deg2rad(T{i}(:,2));
            J_traj{i}(:,3) = deg2rad(T{i}(:,3)+T{i}(:,2));
            J_traj{i}(:,4) = deg2rad(T{i}(:,4));
            J_traj{i}(:,5) = deg2rad(T{i}(:,5));
            J_traj{i}(:,6) = deg2rad(T{i}(:,6));
       end
    end
end