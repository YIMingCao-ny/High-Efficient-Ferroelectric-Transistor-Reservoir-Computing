%% %%  parameters--
clear
close all
load('Dataset20_2.mat');
Ntrain=1200; Ntest=400;
% v
E_dc=200; F.gamma=0.1; duty_cycle=0.6;T0=0.75;E_dc_bais=100;pqi=[1.414 0]; %0.9375 0.9730
% E_dc=300; F.gamma=0.10; duty_cycle=0.6;T0=1;E_dc_bais=200;pqi=[1.21 0];
% E_dc=400; F.gamma=0.12; duty_cycle=0.75;T0=1;E_dc_bais=100;pqi=[1.21 0]; %0.9375 0.9730

% nv
F.alpha_1= 353.43; F.alpha_2=F.alpha_1; F.omiga=0;F.Edc=0; F.Eac=E_dc;
ti=0;
%% ODE solver 求解精度
options = odeset('RelTol',1e-6,'AbsTol',1e-9);

%% 获取组合输入
combination_input=[0 0 0 0; 0 0 0 1; 0 0 1 0; 0 0 1 1;
    0 1 0 0; 0 1 0 1; 0 1 1 0; 0 1 1 1;
    1 0 0 0; 1 0 0 1; 1 0 1 0; 1 0 1 1;
    1 1 0 0; 1 1 0 1; 1 1 1 0; 1 1 1 1;];

for i=1:length(combination_input)
    pq0=pqi;% !!!
    for j=1:4
        if(combination_input(i,j)==1)
            E_dc_t=E_dc;
        else
            E_dc_t=0;
        end
        
        F.Eac=E_dc_t+E_dc_bais;
        [t1, pq1]=ode45(@(t,PQ)Fe_ODE_1030(t,PQ,F),ti+[T0*(j-1) T0*(j-1+duty_cycle)],pq0,options);
        F.Eac=0+E_dc_bais;
        [t2, pq2]=ode45(@(t,PQ)Fe_ODE_1030(t,PQ,F),ti+[T0*(j-1+duty_cycle) T0*(j)],pq1(end,:),options);
        t=[t1;t2];pq=[pq1;pq2];
        [peaks,locs] = findpeaks(pq(:,1));
        result(i,j)=peaks(end);
        pq0=pq(end,:);
    end
end
%save('result.mat',"result")

%% 获取图片组合并匹配组合输�?
con=size(fa);
threshold=127;

for i=1:con(1)
    for j=1:con(2)
        t=reshape((fa(i,j,:)>threshold),1,4);
        output(i,j,1)=result(t(1)*8+t(2)*4+t(3)*2+t(4)*1+1,4);

        t=reshape((fb(i,j,:)>threshold),1,4);
        output(i,j,2)=result(t(1)*8+t(2)*4+t(3)*2+t(4)*1+1,4);

        t=reshape((fc(i,j,:)>threshold),1,4);
        output(i,j,3)=result(t(1)*8+t(2)*4+t(3)*2+t(4)*1+1,4);

        t=reshape((fd(i,j,:)>threshold),1,4);
        output(i,j,4)=result(t(1)*8+t(2)*4+t(3)*2+t(4)*1+1,4);
    end
end
%% 回归
Xtr=[output(:,1:Ntrain,1),output(:,1:Ntrain,2),output(:,1:Ntrain,3),output(:,1:Ntrain,4)];
A1=zeros(4,Ntrain);A1(1,:)=1;
A2=zeros(4,Ntrain);A2(2,:)=1;
A3=zeros(4,Ntrain);A3(3,:)=1;
A4=zeros(4,Ntrain);A4(4,:)=1;
Ytr=[A1,A2,A3,A4];

W=Ytr/Xtr;
% W=Ytr*Xtr'*(Xtr*Xtr'+eye(400)*.001)^(-1);
%% 测试
Xp=[output(:,Ntrain+1:Ntrain+Ntest,1),output(:,Ntrain+1:Ntrain+Ntest,2),output(:,Ntrain+1:Ntrain+Ntest,3),output(:,Ntrain+1:Ntrain+Ntest,4)];
B1=zeros(4,Ntest);B1(1,:)=1;
B2=zeros(4,Ntest);B2(2,:)=1;
B3=zeros(4,Ntest);B3(3,:)=1;
B4=zeros(4,Ntest);B4(4,:)=1;
Ytar=[B1,B2,B3,B4];

Yr=W*Xtr;
Yp=W*Xp;
%% 结果展示
[~,locsr]=max(Yr);
[~,locso]=max(Ytr);
finalreg=sum(locsr==locso)/Ntrain/4
[~,locsp]=max(Yp);
[~,locstar]=max(Ytar);
finalpre=sum(locstar==locsp)/Ntest/4

