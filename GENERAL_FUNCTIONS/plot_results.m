function plot_results(traj,E,EA,Enorm,TCP_DH,TCP_O)
%PLOT_RESULTS Summary of this function goes here

if traj == 6
    t=["Circle","S","Rect"];
    for i=1:3
    figure
    plot(E{i})
    title([t(i)])
    legend("x","y","z")
    xlabel("N points")
    ylabel("E[mm]")
    end
     for i=1:3
    figure
    plot(EA{i})
    title([t(i)])
    legend("x","y","z")
    xlabel("N points")
    ylabel("EA[mm]")
     end
    for i=1:3
    figure
    plot(Enorm{i})
    title([t(i)])
    legend("x","y","z")
    xlabel("N points")
    ylabel("Enorm[mm]")
    end
    for i=1:3
    figure
    plot3(TCP_DH{1}(:,1),TCP_DH{1}(:,2),TCP_DH{1}(:,3),'*b')
    hold on
    plot3(TCP_O{1}(:,1),TCP_O{1}(:,2),TCP_O{1}(:,3),'*r')
    title([t(i)])
    xlabel("x[mm]")
    ylabel("y[mm]")
    zlabel("z[mm]")
    legend('model','real')
    end
else
opts2 = ["Circle","Spiral","S","Rect"];
figure

subplot(1,3,1)
plot(E{1})
title([opts2(traj)])
legend("x","y","z")
xlabel("N points")
ylabel("E[mm]")

subplot(1,3,2)
plot(E{2})
title([opts2(traj)+"120"])
legend("x","y","z")
xlabel("N points")
ylabel("E[mm]")

subplot(1,3,3)
plot(E{3})
title([opts2(traj)+"80"])
legend("x","y","z")
xlabel("N points")
ylabel("E[mm]")

figure

subplot(1,3,1)
plot(EA{1})
title([opts2(traj)])
legend("x","y","z")
xlabel("N points")
ylabel("AE[mm]")

subplot(1,3,2)
plot(EA{2})
legend("x","y","z")
title([opts2(traj)+"120"])
xlabel("N points")
ylabel("AE[mm]")

subplot(1,3,3)
plot(EA{3})
title([opts2(traj)+"80"])
legend("x","y","z")
xlabel("N points")
ylabel("AE[mm]")

figure
subplot(1,3,1)
plot(Enorm{1},'.r')
title([opts2(traj)])
xlabel("N points")
ylabel("SE[mm]")

subplot(1,3,2)
plot(Enorm{2},'.r')
title([opts2(traj)+"120"])
xlabel("N points")
ylabel("SE[mm]")

subplot(1,3,3)
plot(Enorm{3},'.r')
title([opts2(traj)+"80"])
xlabel("N points")
ylabel("SE[mm]")

figure
subplot(1,3,1)
plot3(TCP_DH{1}(:,1),TCP_DH{1}(:,2),TCP_DH{1}(:,3),'*b')
hold on
plot3(TCP_O{1}(:,1),TCP_O{1}(:,2),TCP_O{1}(:,3),'*r')
title([opts2(traj)])
xlabel("x[mm]")
ylabel("y[mm]")
zlabel("z[mm]")
legend('model','real')

subplot(1,3,2)
plot3(TCP_DH{2}(:,1),TCP_DH{2}(:,2),TCP_DH{2}(:,3),'*b')
hold on
plot3(TCP_O{2}(:,1),TCP_O{2}(:,2),TCP_O{2}(:,3),'*r')
title([opts2(traj)+"120"])
xlabel("x[mm]")
ylabel("y[mm]")
zlabel("z[mm]")
legend('model','real')

subplot(1,3,3)
plot3(TCP_DH{3}(:,1),TCP_DH{3}(:,2),TCP_DH{3}(:,3),'*b')
hold on
plot3(TCP_O{3}(:,1),TCP_O{3}(:,2),TCP_O{3}(:,3),'*r')
title([opts2(traj)+"80"])
xlabel("x[mm]")
ylabel("y[mm]")
zlabel("z[mm]")
legend('model','real')
end
end

