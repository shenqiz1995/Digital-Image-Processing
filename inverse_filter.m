function [ image_restored ] = inverse_filter( r,x,y,H,image_degraded_dft )
x_r=round(x*r);
y_r=round(y*r);
H_r=ones(x,y).*100000;
H_r(1:x_r,1:y_r)=H(1:x_r,1:y_r);
image_restored_dft=image_degraded_dft./H_r;
image_restored=uint8(real(ifft2(image_restored_dft)));
end

