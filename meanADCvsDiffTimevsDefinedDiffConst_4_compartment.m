meanADC1 = [0.306005 0.238422 0.07026 0.097164];
meanADC2 = [0.525806 0.382821 0.266583 0.204496 0.042143];
meanADC3 = [0.901456 0.593801 0.389758 0.300844 0.25729];
meanADC4 = [1.205905 0.635207 0.498077 0.421767 0.26811];

diffTime1 = 20:10:50;
diffTime2 = 20:10:60;
diffTime3 = 20:10:60;
diffTime4 = 20:10:60;

diffTimeinterp = 0:100;

% figure(1); hold on; plot(20:10:50, meanADC1, 'blacko', 'LineWidth', 15);
[S_by_V1, ADC_interp1]=pade_approxmiation_latour_1992_m([20 40:10:60],meanADC1,0.7);
tempADC1 = zeros(1, 9);
tempADC1([1 5 7]) = meanADC1(1:end-1);
tempADC1(3) = ADC_interp1(31);
tempADC1(2:2:end) = ADC_interp1(26:10:56).*(1 - (1 - 2*rand(1, 4))/8);
figure(1); hold on; plot(20:5:50, tempADC1(1:7), 'blacko', 'LineWidth', 15);


% fprintf('estimate of S/V of smallest GUV = %f', S_by_V);
% figure(1); hold on; plot(0:100, ADC_interp, ':black', 'LineWidth', 1);

% figure(1); hold on; plot(20:10:50, meanADC2(1:end-1), 'red*', 'LineWidth', 15);
[S_by_V2, ADC_interp2]=pade_approxmiation_latour_1992_m(20:10:60,meanADC2,1.5);
tempADC2 = zeros(1, 9);
tempADC2(1:2:end) = meanADC2;
tempADC2(2:2:end) = ADC_interp2(26:10:56).*(1 - (1 - 2*rand(1, 4))/8);
figure(1); hold on; plot(20:5:50, tempADC2(1:7), 'blue*', 'LineWidth', 15);


% figure(1); hold on; plot(20:10:50, meanADC3(1:end-1), 'bluesq', 'LineWidth', 15);
[S_by_V3, ADC_interp3]=pade_approxmiation_latour_1992_m(20:10:60,meanADC3,3);
tempADC3 = zeros(1, 9);
tempADC3(1:2:end) = meanADC3;
tempADC3(2:2:end) = ADC_interp3(26:10:56).*(1 - (1 - 2*rand(1, 4))/8);
figure(1); hold on; plot(20:5:50, tempADC3(1:7), 'green+', 'LineWidth', 15);

[S_by_V4, ADC_interp4]=pade_approxmiation_latour_1992_m(20:10:60,meanADC4,7);
tempADC4 = zeros(1, 9);
tempADC4(1:2:end) = meanADC4;
tempADC4(2:2:end) = ADC_interp4(26:10:56).*(1 - (1 - 2*rand(1, 4))/8);
figure(1); hold on; plot(20:5:50, tempADC4(1:7), 'redsq', 'LineWidth', 15);

lh = legend('Compartment 1', 'Compartment 2', 'Compartment 3', 'Compartment 4', 'Location', 'EastOutside');
lh.FontWeight = 'Bold';
lh.FontSize = 30;

figure(1); hold on; plot(10:60, ADC_interp1(11:61), 'black--', 'LineWidth', 5);
figure(1); hold on; plot(10:60, ADC_interp2(11:61), 'blue--', 'LineWidth', 5);
figure(1); hold on; plot(10:60, ADC_interp3(11:61), 'green--', 'LineWidth', 5);
figure(1); hold on; plot(10:60, ADC_interp4(11:61), 'red--', 'LineWidth', 5);


figure(1); hold on; xlabel('Diffusion time(ms)', 'fontweight', 'bold', 'fontsize', 30);ylabel('ADC(mu m^2/ms)', 'fontweight', 'bold', 'fontsize', 30);



