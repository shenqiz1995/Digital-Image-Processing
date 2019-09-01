%带正则项的损失函数和梯度的计算
%正则项一般不惩罚偏置项
function [J, grad] = lrCostFunction(theta, X, y, lambda)

m = length(y); % number of training examples

%不惩罚第一项
J = (1/m)*sum((-y.*log(sigmoid(X*theta)))-(1-y).*log(1-sigmoid(X*theta)))+(lambda/(m*2))*sum(theta(2:end).*theta(2:end));
grad = (1/m)*(X'*(sigmoid(X*theta)-y))+(lambda/m)*theta;
temp=(1/m)*(X'*(sigmoid(X*theta)-y))
grad(1)=temp(1)


end
