clear
load('Train_c_20.mat');
st=size(Train_c{1,1});
num_n=zeros(10,1);
MatrixNum=zeros(st(1)*st(2),10,10);
for i=1:20000
    MatrixNum(:,num_n(Train_c{i,2}+1)+1,Train_c{i,2}+1)=reshape([Train_c{i,1}],1,[]);
    num_n(Train_c{i,2}+1)=num_n(Train_c{i,2}+1)+1;
end
cnn=min(num_n);
%2021 6174/6124 1024 2333
%3132 7285 2135 3444
for i=1:cnn
    fa(:,i,1)=MatrixNum(:,floor(rand(1,1)*cnn+1),3);
    fa(:,i,2)=MatrixNum(:,floor(rand(1,1)*cnn+1),1);
    fa(:,i,3)=MatrixNum(:,floor(rand(1,1)*cnn+1),3);
    fa(:,i,4)=MatrixNum(:,floor(rand(1,1)*cnn+1),2);
    fb(:,i,1)=MatrixNum(:,floor(rand(1,1)*cnn+1),7);
    fb(:,i,2)=MatrixNum(:,floor(rand(1,1)*cnn+1),2);
    fb(:,i,3)=MatrixNum(:,floor(rand(1,1)*cnn+1),8);%
    fb(:,i,4)=MatrixNum(:,floor(rand(1,1)*cnn+1),5);
    fc(:,i,1)=MatrixNum(:,floor(rand(1,1)*cnn+1),2);
    fc(:,i,2)=MatrixNum(:,floor(rand(1,1)*cnn+1),1);
    fc(:,i,3)=MatrixNum(:,floor(rand(1,1)*cnn+1),3);
    fc(:,i,4)=MatrixNum(:,floor(rand(1,1)*cnn+1),5);
    fd(:,i,1)=MatrixNum(:,floor(rand(1,1)*cnn+1),3);
    fd(:,i,2)=MatrixNum(:,floor(rand(1,1)*cnn+1),4);
    fd(:,i,3)=MatrixNum(:,floor(rand(1,1)*cnn+1),4);
    fd(:,i,4)=MatrixNum(:,floor(rand(1,1)*cnn+1),4);
end
figure
subplot(221);image(reshape(fa(:,10,1),st(1),st(2)));colormap(hot);
subplot(222);image(reshape(fa(:,10,2),st(1),st(2)));colormap(hot);
subplot(223);image(reshape(fa(:,10,3),st(1),st(2)));colormap(hot);
subplot(224);image(reshape(fa(:,10,4),st(1),st(2)));colormap(hot);

save('Dataset20_2.mat','fa','fb','fc','fd')