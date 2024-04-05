%% sweep
% L=100;
Tp=50;
E_dc=400;E_dc_bais=0;F.gamma=0.5;
E_dc_s=0:2:E_dc;
E_dc_f=[E_dc_s,E_dc_s(end:-1:1),-E_dc_s,-E_dc_s(end:-1:1),E_dc_s];
%E_dc_s(1:end/2),E_dc_s(end/2:-1:1),
F.alpha_1= 353.43; F.alpha_2=F.alpha_1; 
F.Edc=0; F.omiga=0;
F.Eac=E_dc;

%% ODE parameters---- initializing 
Tn=0.1;
Ts=Tn/2;
options = odeset('RelTol',1e-6,'AbsTol',1e-9);
T0=[0 Tp];
pq0=[0.0 0];
i=1;
all_peaks=zeros(10,1);
a=1;
for E_dc=E_dc_f
    
    F.Eac=E_dc+E_dc_bais;
    [t, pq]=ode45(@(t,PQ)Fe_ODE_1030(t,PQ,F),T0,pq0,options);
    [peaks1,locs1] = findpeaks(pq(:,1));
    [peaks2,locs2] = findpeaks(2-pq(:,1));
    if a<600
      peaks=peaks1;
    else
        peaks=2-peaks2;
    end
    T0=[t(end) t(end)+Tp];pq0=pq(end,:);

    lengthpeaks(i)=length(peaks);
    all_peaks(1:lengthpeaks(i),i)=peaks(1:end,1);i=i+1;
    if(mod(i,10)==0) 
        disp(i);
    end
    a=a+1;
end
% t_peak=t(locs);
i=200;
figure
for E_dc=E_dc_f(200:end)
    plot(E_dc,all_peaks(1:100,i),'k.');i=i+1;hold on;
end %lengthpeaks(i)-50:lengthpeaks(i)
xlabel('E');ylabel('P')
set(gca,'FontSize',18);
annotation('arrow', [0.42,0.5], [0.18, 0.18]);
annotation('arrow', [0.6,0.52], [0.9, 0.9]);
