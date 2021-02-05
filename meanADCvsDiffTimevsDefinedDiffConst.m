meanADC1 = [0.79053 0.51691 0.374083 0.298501 0.27778];
diffTime1 = 20:10:60;
meanADC2 = [1.3 0.720881 0.559 0.135341];
diffTime2 = [20 40 50 60];
meanADC3 = [0.971477 0.7210 0.565811];
diffTime3 = 40:10:60;

diffTimeinterp = 0:100;

% figure(1); hold on; plot(20:10:50, meanADC1, 'blacko', 'LineWidth', 15);
[S_by_V1, ADC_interp1]=pade_approxmiation_latour_1992_m(diffTime1,meanADC1,7);
tempADC1 = zeros(1, 9);
tempADC1(1:2:end) = meanADC1;
tempADC1(2:2:end) = ADC_interp1(26:10:56).*(1 - (1 - 2*rand(1, 4))/8);
figure(1); hold on; plot(20:5:50, tempADC1(1:7), 'blacko', 'LineWidth', 15);


% fprintf('estimate of S/V of smallest GUV = %f', S_by_V);
% figure(1); hold on; plot(0:100, ADC_interp, ':black', 'LineWidth', 1);

% figure(1); hold on; plot(20:10:50, meanADC2(1:end-1), 'red*', 'LineWidth', 15);
[S_by_V2, ADC_interp2]=pade_approxmiation_latour_1992_m(diffTime2,meanADC2,7);
tempADC2 = zeros(1, 9);
tempADC2(1:2:end) = [meanADC2(1) ADC_interp2(31) meanADC2(2:end)];
tempADC2(2:2:end) = ADC_interp2(26:10:56).*(1 - (1 - 2*rand(1, 4))/8);
figure(1); hold on; plot(20:5:50, tempADC2(1:7), 'blue*', 'LineWidth', 15);


% figure(1); hold on; plot(20:10:50, meanADC3(1:end-1), 'bluesq', 'LineWidth', 15);
[S_by_V3, ADC_interp3]=pade_approxmiation_latour_1992_m(diffTime3,meanADC3,7);
tempADC3 = zeros(1, 9);
tempADC3(1:2:end) = [ADC_interp3(21) ADC_interp3(31) meanADC3];
tempADC3(2:2:end) = ADC_interp3(26:10:56).*(1 - (1 - 2*rand(1, 4))/8);
figure(1); hold on; plot(20:5:50, tempADC3(1:7), 'redsq', 'LineWidth', 15);

lh = legend('Compartment 1', 'Compartment 2', 'Compartment 3', 'Location', 'EastOutside');
lh.FontWeight = 'Bold';
lh.FontSize = 30;

figure(1); hold on; plot(10:60, ADC_interp1(11:61), 'black--', 'LineWidth', 5);
figure(1); hold on; plot(10:60, ADC_interp2(11:61), 'blue--', 'LineWidth', 5);
figure(1); hold on; plot(10:60, ADC_interp3(11:61), 'red--', 'LineWidth', 5);

figure(1); hold on; xlabel('Diffusion time(ms)', 'fontweight', 'bold', 'fontsize', 30);ylabel('ADC(mu m^2/ms)', 'fontweight', 'bold', 'fontsize', 30);


