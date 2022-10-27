data=readtable('Spots in tracks statistics1铜绿fps29.16.csv');  %读取数据
t=data(:,{'TRACK_ID','POSITION_X','POSITION_Y'});
fps=1/29.16;  %帧间隔
TrackList=unique(t.TRACK_ID);  %统计TRACK_ID数值
TrackListTotal=length(TrackList);  %统计TRACK_ID总数
cell={};

for i=1:TrackListTotal
    k=t.TRACK_ID==TrackList(i);
    SingleTrack=t(k,:);  %存储单轨迹对应数据
    SingleTrackLength=length(SingleTrack.TRACK_ID);  %单轨迹帧数
    SingleTrack.TRACKLENGTH(1)=SingleTrackLength;  %单轨迹帧数存储
    for j=1:SingleTrackLength-1  %单轨迹相邻两点间的距离edge求算及存储
        SingleTrack.EDGE(j)=norm([SingleTrack.POSITION_X(j),SingleTrack.POSITION_Y(j)]-[SingleTrack.POSITION_X(j+1),SingleTrack.POSITION_Y(j+1)]); 
    end
    SingleTrack.SUMEDGE(1)=sum(SingleTrack.EDGE);  %单轨迹总长度
    SingleTrack.AVERAGE_v(1)=sum(SingleTrack.EDGE)/(fps*SingleTrackLength);  %单轨迹平均速度求算及存储
    cell{end+1}=SingleTrack;  %单轨迹相关数据全部存入cell
end
%轨迹按照时间长度、距离长度排序
for i=1:TrackListTotal
    Length(i)=cell{i}.TRACKLENGTH(1);
    SumEdge(i)=cell{i}.SUMEDGE(1);
    Average_v(i)=cell{i}.AVERAGE_v(1);
end
[~,ind_length]=sort(Length,'descend');
[~,ind_sumedge]=sort(SumEdge,'descend');
sorted_length=cell(ind_length);
sorted_sumedge=cell(ind_sumedge);
%筛选出时间长度、距离长度最长的10组轨迹
for i=1:10
    Average_v_length10(i)=sorted_length{i}.AVERAGE_v(1);
    Average_v_sumedge10(i)=sorted_sumedge{i}.AVERAGE_v(1);
end
%所有轨迹平均速度箱型图
subplot(3,1,1)
boxplot(Average_v)
title('Average Velocity')
%时间长度最长的10条轨迹平均速度箱型图
subplot(3,1,2)
boxplot(Average_v_length10)
title('Average Velocity of top10 length')
%距离长度最长的10条轨迹平均速度箱型图
subplot(3,1,3)
boxplot(Average_v_sumedge10)
title('Average Velocity of top10 sumedge')