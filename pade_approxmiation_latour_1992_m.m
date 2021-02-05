function [S_by_V, ADC_perp_interp]=pade_approxmiation_latour_1992_m(diff_times,ADC_perp,D0)
diff_times = diff_times(:);
ADC_perp = ADC_perp(:);
S_by_V = ( 1-(ADC_perp(1)/D0) )*(9*sqrt(pi)/4)/sqrt(D0*diff_times(1)); % /mu m
% cf = ADC_alphaSV_01(diff_times,ADC_perp,D0);
% S_by_V = cf.S_by_V;
% --- Create fit "fit 2"
% fo_ = fitoptions('method','NonlinearLeastSquares','Lower',[1 50],'Upper',[5 3000]);
fo_ = fitoptions('method','NonlinearLeastSquares');
ok_ = isfinite(diff_times) & isfinite(ADC_perp);
if ~all( ok_ )
    warning( 'GenerateMFile:IgnoringNansAndInfs',...
        'Ignoring NaNs and Infs in data.' );
end
st_ = [1 1];
%st_ = 10;
set(fo_,'Startpoint',st_);
c = (4/(9*sqrt(pi)))*S_by_V*sqrt(D0);
% % ft_ = fittype('1-(1-1/alpha)*(c*sqrt(DEL)+(1-1/alpha)*DEL/theta)/((1-1/alpha)+c*sqrt(DEL)+(1-1/alpha)*DEL/theta)',...
% %     'dependent',{'y'},'independent',{'DEL'},...
% %     'coefficients',{'alpha','theta'});

ft_ = fittype(@(alpha,theta,DEL) 1-(1-1/alpha)*(c*sqrt(DEL)+(1-1/alpha)*DEL/theta)./((1-1/alpha)+c*sqrt(DEL)+(1-1/alpha)*DEL/theta),...
    'independent','DEL',...
    'coefficients',{'alpha','theta'});


% Fit this model using new data
cf = fit(diff_times(ok_),ADC_perp(ok_)/D0,ft_,fo_);
diff_times_new = 0:1:diff_times(end)*2; %ms
ADC_perp_interp = D0*( 1-(1-1/cf.alpha)*(c*sqrt(diff_times_new)+(1-1/cf.alpha)*diff_times_new/cf.theta)./...
                            ((1-1/cf.alpha)+c*sqrt(diff_times_new)+(1-1/cf.alpha)*diff_times_new/cf.theta) );
% % figure(80);hold on;xlabel('Diffusion_time');ylabel('ADC(perp) interpolated');
% % figure(80); hold on;plot(diff_times_new,ADC_perp_new);title('Interpolated(Pade approximation)ADC(perp) vs Diffusion time');
end
