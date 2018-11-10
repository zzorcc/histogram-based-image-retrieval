function hsv_imretrieval(im1,n)
%im1表示图片模板，n为返回的最相似的图片个数；
tic
delete('./hsvfind/*.jpg');
templt = imread(im1);
tem=rgb2hsv(templt);
qua_tem=hsv_quantization(tem);
hv=hsv_his(qua_tem);
load('hsv_data.mat');
list=dir('./image.vary.jpg/*.jpg');
L=length(list);a=0;
    for j=1:L
        d1=pdist2(hv,hsv_data(j,:),'euclidean');
        d2=corr(hv',hsv_data(j,:)','type','pearson');
        d=d1-d2;
        if d<=0
            a=a+1;
            x(a,1)=d;
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
     fin2=strcat('hsvfind/',list(sx1(ii)).name);
     if strcmp(im1,list(sx1(ii)).name)==0
        im2=imread(fin1);
        imwrite(im2,fin2);
     end
 end
 close('all')
 subplot(3,5,3),imshow(templt),title('原图');
 list=dir('./hsvfind/*.jpg');
 L=length(list);
 for i=1:L
     fin=strcat('./hsvfind/',list(i).name);
     subplot(3,5,i+5),imshow(fin),title(list(i).name);
 end
toc
disp(['运行时间：',num2str(toc)]);