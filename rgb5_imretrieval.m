function rgb5_imretrieval(im1,n,a1,a2)
%im1表示图片模板，n为返回的最相似的图片个数；
tic
delete('./rgbfind/*.jpg');
templt = imread(im1);
[r,c,~]=size(templt);
r=r+mod(r,2);c=c+mod(c,2);
qua_tem=rgb_quantization(templt);
load('rgb5_data.mat');
fun=@(block_struct) rgb_his(block_struct.data) ;
v=blockproc(qua_tem,[r/2 c/2],fun);
v=[v(1,:) v(2,:)];
v1=rgb_his(qua_tem);v=[v1 v];
list=dir('./image.vary.jpg/*.jpg');
L=length(list);a=0;d=zeros(1,5);
    for j=1:L
        b=0;dmin=0;
        for i=1:5
        d1=pdist2(v(512*(i-1)+1:512*i),rgb5_data(j,512*(i-1)+1:512*i),'euclidean');
        d2=corr(v(512*(i-1)+1:512*i)',rgb5_data(j,512*(i-1)+1:512*i)','type','pearson');
        d(i)=d1-d2;
        if d(i)<=a1
            b=b+1;
            dmin=dmin+d(i);
        end
        end
        %其他评判算法参考
        %d1=pdist2(v(1,:),rgb_data(j,:),'euclidean');
        %d2=corr(v(1,:)',rgb_data(j,:)','type','pearson');
        %dmin=d1*5-d2;
        %if d1<=0.5
        if b>=4&&d(1)<=a2
           a=a+1;
           x(a,1)=a1*(dmin-d(1))/(b-1)+a2*d(1);
           x(a,2)=j;
        end
    end
 sx=sortrows(x,1);
 sx1=sx(:,2);l_sx1=length(sx1);
 if l_sx1<n
     nn=l_sx1;
     fprintf('only %d pictures are found\n',nn-1);
 else nn=n+1;
 end     
 for ii=1:nn
     fin1=strcat('./image.vary.jpg/',list(sx1(ii)).name);
     fin2=strcat('rgbfind/',list(sx1(ii)).name);
     if strcmp(im1,list(sx1(ii)).name)==0
        im2=imread(fin1);
        imwrite(im2,fin2);
     else nn=nn;
     end
 end
 close('all')
 subplot(3,5,3),imshow(templt),title('原图');
 list=dir('./rgbfind/*.jpg');
 L=length(list);
 for i=1:L
     fin=strcat('./rgbfind/',list(i).name);
     subplot(3,5,i+5),imshow(fin),title(list(i).name);
 end
toc
disp(['运行时间：',num2str(toc)]);