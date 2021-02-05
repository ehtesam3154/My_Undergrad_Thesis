% b_val = [0 143 286 429 857 1000 1500 2000 2500 3000:500:3500]; % s/mm^2
  b_val = [0 143 210 286 330 400 429 500 600 700 800 857 1000 1500];  

    S = dir('*.h5');
    C = cell(size(S));
    
    Nx = 128;
    Ny = 38;
    
    Sb_avg = zeros(Ny, numel(b_val), 3);
    Sb_stdev = zeros(Ny, numel(b_val), 3);
    
    sample_img = zeros(Nx, Ny, numel(S));
    
    for k = 1:numel(S)
        M = h5read(S(k).name, sprintf('/signal/channels/%02i',0));
        M=M';
        signal_mag = sqrt(M(:,1).^2+M(:,2).^2);
        signal_phase = zeros(length(M(:,1)),1);
        for i=1:numel(M(:,1))
            x=M(i,1);
            y=M(i,2);
            if x>=0 && y>=0
                phase = atan(y/x);
            elseif x<0 && y>0
                phase = pi - atan(abs(y/x));
            elseif x<0 && y<0
                phase = pi + atan(abs(y/x));
            elseif x>0 && y<0
                phase = -atan(abs(y/x));
            end
            signal_phase(i) = phase;
        end
        signal = signal_mag.*exp(1i*signal_phase);

         r_dim = Ny;
        c_dim = Nx;

        raw_data = reshape(signal,c_dim, r_dim)';
        raw_data(2:2:end,:) = fliplr(raw_data(2:2:end,:));

        img = fftshift(ifft2(raw_data))';
        
        C{k} = img;
        sample_img(:, :, k) = abs(img);
        figure(1); subplot(ceil(sqrt(numel(S))),ceil(sqrt(numel(S))),k); imagesc(abs(C{k}));title(strcat('b=',num2str(b_val(k))));colormap('gray');
    end
    
%     figure(2); hold on; title('defined Diffusion Coeff 7unit');
%     figure(3); hold on; title('defined Diffusion Coeff 3unit');
%     figure(4); hold on; title('defined Diffusion Coeff 0.7unit');
    rangeOffset = 5; 
    for i = 1:Ny
        for j = 1:numel(b_val)
            temp1 = sort( [sample_img(11:30, i, j), sample_img(99:118, i, j)] );
            temp2 = sort( [sample_img(33:48, i, j), sample_img(80:96, i, j)] );
            temp3 = sort( sample_img(51:76, i, j) );
            Sb_avg(i, j, 1) = mean( temp1(round(numel(temp1)/2)-rangeOffset:round(numel(temp1)/2)+rangeOffset) );
            Sb_stdev(i, j, 1) = std( temp1(round(numel(temp1)/2)-rangeOffset:round(numel(temp1)/2)+rangeOffset) );
            Sb_avg(i, j, 2) = mean( temp2(round(numel(temp2)/2)-rangeOffset:round(numel(temp2)/2)+rangeOffset) );
            Sb_stdev(i, j, 2) = std( temp2(round(numel(temp2)/2)-rangeOffset:round(numel(temp2)/2)+rangeOffset) );
            Sb_avg(i, j, 3) = mean( temp3(round(numel(temp3)/2)-rangeOffset:round(numel(temp3)/2)+rangeOffset) );
            Sb_stdev(i, j, 3) = std( temp3(round(numel(temp3)/2)-rangeOffset:round(numel(temp3)/2)+rangeOffset) );
        end
%         figure(2); subplot(6, 13, i); hold on; plot(b_val, 2.303*log(Sb_avg(i, :, 1)/Sb_avg(i, 1, 1)), 'black', 'LineWidth', 1.3); xlabel('b(s/mm^2)'); ylabel('S(b)/S(0)'); title(strcat('frame:',num2str(i)));
%         figure(2); subplot(6, 13, i+26); hold on; plot(b_val, 2.303*log(Sb_avg(i, :, 2)/Sb_avg(i, 1, 2)), 'black', 'LineWidth', 1.3); xlabel('b(s/mm^2)'); ylabel('S(b)/S(0)'); title(strcat('frame:',num2str(i)));
%         figure(2); subplot(6, 13, i+52); hold on; plot(b_val, 2.303*log(Sb_avg(i, :, 3)/Sb_avg(i, 1, 3)), 'black', 'LineWidth', 1.3); xlabel('b(s/mm^2)'); ylabel('S(b)/S(0)'); title(strcat('frame:',num2str(i)));
        figure(2); subplot(3, 13, i); hold on; plot(b_val, 2.303*log(Sb_avg(i, :, 1)/Sb_avg(i, 1, 1)), 'black', 'LineWidth', 1.3); xlabel('b(s/mm^2)'); ylabel('S(b)/S(0)'); title(strcat('frame:',num2str(i)));
        figure(3); subplot(3, 13, i); hold on; plot(b_val, 2.303*log(Sb_avg(i, :, 2)/Sb_avg(i, 1, 2)), 'black', 'LineWidth', 1.3); xlabel('b(s/mm^2)'); ylabel('S(b)/S(0)'); title(strcat('frame:',num2str(i)));
        figure(4); subplot(3, 13, i); hold on; plot(b_val, 2.303*log(Sb_avg(i, :, 3)/Sb_avg(i, 1, 3)), 'black', 'LineWidth', 1.3); xlabel('b(s/mm^2)'); ylabel('S(b)/S(0)'); title(strcat('frame:',num2str(i)));
    end
    
    
    
% %     for i = 1:38
% %         for j = 1:numel(b_val)
% %             temp = sort( sample_img(20:109, i, j) );
% %             Sb_avg(i, j) = mean( temp(end-10:end) );
% %             Sb_stdev(i, j) = std( temp(end-10:end) );
% %         end
% %         figure(4); subplot(3, 13, i); hold on; plot(b_val, Sb_avg(i, :)/Sb_avg(i, 1)); xlabel('b(s/mm^2)'); ylabel('S(b)/S(0)'); title(strcat('frame:',num2str(i)));
% %     end
    
    
        
        

