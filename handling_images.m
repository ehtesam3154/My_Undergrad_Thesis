img_png_files = dir('*.png');

load('cell_contour_mask_128x128.mat');

img_size = 128;

all_img = zeros(img_size, img_size, numel(img_png_files));
temp_img = zeros(img_size, img_size, 3, numel(img_png_files));
for i=1:numel(img_png_files)
    temp = imread(img_png_files(i).name);
    temp = double(temp);
    temp_img(:,:,:,i) = temp;
    temp1 = (temp(:,:,1)+temp(:,:,2)+temp(:,:,3))/3;
    temp1 = temp1.*MyROI;
    all_img(:, :, i) = temp1;
end

