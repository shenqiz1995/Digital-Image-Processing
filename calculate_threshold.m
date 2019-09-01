function [ threshold ] = calculate_threshold( image )
%计算最佳阈值
%   采用书本p215的方法
n=zeros(256,1);
variance=zeros(256,1);
for i=0:255
    %注意下标，有1的差值
    n(i+1,1)=size(find(image==i),1);
end
%%%
for t=1:256
    N0=0;
    N1=0;
    U0=0;
    U1=0;
    for m=1:t
        N0=N0+n(m,1);
        U0=U0+(m-1)*n(m,1);
    end    
    for m=t+1:256
        N1=N1+n(m,1);
        U1=U1+(m-1)*n(m,1);
    end
    w0=N0/(256^2);
    w1=N1/(256^2);
    u0=U0/(256^2)/w0;
    u1=U1/(256^2)/w1;
    variance(t,1)=w1*w0*((u1-u0)^2);
end
threshold=find(variance==max(max(variance)))-1;
end

