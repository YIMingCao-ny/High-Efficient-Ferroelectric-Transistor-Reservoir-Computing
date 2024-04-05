function [dPQ] = Fe_ODE_1030(t, PQ, F)
% PQ 1: P; 2: Q
dPQ(1,1)=PQ(2);
dPQ(2,1)=-F.gamma*PQ(2)+F.alpha_1*PQ(1)-F.alpha_2*PQ(1)^3+F.Edc+F.Eac*cos(F.omiga*t);