
temp = all_img(64, :, 1:2:end);
temp = squeeze(temp/max(temp(:)));
% % for j=size(temp, 2):-1:2
% %     temp(:, j) = temp(:,j) - temp(:,j-1);
% % end
% % figure(1); imagesc(temp);colormap('gray');
 

M0 = temp;
T1 = 1000*M0;
T2 = 90*M0;
figure(1); hold on; imagesc(temp); colormap('gray');
figure(1);xlabel('frame')
figure(1); set(gca, 'fontweight', 'bold', 'fontsize', 30)
