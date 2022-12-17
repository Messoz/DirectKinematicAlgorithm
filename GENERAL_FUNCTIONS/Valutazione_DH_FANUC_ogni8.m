function Distanza_euclidea=Valutazione_DH_FANUC_ogni8 (J,Robot) 
val_J1=[-80 -64 -48 -32 -16 0 16 32 48 64 80];
val_J2=[-40 -32 -24 -16 -8 0 8 16 24 32 40];
val_J3=[-65 -52 -39 -26 -13 0 13 26 39 52 65];
val_J4=[-65 -52 -39 -26 -13 0 13 26 39 52 65];
val_J5=[-45 -36 -27 -18 -9 0 9 18 27 36 45];
val_J6=[-65 -52 -39 -26 -13 0 13 26 39 52 65];

cont=0;
for i=1:6
    for j=1:11
        cont=cont+1;
        if i==1
        Punti66(cont,:) = [val_J1(j) 0 0 0 0 0 ];
        end
         if i==2
        Punti66(cont,:) = [0 val_J2(j) 0 0 0 0 ];
         end
         if i==3
        Punti66(cont,:) = [0 0 val_J3(j) 0 0 0 ];
         end
         if i==4
        Punti66(cont,:) = [0 0 0 val_J4(j) 0 0 ];
         end
         if i==5
        Punti66(cont,:) = [0 0 0 0 val_J5(j)  0 ];
         end
         if i==6
        Punti66(cont,:) = [0 0 0 0 0 val_J6(j) ];
        end
    end
end

Punti66=deg2rad(Punti66);
cont=0;
for i=1:6
    for j=1:11
        cont=cont+1;
        Qn=Diretta(Robot,Punti66(cont,:),6);
        TCP_DH(cont,:)=Qn;
        TCP_J(cont,:)=J{i}(j,1:3);
        AE(cont,:)=abs(TCP_J(cont,:)-TCP_DH(cont,:));
        Distanza_euclidea(cont)=sqrt(AE(cont,1)^2+AE(cont,2)^2+AE(cont,3)^2);
    end
end

%% PLOTTO GLI ERRORI PER GIUNTO

M_D_e_1=mean(Distanza_euclidea(1:11));
M_D_e_2=mean(Distanza_euclidea(12:22));
M_D_e_3=mean(Distanza_euclidea(23:33));
M_D_e_4=mean(Distanza_euclidea(34:44));
M_D_e_5=mean(Distanza_euclidea(45:55));
M_D_e_6=mean(Distanza_euclidea(56:66));
figure
bar([M_D_e_1 M_D_e_2 M_D_e_3 M_D_e_4 M_D_e_5 M_D_e_6])
xlabel('giunti')
ylabel('MEDIA Distanza euclidea errore [mm]')
figure
plot(Distanza_euclidea,'r',LineWidth=1)
hold on 
xline([11 23 34 45 56 66],'--b')
xlabel('giunti')
ylabel('Distanza euclidea errore [mm]')