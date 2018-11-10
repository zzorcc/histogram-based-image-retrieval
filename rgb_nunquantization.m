function I8=rgb_nunquantization(im,b)
%非均匀量化函数
I=im;  
siz=size(I);
for i=1:siz(1)*siz(2)*siz(3)
    if b==1
        if I(i)>=0&&I(i)<32
            I(i)=0;
        elseif I(i)>=32&&I(i)<96
            I(i)=I(i)-mod(I(i),16)+7;
        elseif I(i)>=96&&I(i)<128
            I(i)=5;
        elseif I(i)>=128&&I(i)<192
           I(i)=6;
        else
            I(i)=7;
        end
    elseif b==0
        if I(i)>=0&&I(i)<64
            I(i)=0;
        elseif I(i)>=64&&I(i)<128
            I(i)=1;
        elseif I(i)>=128&&I(i)<160
            I(i)=2;
        elseif I(i)>=160&&I(i)<224
            I(i)=(I(i)-mod(I(i),16))/16-7;
        else
            I(i)=7;
        end
    end
end
I8=I;