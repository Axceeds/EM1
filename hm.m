%绘制男女生身高的GMM
clear;
clc;
%男女生共取600人，女生平均身高165，男声平均身高175
A=textread('iris.txt');
male(1:400)=A(1:400);
female(1:200)=A(401:600);
h=[female male];

%画出混合后的频率分布直方图，产生150个直方图
figure(1)
hist(h,150);

%画出生成的男女性的频率分布直方图
figure(2)
hist(female,100);
f=findobj(gca,'Type','patch');%得到每条曲线句柄的集合
set(f,'facecolor','g');%设置柱形图颜色
hold on
hist(male,100);%画出生成的男性的频率分布直方图
title('取的样本的分布图');
xlabel('身高/cm');
ylabel('人数/个');
hold off;

%GMM的构造
%Step 1.首先根据经验来分别对男女生的均值、方差和权值进行初始化
mu1_first=170;sigmal_first=10;w1_first=0.8;%男生的
mu2_first=160;sigma2_first=10;w2_first=0.2;%以我们学校理工院校为例

iteration=200;%设置迭代次数
outcome=zeros(iteration,6);%定义一个数组来存储每次的迭代结果
outcome(1,1)=mu1_first;outcome(1,4)=mu2_first;
outcome(1,2)=sigmal_first;outcome(1,5)=sigma2_first;
outcome(1,3)=w1_first;outcome(1,6)=w2_first;%将第一列存储初始值

%开始迭代
for i=1:iteration-1
    [mu1_last,sigma1_last,w1_last,mu2_last,sigma2_last,w2_last]=em(male,female,outcome(i,1),outcome(i,2),outcome(i,3),outcome(i,4),outcome(i,5),outcome(i,6));
    %将迭代结果依次送入em,更新outcome中的数值
    outcome(i+1,1)=mu1_last;outcome(i+1,2)=sigma1_last;outcome(i+1,3)=w1_last;
    outcome(i+1,4)=mu2_last;outcome(i+1,5)=sigma2_last;outcome(i+1,6)=w2_last;
end
% 
%  outcome ;% 输出每次迭代结果

%画出男女生的权重迭代历史
figure(3);
x1=1:0.5:iteration;
y1=interp1(outcome(:,3),x1,'spline');
%interp1用法参考https://www.cnblogs.com/jiahuiyu/articles/4978005.html   
plot(y1,'linewidth',1.5);%画出男生的权重迭代历史
hold on;
grid on;
y2=interp1(outcome(:,6),x1,'spline');
plot(y2,'r','linewidth',1.5);%画出女生权重迭代历史
legend('男生比重随迭代次数变化','女生比重随迭代次数变化','location','northeast');%坐标轴设置，将标识框放置在图的左上角
% title('Changes in weights of boys and girls with the number of iterations');
xlabel('Number of iterations');
ylabel('Weights');
axis([1 iteration 0 1]);

%迭代的最终结果取出
mu1_last=outcome(iteration,1)
sigma1_last=outcome(iteration,2)
w1_last=outcome(iteration,3)
mu2_last=outcome(iteration,4)
sigma2_last=outcome(iteration,5)
w2_last=outcome(iteration,6)

figure(4);
x2=1:0.5:iteration;
y1=interp1(outcome(:,1),x2,'spline');
%interp1用法参考https://www.cnblogs.com/jiahuiyu/articles/4978005.html   
plot(y1,'linewidth',1.5);%画出男生的权重迭代历史
hold on;
grid on;
y2=interp1(outcome(:,4),x2,'spline');
plot(y2,'r','linewidth',1.5);%画出女生权重迭代历史
legend('男生身高随迭代次数变化','女生身高随迭代次数变化','location','northeast');%坐标轴设置，将标识框放置在图的左上角
% title('Changes in weights of boys and girls with the number of iterations');
xlabel('Number of iterations');
ylabel('身高');

figure(5);
x3=1:0.5:iteration;
y1=interp1(outcome(:,2).*outcome(:,2),x3,'spline');
%interp1用法参考https://www.cnblogs.com/jiahuiyu/articles/4978005.html   
plot(y1,'linewidth',1.5);%画出男生的权重迭代历史
hold on;
grid on;
y2=interp1(outcome(:,5).*outcome(:,5),x3,'spline');
plot(y2,'r','linewidth',1.5);%画出女生权重迭代历史
legend('男生方差随迭代次数变化','女生方差随迭代次数变化','location','northeast');%坐标轴设置，将标识框放置在图的左上角
% title('Changes in weights of boys and girls with the number of iterations');
xlabel('Number of iterations');
ylabel('方差');