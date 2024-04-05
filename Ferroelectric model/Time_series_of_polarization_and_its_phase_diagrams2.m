F.gamma=100;%0.0;
F.alpha_1= 353.43; F.alpha_2=F.alpha_1; 
F.Edc=20; F.omiga=0;
F.Eac=0;

Tn=0.01;
Ts=Tn/2;
% options = odeset('RelTol',1e-3,'AbsTol',1e-6);
% options = odeset('RelTol',1e-6,'AbsTol',1e-9);
options = odeset('RelTol',1e-6,'AbsTol',1e-9);
T0=5;
pq0=[0 0];
[t1, pq1]=ode45(@(t,PQ)Fe_ODE_1030(t,PQ,F),0:Ts:T0,pq0,options);
F.Edc=100;
[t2, pq2]=ode45(@(t,PQ)Fe_ODE_1030(t,PQ,F),T0:Ts:T0+T0,pq1(end,:),options);
t=[t1;t2];pq=[pq1;pq2];
% [peaks,locs] = findpeaks(pq(:,1));
figure
subplot(121);plot(t,pq(:,1));title('(c)');
xlabel('t');ylabel('P_i');set(gca,'FontSize',18);ylim([0 1.2])
subplot(122);plot(pq(:,1),pq(:,2));title('(d)');
xlabel('P_i');ylabel('Q_i');set(gca,'FontSize',18);xlim([0 1.2]);ylim([0 1.6])