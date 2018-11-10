function hv=rgb_his(im)
[row,col,~]=size(im);
kk=zeros(row,col);
for ii=1:row
    for jj=1:col
        k=im(ii,jj,:);
        kk(ii,jj)=k(3)+k(2)*8+k(1)*8^2;
    end
end
h=histogram(kk,0:512,'Normalization','probability');
hv=h.Values;
