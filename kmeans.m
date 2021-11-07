function [u, re] = kmeans(dataPath, N, eps)
% Aimed at clustering the data with K-Means
% -------------------------------------------------------------------------
% Input: 
% dataPath - the file path of data 数据文件路径
% N - number of objects in a neighborhood of an object  对象邻域中的对象数(分成N个簇)
% eps - neighborhood radius, if not known avoid this parameter or put []
%       邻域半径，如果未知，请避免使用此参数或放置[]
% -------------------------------------------------------------------------
% Output: 
% u - the center of each cluster    每个簇的中心
% re - the data with labels     用标签重新标记数据

datafile=[dataPath,'/points.mat'];
load(datafile);
data = points;

tic;
[m, n] = size(data);   %m是数据个数，n是数据维数
ma = zeros(n);        %每一维最大的数
mi = zeros(n);        %每一维最小的数
u = zeros(N,n);       %随机初始化，最终迭代到每一类的中心位置
for i = 1 : n
    ma(i) = max(data(:,i));    %每一维最大的数
    mi(i) = min(data(:,i));    %每一维最小的数
    for j = 1 : N
        u(j,i) = ma(i) + (mi(i) - ma(i)) * rand();  %随机初始化，不过还是在每一维[min max]中初始化好些
    end
end

while 1
    pre_u = u;            %上一次求得的中心位置
    for i = 1 : N
        tmp{i} = [];      % 公式一中的x(i)-uj,为公式一实现做准备
        for j = 1 : m
            tmp{i} = [tmp{i}; data(j,:) - u(i,:)];% 计算每个粒子距各簇质心的距离
        end
    end
    
    quan = zeros(m,N);
    for i = 1 : m        %公式一的实现
        c = [];
        for j = 1 : N
            c = [c norm(tmp{j}(i,:))];
        end
        [junk, index] = min(c);
        quan(i, index) = norm(tmp{index}(i,:));
    end
    
    for i = 1 : N            %公式二的实现
        for j = 1 : n
            u(i,j) = sum(quan(:,i) .* data(:,j)) / sum(quan(:,i));
        end
    end
    
    if norm(pre_u-u) < eps  %不断迭代直到位置不再变化
        break;
    end
end

re = [];
for i = 1 : m
    tmp = [];
    for j = 1 : N
        tmp = [tmp norm(data(i,:) - u(j,:))];
    end
    [junk, index]=min(tmp);
    re = [re;data(i,:) index];
end

%draw shapes
figure;
hold on;
title('k-means spiral')
drawshapes(data, re(:,3),m);% re(:,3)代表粒子所在的簇的编号
toc;
end

