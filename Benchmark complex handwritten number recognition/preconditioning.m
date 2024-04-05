%% 28 28 to 21 21

load('Train.mat');%load('Test.mat');
start=1;len=60000;intervl=1;
Train_c=Train(start:intervl:start+len*intervl-1,:);
cc=300;
for j=1:len

temp=cell2mat(Train(start+j-1,1));
f_l=0;f_r=0;f_u=0;f_d=0;
for i=1:28
    if (f_l==0)
        if(sum(temp(i,:))>cc)
            f_l=i;
        end
    else
        if(i>13&&sum(temp(i,:))<cc)
            f_r=i;
            break;
        end
    end
end

for i=1:28
    if (f_u==0)
        if(sum(temp(:,i))>cc)
            f_u=i;
        end
    else
        if(i>13&&sum(temp(:,i))<cc)
            f_d=i;
            break;
        end
    end
end

lrc=round((f_l+f_r)/2);
udc=round((f_u+f_d)/2);

if lrc<10
    lrc=10;
end
if udc<10
    udc=10;
end
if lrc>18
    lrc=18;
end
if udc>18
    udc=18;
end

post=temp(lrc-9:lrc+10,udc-9:udc+10);

Train_c(j,1)=mat2cell(post,20,20);

end
save('Train_c_20.mat','Train_c');
subplot(1,2,1)
imagesc(temp)
subplot(1,2,2)
imagesc(post)