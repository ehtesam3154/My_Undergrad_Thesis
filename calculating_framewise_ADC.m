% corresponding to defined Diffusion Coefficient for comp 1
table3 = [5 1500];
  
% corresponding to defined Diffusion Coefficient for comp 2
table2 = [10 1500;...
          14 1500;...
          18 1500];
      
% corresponding to defined Diffusion Coefficient for comp 3
table1 = [9 1500;...
          13 1500;...
          19 1500];


ADC_m1 = zeros(1, size(table1,1));
ADC_m2 = zeros(1, size(table2,1));
ADC_m3 = zeros(1, size(table3,1));

for i=1:size(table1,1)
    temp_b = b_val(b_val<=table1(i, 2));
    temp_S = Sb_avg(table1(i, 1), b_val<=table1(i, 2), 1);
    p = polyfit(temp_b*1e-3, 2.303*log(temp_S), 1);
    ADC_m1(i) = -p(1);
end

for i=1:size(table2,1)
    temp_b = b_val(b_val<=table2(i, 2));
    temp_S = Sb_avg(table2(i, 1), b_val<=table2(i, 2), 2);
    p = polyfit(temp_b*1e-3, 2.303*log(temp_S), 1);
    ADC_m2(i) = -p(1);
end

for i=1:size(table3,1)
    temp_b = b_val(b_val<=table3(i, 2));
    temp_S = Sb_avg(table3(i, 1), b_val<=table3(i, 2), 2);
    p = polyfit(temp_b*1e-3, 2.303*log(temp_S), 1);
    ADC_m3(i) = -p(1);
end



figure(5); hold on; plot(table1(:, 1), ADC_m1, '--o', 'LineWidth', 1.5); xlabel('frame number'); ylabel('ADC(mu m^2/ms)');title('defined Diffusion const. for Comp.3');
figure(7); hold on; plot(table2(:, 1), ADC_m2, '--o', 'LineWidth', 1.5); xlabel('frame number'); ylabel('ADC(mu m^2/ms)');title('defined Diffusion const. for Comp.2');
figure(8); hold on; plot(table3(:, 1), ADC_m3, '--o', 'LineWidth', 1.5); xlabel('frame number'); ylabel('ADC(mu m^2/ms)');title('defined Diffusion const. for Comp.1');
% 
fprintf('mean ADC: (7, %f +- %f), (3, %f +- %f), (0.7, %f +- %f)',mean(ADC_m1),std(ADC_m1),mean(ADC_m2),std(ADC_m2),mean(ADC_m3),std(ADC_m3));

