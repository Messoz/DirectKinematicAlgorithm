function [E,EA,E_norm,TCP_DH,TCP_ORIG] = EvaluateTraj(Traj,J,TCP,Robot)
    if Traj == 1 % circle
        for i=1:3 % Normal, 80%, 120%
            for j=1:length(J{i}(:,1))
                vec=J{i}(j,:);
                TCP_DH{i}(j,:)=Diretta(Robot,vec,Robot.numJ);
                TCP_ORIG{i}(j,:)=TCP{i}(j,:);
                E{i}(j,:)=TCP_DH{i}(j,:)-TCP{i}(j,:);
                EA{i}(j,:)=abs(TCP_DH{i}(j,:)-TCP{i}(j,:));
                E_norm{i}(j)=sqrt((E{i}(j,1))^2+(E{i}(j,2))^2+(E{i}(j,3))^2);
            end
        end
    end
    if Traj == 2 % spiral
        for i=4:6
            k=i-3;
             for j=1:length(J{i}(:,1))
                vec=J{i}(j,:);
                TCP_DH{k}(j,:)=Diretta(Robot,vec,Robot.numJ);
                TCP_ORIG{k}(j,:)=TCP{i}(j,:);
                E{k}(j,:)=TCP_DH{k}(j,:)-TCP{i}(j,:);
                EA{k}(j,:)=abs(TCP_DH{k}(j,:)-TCP{i}(j,:));
                E_norm{k}(j)=sqrt((E{k}(j,1))^2+(E{k}(j,2))^2+(E{k}(j,3))^2);
            end
            
        end
        
    end
    if Traj ==3 % S
        for i=7:9
             k=i-6;
             for j=1:length(J{i}(:,1))
                vec=J{i}(j,:);
                TCP_DH{k}(j,:)=Diretta(Robot,vec,Robot.numJ);
                TCP_ORIG{k}(j,:)=TCP{i}(j,:);
                E{k}(j,:)=TCP_DH{k}(j,:)-TCP{i}(j,:);
                EA{k}(j,:)=abs(TCP_DH{k}(j,:)-TCP{i}(j,:));
                E_norm{k}(j)=sqrt((E{k}(j,1))^2+(E{k}(j,2))^2+(E{k}(j,3))^2);
            end
 
        end
    end
    if Traj == 4 % Rectangle
        for i=10:12
             k=i-9;
             for j=1:length(J{i}(:,1))
                vec=J{i}(j,:);
                TCP_DH{k}(j,:)=Diretta(Robot,vec,Robot.numJ);
                TCP_ORIG{k}(j,:)=TCP{i}(j,:);
                E{k}(j,:)=TCP_DH{k}(j,:)-TCP{i}(j,:);
                EA{k}(j,:)=abs(TCP_DH{k}(j,:)-TCP{i}(j,:));
                E_norm{k}(j)=sqrt((E{k}(j,1))^2+(E{k}(j,2))^2+(E{k}(j,3))^2);
            end
            
        end
    end
if Traj == 6 % LR MATE 200 ic
        for i=1:3 
            for j=1:length(J{i}(:,1))
                vec=J{i}(j,:);
                TCP_DH{i}(j,:)=Diretta(Robot,vec,Robot.numJ);
                TCP_ORIG{i}(j,:)=TCP{i}(j,:);
                E{i}(j,:)=TCP_DH{i}(j,:)-TCP{i}(j,:);
                EA{i}(j,:)=abs(TCP_DH{i}(j,:)-TCP{i}(j,:));
                E_norm{i}(j)=sqrt((E{i}(j,1))^2+(E{i}(j,2))^2+(E{i}(j,3))^2);
            end
        end
    end
end

