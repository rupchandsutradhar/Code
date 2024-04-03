    %Ch1603
    clear all;
    close all;
    clc;
    tic;
    format long
    global tdata_cases dna_datas initial_cond tforward
   tinitial=28;
    tforwardlast=182;
    tend=(tforwardlast-tinitial)*10+1;
  tforward = tinitial:0.1:tforwardlast;

tdata_cases = [28; 35; 42; 49; 56; 63; 70; 77; 84; 91; 98; 105; 112; 119;...
    126; 133; 140; 147; 154; 161; 168; 175; 182];

 dna_datas = [100; 1365.57; 17547.90; 912842.90; 8145000; 375195300;...
     6534036000; 14401770000; 10626800000; 8855125000; 6534036000;...
     11292890000; 4017542000; 5444696000; 2187429000; 2187430000;...
     1190989000; 4536968000; 1715234000; 3347746000; 1190989000;...
     2625076000; 1715234000]; 
     
% Initial value of parameter
% params = lambda,        k,           a,     gamma,     beta,     mu,     delta,     c      
 params = [26000000, 6.96843E-12,     140,     0.88,     0.87,    0.821,  0.01199,   4.53]; 
 lb = [25000000      1.67*10^(-15)    100        0        0         0     0.01       0.1];   % lower bound
 ub = [27000000      1.67*10^(-5)     150        1        3         1      0.1        4];   % Upper bound
 % initial condition
 initial_cond = [2*10^9.9  0 100 0];
%  tinitialp=28;
%     tforwardlastp=42;
%     tendp=(tforwardlastp-tinitialp)*10+1;
%   solution_previous_point=readmatrix('42_sol.txt');
%  initial_cond = [solution_previous_point(tendp,2),solution_previous_point(tendp,3),...
%      solution_previous_point(tendp,4),solution_previous_point(tendp,5)];
  [params,fval] = fminsearchbnd(@err_in_data, params, lb, ub, optimset('Display','iter'));
% [params,fval] = fminsearch(@err_in_data, params, optimset('Display','iter'));

 [~, Y] = ode45(@(t,y) model_1(t,y, params), tforward, initial_cond);

figure(1)
semilogy(tforward,Y(:,3),'-');
hold on 
semilogy(tdata_cases, dna_datas, 'r.', 'MarkerSize',20);
title('Chimpanzee-1616');
saveas(gcf,'Ch1616_28_182','fig');
saveas(gcf,'Ch1616_28_182','jpg');
 filename = 'Ch1603_28_182.xlsx';
 D=[tforward'  Y];
 writematrix(D,'28_182_sol');

 
 display('Parameters after data fitting:\n');
fprintf('lambda = %g\n', params(1));
 fprintf('k = %g\n',  params(2));   
 fprintf('a = %g\n', params(3));
 fprintf('gamma = %g\n', params(4));
 fprintf('beta = %g\n',  params(5));
%  fprintf('eta = %g\n', params(6));
 fprintf('mu = %g\n',  params(6));
 fprintf('delta = %g\n',  params(7));
 fprintf('c = %g\n',  params(8));
 estimate_para=[params(1) params(2) params(3) params(4) params(5) params(6) params(7) params(8)];
 filename = '28_182_para.xlsx';
 writematrix(estimate_para,'28_182_para');
toc

 function dy = model_1(t,y,params)
          dy = zeros(4,1);        
          %  Model Parameters
          lambda = params(1);
          k = params(2);
          a = params(3);
          gamma = params(4);
          beta = params(5);
          mu = params(6);
          delta = params(7);
          c = params(8);
        
          % Model equations 
        dy(1) = lambda-mu*y(1)-k*y(1)*y(4);
        dy(2) = k*y(1)*y(4)-delta*y(2);
        dy(3) = a*y(2)+gamma*(1-0.8)*y(3)-0.8*beta*y(3)-delta*y(3);
        dy(4) = 0.8*beta*y(3)-c*y(4);
 end

% function error_in_data = err_in_data(k1)
% global tforward initial_cond
% [~,y] = ode15s(@(t,y)Model_Corona(y,k),tforward,initial_cond);
% 
% end
function error_in_data = err_in_data(k1)

tdata = [28; 35; 42; 49; 56; 63; 70; 77; 84; 91; 98; 105; 112; 119;...
    126; 133; 140; 147; 154; 161; 168; 175; 182];

qdata = [100; 1365.57; 17547.90; 912842.90; 8145000; 375195300;...
     6534036000; 14401770000; 10626800000; 8855125000; 6534036000;...
     11292890000; 4017542000; 5444696000; 2187429000; 2187430000;...
     1190989000; 4536968000; 1715234000; 3347746000; 1190989000;...
     2625076000; 1715234000]; 
  tforwardlast=182;
  tforward = 28:0.1:tforwardlast;
  [T Y] = ode23s(@(t,y)(model_1(t,y,k1)),tforward,[2*10^9.9  0 100 0]);
  v=1;
  texplast=23;
    q(texplast)=0;
    for i=1:1540 %3931/721
        for j=1:texplast
             if (tforward(i)==tdata(j))
         q(v)=Y(i,3);
         v=v+1;
             end
        end
    end
  error_in_data = sqrt(sum((q' - qdata).^2))
 end
%%
