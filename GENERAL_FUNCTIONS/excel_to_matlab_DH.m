function [T] = excel_to_matlab_DH(choice,num_joints)
opts = ["IRB910sc" "IRB140" "IRB1520ID" "IRB660" "IRB1410" "LR-MATE200ic"];
folder_DH = "EXCEL_DATA\"+opts(choice)+"\";

    %IRB910sc
    if choice == 1
        for i=1:num_joints
        T{i} = xlsread(strcat(folder_DH,opts(choice),"_DH"),i);
        T{i} = T{i}(:,2:4); 
        end
    end
    %IRB140
    if choice == 2
        for i=1:num_joints
        T{i} = xlsread(strcat(folder_DH,opts(choice),"_DH"),i);
        T{i} = T{i}(:,10:12); 
        end
    end
    %IRB1520ID
    if choice == 3
        for i=1:num_joints
        T{i} = xlsread(strcat(folder_DH,opts(choice),"_DH"),i);
        T{i} = T{i}(:,10:12); 
        end
    end
    %IRB660
    if choice == 4
        for i=1:num_joints
        T{i} = xlsread(strcat(folder_DH,opts(choice),"_DH"),i);
        T{i} = T{i}(:,2:4); 
        end
    end
    %IRB1410
    if choice == 5
        for i=1:num_joints
        T{i} = xlsread(strcat(folder_DH,opts(choice),"_DH"),i);
        %T{i} = xlsread(strcat(folder_DH,"Copy_of_",opts(choice),"_DH"),i);
        T{i} = T{i}(:,2:4); 
        end
    end

    %LR-MATE200ic
    if choice == 6
       % per vedere DH corretti
%          for i=1:num_joints
%          T{i} = xlsread(strcat(folder_DH,"TCP_FANUCPROVALAB_ogni8_2.xls"),i);
%          T{i} = T{i}(:,1:3); 
%          end
%         load('TCP_err.mat')
%         for i=1:6
%             T{i}=TCP_20_metodo2{i}(:,1:3);
%         end
         load('TCP_ok.mat')
        for i=1:6
            T{i}=TCP_20_metodo2{i}(:,1:3);
        end
    end
end


