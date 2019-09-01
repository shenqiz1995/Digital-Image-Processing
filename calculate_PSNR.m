function [ PSNR ] = calculate_PSNR( figure1,figure2 )
figure1=double(figure1);
figure2=double(figure2);
MSE=sum(sum((figure1-figure2).^2))/(256^2);
PSNR=10*log10((256^2)/MSE);
end

