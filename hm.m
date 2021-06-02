%������Ů����ߵ�GMM
clear;
clc;
%��Ů����ȡ600�ˣ�Ů��ƽ�����165������ƽ�����175
A=textread('iris.txt');
male(1:400)=A(1:400);
female(1:200)=A(401:600);
h=[female male];

%������Ϻ��Ƶ�ʷֲ�ֱ��ͼ������150��ֱ��ͼ
figure(1)
hist(h,150);

%�������ɵ���Ů�Ե�Ƶ�ʷֲ�ֱ��ͼ
figure(2)
hist(female,100);
f=findobj(gca,'Type','patch');%�õ�ÿ�����߾���ļ���
set(f,'facecolor','g');%��������ͼ��ɫ
hold on
hist(male,100);%�������ɵ����Ե�Ƶ�ʷֲ�ֱ��ͼ
title('ȡ�������ķֲ�ͼ');
xlabel('���/cm');
ylabel('����/��');
hold off;

%GMM�Ĺ���
%Step 1.���ȸ��ݾ������ֱ����Ů���ľ�ֵ�������Ȩֵ���г�ʼ��
mu1_first=170;sigmal_first=10;w1_first=0.8;%������
mu2_first=160;sigma2_first=10;w2_first=0.2;%������ѧУ��ԺУΪ��

iteration=200;%���õ�������
outcome=zeros(iteration,6);%����һ���������洢ÿ�εĵ������
outcome(1,1)=mu1_first;outcome(1,4)=mu2_first;
outcome(1,2)=sigmal_first;outcome(1,5)=sigma2_first;
outcome(1,3)=w1_first;outcome(1,6)=w2_first;%����һ�д洢��ʼֵ

%��ʼ����
for i=1:iteration-1
    [mu1_last,sigma1_last,w1_last,mu2_last,sigma2_last,w2_last]=em(male,female,outcome(i,1),outcome(i,2),outcome(i,3),outcome(i,4),outcome(i,5),outcome(i,6));
    %�����������������em,����outcome�е���ֵ
    outcome(i+1,1)=mu1_last;outcome(i+1,2)=sigma1_last;outcome(i+1,3)=w1_last;
    outcome(i+1,4)=mu2_last;outcome(i+1,5)=sigma2_last;outcome(i+1,6)=w2_last;
end
% 
%  outcome ;% ���ÿ�ε������

%������Ů����Ȩ�ص�����ʷ
figure(3);
x1=1:0.5:iteration;
y1=interp1(outcome(:,3),x1,'spline');
%interp1�÷��ο�https://www.cnblogs.com/jiahuiyu/articles/4978005.html   
plot(y1,'linewidth',1.5);%����������Ȩ�ص�����ʷ
hold on;
grid on;
y2=interp1(outcome(:,6),x1,'spline');
plot(y2,'r','linewidth',1.5);%����Ů��Ȩ�ص�����ʷ
legend('������������������仯','Ů����������������仯','location','northeast');%���������ã�����ʶ�������ͼ�����Ͻ�
% title('Changes in weights of boys and girls with the number of iterations');
xlabel('Number of iterations');
ylabel('Weights');
axis([1 iteration 0 1]);

%���������ս��ȡ��
mu1_last=outcome(iteration,1)
sigma1_last=outcome(iteration,2)
w1_last=outcome(iteration,3)
mu2_last=outcome(iteration,4)
sigma2_last=outcome(iteration,5)
w2_last=outcome(iteration,6)

figure(4);
x2=1:0.5:iteration;
y1=interp1(outcome(:,1),x2,'spline');
%interp1�÷��ο�https://www.cnblogs.com/jiahuiyu/articles/4978005.html   
plot(y1,'linewidth',1.5);%����������Ȩ�ص�����ʷ
hold on;
grid on;
y2=interp1(outcome(:,4),x2,'spline');
plot(y2,'r','linewidth',1.5);%����Ů��Ȩ�ص�����ʷ
legend('�����������������仯','Ů���������������仯','location','northeast');%���������ã�����ʶ�������ͼ�����Ͻ�
% title('Changes in weights of boys and girls with the number of iterations');
xlabel('Number of iterations');
ylabel('���');

figure(5);
x3=1:0.5:iteration;
y1=interp1(outcome(:,2).*outcome(:,2),x3,'spline');
%interp1�÷��ο�https://www.cnblogs.com/jiahuiyu/articles/4978005.html   
plot(y1,'linewidth',1.5);%����������Ȩ�ص�����ʷ
hold on;
grid on;
y2=interp1(outcome(:,5).*outcome(:,5),x3,'spline');
plot(y2,'r','linewidth',1.5);%����Ů��Ȩ�ص�����ʷ
legend('������������������仯','Ů����������������仯','location','northeast');%���������ã�����ʶ�������ͼ�����Ͻ�
% title('Changes in weights of boys and girls with the number of iterations');
xlabel('Number of iterations');
ylabel('����');