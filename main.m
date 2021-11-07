clc;clear all;

%datasets 1
kmeans('datasets/1/', 7, 0.01);
dbscan('datasets/1/', 4, 6);

%datasets 2
kmeans('datasets/2/', 5, 0.01);
dbscan('datasets/2/', 10, 3);

%datasets 3
kmeans('datasets/3/', 5, 0.0275);
dbscan('datasets/3/', 8, 0.023);

%datasets iris ğ°Î²ÊôÖ²Îï
kmeans('datasets/iris/', 3, 0.01);
dbscan('datasets/iris/', 1, 0.078);

%datasets wine ÆÏÌÑ¾Æ
kmeans('datasets/wine/', 3, 0.01);
dbscan('datasets/wine/', 1, 0.13);

%datasets spiral ÂİĞıĞÍ
kmeans('datasets/spiral/', 3, 0.05);
dbscan('datasets/spiral/', 15, 3.5689);







