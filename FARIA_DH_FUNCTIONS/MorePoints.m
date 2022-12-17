function Tpts = MorePoints(T,pts,rangeJ)
% T vector [x y z] , pts are number of points that we want.
% Non faccio un vero e proprio fit in 3d ma sfrutto il fatto che nel'
% LRMATE200ic i giunti ruotano in modo parallelo agli assi.
%rangeJ: 1x2 vec
%Individuo la coordinata che non cambia
tol=1e-1;
for j=1:3
    conf(j)=var(T(:,j));
end
[m,idx]=min(conf);

      if idx==1
        a=linspace(deg2rad(rangeJ(1)),deg2rad(rangeJ(2)),pts);
        [xc,yc,r]=fit_circle_2d(T(:,2),T(:,3))
        for i=1:pts
            Tpts(i,1)=T(1,idx);
            Tpts(i,2)=xc+r*cos(a(i));
            Tpts(i,3)=yc+r*sin(a(i));
        end
        end
        if idx==2
            a=linspace(deg2rad(rangeJ(1)),deg2rad(rangeJ(2)),pts);
            [xc,yc,r]=fit_circle_2d(T(:,1),T(:,3))
        for i=1:pts
            Tpts(i,1)=xc+r*cos(a(i));
            Tpts(i,2)=T(1,idx);
            Tpts(i,3)=yc+r*sin(a(i));
        end
        end
        if idx==3
            a=linspace(deg2rad(rangeJ(1)),deg2rad(rangeJ(2)),pts);
             [xc,yc,r]=fit_circle_2d(T(:,1),T(:,2))
            for i=1:pts
                Tpts(i,1)=xc+r*cos(a(i));
                Tpts(i,2)=yc+r*sin(a(i));
                Tpts(i,3)=T(1,idx);
            end
        end





% conf=[];
% for j=1:3
%     conf(j)=mean(T(:,j));
% end
% for j=1:3
%     E=abs(T(:,j)-repmat(conf(j),length(T(:,j)),1));
%     E=mean(E);
% if abs(E) < 1
%     ind=j;
%         if j==1
%         a=linspace(deg2rad(rangeJ(1)),deg2rad(rangeJ(2)),pts);
%         [xc,yc,r]=fit_circle_2d(T(:,2),T(:,3))
%         for i=1:pts
%             Tpts(i,1)=T(1,ind);
%             Tpts(i,2)=xc+r*cos(a(i));
%             Tpts(i,3)=yc+r*sin(a(i));
%         end
%         end
%         if j==2
%             a=linspace(deg2rad(rangeJ(1)),deg2rad(rangeJ(2)),pts);
%             [xc,yc,r]=fit_circle_2d(T(:,1),T(:,3))
%         for i=1:pts
%             Tpts(i,1)=xc+r*cos(a(i));
%             Tpts(i,2)=T(1,ind);
%             Tpts(i,3)=yc+r*sin(a(i));
%         end
%         end
%         if j==3
%             a=linspace(deg2rad(rangeJ(1)),deg2rad(rangeJ(2)),pts);
%             [xc,yc,r]=fit_circle_2d(T(:,1),T(:,2))
%             for i=1:pts
%                 Tpts(i,1)=xc+r*cos(a(i));
%                 Tpts(i,2)=yc+r*sin(a(i));
%                 Tpts(i,3)=T(1,ind);
%             end
%         end
% 
% 
% end
% end
% 
%    

end