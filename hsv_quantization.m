function qua_im=hsv_quantization(im)
%hsv量化为24*4*4=384个统计点
I=im;  
siz=size(I);
i1=I(:,:,1);i1=round(360.*i1);
i2=I(:,:,2);
i3=I(:,:,3);
for i=1:siz(1)*siz(2)
    i1(i)=(i1(i)-mod(i1(i),15))/15;
end
for i=1:siz(1)*siz(2)
    i2(i)=(i2(i)-mod(i2(i),0.2))/0.2;
end
for i=1:siz(1)*siz(2)
    i3(i)=(i3(i)-mod(i3(i),0.2))/0.2;
end
I(:,:,1)=i1;
I(:,:,2)=i2;
I(:,:,3)=i3;
qua_im=I;