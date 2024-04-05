%% %%  parameters--
clear
close all
% v
% E_dc=500; F.gamma=0.1; duty_cycle=0.6;T0=2;pq0=[1.0 0]; 0.9375 0.9730
E_dc=200; F.gamma=0.1; duty_cycle=0.6;T0=0.75;pq0i=[1.41431 0];
ttall={'0000','0001','0010','0011','0100','0101','0110','0111', ...
        '1000','1001','1010','1011','1100','1101','1110','1111'};
% nv
E_dc_bais=100;
F.alpha_1= 353.43; F.alpha_2=F.alpha_1; F.omiga=0;F.Edc=0; F.Eac=E_dc;

%% ODE solver
options = odeset('RelTol',1e-6,'AbsTol',1e-9);

% F.Eac=E_dc+E_dc_bais;
% [t1, pq1]=ode45(@(t,PQ)Fe_ODE_1030(t,PQ,F),[0 T0],pq0,options);
% ti=t1(end);pqi=pq1(end,:);

combination_input=[0 0 0 0; 0 0 0 1; 0 0 1 0; 0 0 1 1;
    0 1 0 0; 0 1 0 1; 0 1 1 0; 0 1 1 1;
    1 0 0 0; 1 0 0 1; 1 0 1 0; 1 0 1 1;
    1 1 0 0; 1 1 0 1; 1 1 1 0; 1 1 1 1;];
figure;
talli=0;pqalli=pq0i(:,1);
for i=1:length(combination_input)
    tall=talli;pqall=pqalli;
    pq0=pq0i;% !!!
    for j=1:4
        if(combination_input(i,j)==1)
            E_dc_t=E_dc;
        else
            E_dc_t=0;
        end
        
        F.Eac=E_dc_t+E_dc_bais;
        [t1, pq1]=ode45(@(t,PQ)Fe_ODE_1030(t,PQ,F),talli+[T0*(j-1) T0*(j-1+duty_cycle)],pq0,options);
        F.Eac=0+E_dc_bais;
        [t2, pq2]=ode45(@(t,PQ)Fe_ODE_1030(t,PQ,F),talli+[T0*(j-1+duty_cycle) T0*(j)],pq1(end,:),options);
        t=[t1;t2];pq=[pq1;pq2];
        [peaks,locs] = findpeaks(pq(:,1));
        result(i,j)=peaks(end);
        pq0=pq(end,:);
        tall(end+1:end+length(t),1)=t;pqall(end+1:end+length(t),1)=pq(:,1);
    end
%     plot(result(i,:),'-x');hold on;
subplot(4,4,i);plot(tall,pqall);ylim([-2 2]);
if mod(i,4)~=1
    set(gca,'YTick',[])
else
    ylabel('P_i');
end

if i<13
    set(gca,'XTick',[])
else
    xlabel('t');
end
title(ttall{i});set(gca,'FontSize',12)
end
save('result.mat','result')
