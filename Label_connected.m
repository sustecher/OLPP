function [seg_CC] = Label_connected(seg)
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
% label connected and save the largest one
    [L,num] = bwlabeln(seg);
    A=zeros(num,1);
    
    for i=1:num
    A(i,1)=size(find(L==i),1);
    end
    
    seg_CC=zeros(size(seg));
    seg_CC(L==find(A==max(A)))=1;
    seg_CC=double(seg_CC);
    
end

