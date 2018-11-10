function I8=rgb_quantization(im)
%均匀量化函数
I=im;  
siz=size(I);
for i=1:siz(1)*siz(2)*siz(3)
    I(i)=(I(i)-mod(I(i),32))/32;
end
I8=I;
    