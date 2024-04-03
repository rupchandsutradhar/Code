clc; 
clear all;
figure(1)
title('Ch1616');
xlabel('time');
ylabel('HBV DNA'); 

para(2,8)=0;
% para(1)=lambda,    para(2)=k,    para(3)=a, para(4)=gamma, para(5)=beta, para(6)=mu, para(7)=delta, para(8)=c      

para(1,:)=[25104026	1.309e-12	   195	      0.214	         0.864	         0.045          0.0911  	2.35];
para(2,:)=[25167241	  6.52e-12     77        0.400  	     1.55             0.01 	         0.20  	5.82];

for i=1:1:2
    if i==1
    initial_cond=[2*10^9.9  0 100 0];
    t=28:1:189;
    end
    if i==2
     initial_cond2=[567623544.519961	386584.114240160	106274979.855163	3166.6606769];
    t=189:1:413;
    end
f=@(t,y) [para(i,1)-para(i,6).*y(1)-para(i,2).*y(1).*y(4);para(i,2).*y(1).*y(4)-para(i,7).*y(2);
    para(i,3).*y(2)+para(i,4).*(1-0.8).*y(3)-0.8.*para(i,5).*y(3)-para(i,7).*y(3);
    0.8.*para(i,5).*y(3)-para(i,8).*y(4)];
if i==1
[t,y1] = ode45(f, t,initial_cond);
 semilogy(t,y1(:,3),'b-','LineWidth',2);
 hold on
end
if i==2
[t,y2] = ode45(f, t,initial_cond2);
 semilogy(t,y2(:,3),'b-','LineWidth',2);
 hold on
end
end
tdata_cases = [28; 42;	49;	56;	63;	70;	77;	84;	91;	98;	105; 112;...
    119; 126; 133;	140; 147; 154; 161;	168; 175; 182; 189; 196;...
    203; 238; 245; 252; 266; 280; 287; 294; 322; 336; 350; 364;...
    378; 399; 413];
dna_datas = [100; 851.56; 5390.82; 	24005.80; 197851.50; 1252372;...
    6650129; 24839890;	204725600;	641227000;	910224500;	585574900;...
    584773700;	489680900;	343950200;	221250300;	408930200;	263049400;...
    262634197;	184492800;	154491600;	168462900;	83235710;	34496280;...
    20319840; 248341.90; 27513.90;	7345.10; 1377.29; 3945.27; 166.15;...
    281.17; 164.91; 362.87; 163.96; 149.71; 149.28; 149.28; 149.28]; 
 semilogy(tdata_cases,dna_datas,'r*','MarkerSize',10,'LineWidth',2);
 hold on 
