[num,txt,raw]=xlsread('Spots in tracks statistics 2.xlsx');   %读取文件
[m_TRACK_ID,n_TRACK_ID]=find(strcmp(txt,'TRACK_ID'));   %查找存放字符串胞元数组中TRACK_ID所在位置
[m_MEAN_INTENSITY,n_MEAN_INTENSITY]=find(strcmp(txt,'MEAN_INTENSITY'));%查找存放字符串胞元数组中MEAN_INTENSITY所在位置
X=num(:,n_TRACK_ID);   %利用TRACK_ID的列数将对应存放数值的数组中的TRACK_ID值存入X数组
Y=num(:,n_MEAN_INTENSITY);   %利用MEAN_INTENSITY的列数将对应存放数值的数组中的MEAN_INTENSITY值存入Y数组
subplot(2,1,1),scatter(X,Y)   %绘制MEAN_INTENSITY关于TRACK_ID的散点图
title('原图像'),xlabel('TRACK ID'),ylabel('MEAN INTENSITY')
%利用极差筛选数据
X_max=max(X);   %确定TRACK_ID的上限
for i=0:X_max
    id=find(X==i);
    comp=Y(id);   %记录每条轨迹对应的一系列MEAN_INTENSITY，存入比较数组comp
    if max(comp)-min(comp)<5
        Y(id)=NaN;  %若此轨迹MEAN_INTENSITY极差>5，将此轨迹MEAN_INTENSITY记为NaN，不出现在散点图中
    end
end
subplot(2,1,2),scatter(X,Y)   %作筛选后的MEAN_INTENSITY关于TRACK_ID的散点图
title('新图像'),xlabel('TRACK ID'),ylabel('MEAN INTENSITY')