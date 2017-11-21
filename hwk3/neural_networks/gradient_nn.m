function [grad_s_Wi, grad_s_Wo, grad_s_bi, grad_s_bo] = ...
                                gradient_nn(X,Y,Wi,bi,Wo,bo)
% Compute gradient of the logistic loss of the 
% neural network on example X with target label Y, 
% with respect to the parameters Wi,bi,Wo,bo.
%
% Input: X ... 2x1 vector of the input example
%        Y ... 1x1 the target label in {-1,1}   
%        Wi,bi,Wo,bo ... parameters of the network
%        Wi ... [hxd]
%        bi ... [hx1]
%        Wo ... [1xh]
%        bo ... 1x1
%        where h... is the number of hidden units
%              d... is the number of input dimensions (d=2)
%
% Output: 
%  grad_s_Wi [hxd] ... gradient of loss s(Y,Y(X)) w.r.t  Wi
%  grad_s_Wo [1xh] ... gradient of loss s(Y,Y(X)) w.r.t. Wo
%  grad_s_bi [hx1] ... gradient of loss s(Y,Y(X)) w.r.t. bi
%  grad_s_bo [1x1] ... gradient of loss s(Y,Y(X)) w.r.t. bo
%

% To be completed:
% H output of first layer
H = max(0, Wi * X + bi);
% Y output
Yo = Wo * H + bo;
% gradient of loss w.r.t. Yo
grad_s_Yo = -Y .* exp(-Y .* Yo) .* sigm(-Y .* Yo);

grad_s_Wi = grad_s_Yo .* Wo' * X' .* ( Wi * X + bi > 0);
grad_s_Wo = grad_s_Yo .* H';
grad_s_bi = grad_s_Yo .* ones(length(bi), 1) .* ( Wi * X + bi > 0);
grad_s_bo = Yo;

 
end

