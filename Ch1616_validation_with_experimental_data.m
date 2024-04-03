clc; 
clear all;
figure(1)
title('Ch1616');
xlabel('time');
ylabel('HBV DNA'); 

para(2,8)=0;
% para(1)=lambda,    para(2)=k,    para(3)=a, para(4)=gamma, para(5)=beta, para(6)=mu, para(7)=delta, para(8)=c      
% para(1,:)=readmatrix('28_182_para.txt');
% para(2,:)=readmatrix('182_385_para.txt');
 para(1,:)=[25398026 3.183e-12  172   0.29  2.9293  0.066   0.0718  3.809];
 para(2,:)=[25829482 1.001e-12  110   0.49   2.0000  0.019   0.0380  4.485];

for i=1:1:2
    if i==1
    initial_cond=[2*10^9.9  0 100 0];
    t=28:1:189;
    end
    if i==2
%      initial_cond2=[567623544.519961	386584.114240160	106274979.855163	3166.6606769];
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
[t,y2] = ode45(f, t,initial_cond);
 semilogy(t,y2(:,3),'b-','LineWidth',2);
 hold on
end
if i==1
 initial_cond=y1(end,:);
end
if i==2
 initial_cond=y2(end,:);
end

end
tdata_cases = [28; 35; 42; 49; 56; 63; 70; 77; 84; 91; 98; 105; 112; 119;...
    126; 133; 140; 147; 154; 161; 168; 175; 182; 189; 196; 203; 210; 217; 224;...
               231; 238; 245; 252; 259; 266; 273; 280; 287; 294; 301;...
               315; 329; 343; 357; 371; 385];
dna_datas = [100; 1365.57; 17547.90; 912842.90; 8145000; 375195300;...
     6534036000; 14401770000; 10626800000; 8855125000; 6534036000;...
     11292890000; 4017542000; 5444696000; 2187429000; 2187430000;...
     1190989000; 4536968000; 1715234000; 3347746000; 1190989000;...
     2625076000;  1715234000; 2964471000; 1715234000; 1822746000;...
      992429500; 1012746000; 1518861000; 1054635000; 133478900;...
      141845400; 450262100; 217086900; 450262100; 276849800;...
     540347700; 732295700; 2470241000; 992429500; 276849800;...
     77230490; 133478900; 133478900; 150736300; 294202800]; 
 semilogy(tdata_cases,dna_datas,'r*','MarkerSize',10,'LineWidth',2);
 hold on 
