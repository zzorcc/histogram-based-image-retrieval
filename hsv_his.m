function hv=hsv_his(im)
[row,col,~]=size(im);
kk=zeros(row,col);
for ii=1:row
    for jj=1:col
        k=im(ii,jj,:);
        kk(ii,jj)=k(1)+k(2)*24+k(3)*24*5;
    end
end
h=histogram(kk,0:600,'Normalization','probability');
hv=h.Values;
