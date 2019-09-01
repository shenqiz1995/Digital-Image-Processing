%�����������ʧ�������ݶȵļ���
%������һ�㲻�ͷ�ƫ����
function [J, grad] = lrCostFunction(theta, X, y, lambda)

m = length(y); % number of training examples

%���ͷ���һ��
J = (1/m)*sum((-y.*log(sigmoid(X*theta)))-(1-y).*log(1-sigmoid(X*theta)))+(lambda/(m*2))*sum(theta(2:end).*theta(2:end));
grad = (1/m)*(X'*(sigmoid(X*theta)-y))+(lambda/m)*theta;
temp=(1/m)*(X'*(sigmoid(X*theta)-y))
grad(1)=temp(1)


end
