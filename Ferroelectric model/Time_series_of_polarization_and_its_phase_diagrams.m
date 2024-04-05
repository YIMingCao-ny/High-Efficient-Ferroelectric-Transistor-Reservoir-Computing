%% 
F.gamma=100;%0.0;
F.alpha_1= 353.43; F.alpha_2=F.alpha_1; 
F.Edc=0; F.omiga=0;
F.Eac=0;

Tn=0.01;

Ts=Tn/2;
% options = odeset('RelTol',1e-3,'AbsTol',1e-6);
% options = odeset('RelTol',1e-6,'AbsTol',1e-9);
options = odeset('RelTol',1e-6,'AbsTol',1e-9);
T0=30;
pq0=[-0.1 0];
[t1, pq1]=ode45(@(t,PQ)Fe_ODE_1030(t,PQ,F),0:Ts:T0,pq0,options);

subplot(121);plot(t1,pq1(:,1),'r');title('(a)'); hold on;
xlabel('t');ylabel('P_i');set(gca,'FontSize',12);
subplot(122);plot(pq1(:,1),pq1(:,2),'r');title('(b)'); hold on;
xlabel('P_i');ylabel('Q_i');set(gca,'FontSize',12);

pq0=[0.1 0];
[t1, pq1]=ode45(@(t,PQ)Fe_ODE_1030(t,PQ,F),0:Ts:T0,pq0,options);

subplot(121);plot(t1,pq1(:,1));title('(a)');
xlabel('t');ylabel('P_i');set(gca,'FontSize',12);
subplot(122);plot(pq1(:,1),pq1(:,2));title('(b)');
xlabel('P_i');ylabel('Q_i');set(gca,'FontSize',12);
subplot(122);legend('P_i(t=0)=-0.1','P_i(t=0)=0.1');