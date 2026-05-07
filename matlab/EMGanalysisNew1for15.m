 function  [x,Index,Xiemg,c1]=EMGanalysisNew1(x,AmpH,AmpL)
% function  [x,Index,Xiemg,c1,locs1,locs2,len]=EMGanalysisNew(x,AmpH,AmpL,minDir,window,fs)
%  function  [x,Index,Xiemg,c1,locs1,locs2,len]=EMGanalysisNew(x,AmpH,AmpL,minDir,window,fs)
%V1改进版
%Thre1:幅值阈值，>Thre1,Xiemg=1;
%Thre2：比Thre1略低的一个幅值阈值
%Thre3:时间阈值，if (T2-T1)>Thre2,EMGcommand=EMGcommand+1;

%minDir:如果两次之间时间差<=minDir,视作一次

if nargin<6,fs=1000;end
if nargin<5,window=20;end
if nargin<4,minDir=1;end
if nargin<3,AmpL=0.25;end
if nargin<2,AmpH=0.4;end
if nargin<1
    error('请输入待处理的肌电信号');
end
L1=length(x);t=(1:L1)/fs;
x=(x-mean(x))/std(x);
% figure(1),subplot(231),plot(x);title('滤波前x');ylim([-5 5]);
x=mybp(x,90,180,80,190,1,20,fs);%new
%% Segment
m=floor(L1/window)-1;
for i=1:m
    Xepo(i,:)=x((i-1)*window+1:i*window);
    Xiemg(i)=sum(abs(Xepo(i,:)))/length(Xepo(i,:));

%     Xrms(i)=sqrt(sum(Xepo(i,:).^2)/length(Xepo(i,:)));
end
% subplot(234),plot(x);title('滤波后x');ylim([-5 5]);subplot(232),plot(Xiemg),title('滤波前Xiemg');
Xiemg=smooth(Xiemg,10);
Xiemg=smooth(Xiemg,5);

len=0;
% #---0303以前的版本，if Xiemg>Thre1,c1=1;else c1=0;-----
% #---0303改进：上述的二元划分对滤波后Xiemg小的抖动太敏感，会导致部分判别结果比正确结果大1；
% #---0303改进：因此，增加一个下限阈值Thre2;
for i=1:m
     c1(i)=0;  
     if (Xiemg(i)>AmpH)||((AmpL<Xiemg(i))&&(Xiemg(i)<AmpH)&&(i>1)&&(c1(i-1)==1))
        c1(i)=1;
     end

end

for i=1:m-1
    diff(i)=c1(i+1)-c1(i);
end

[locs1]=find(diff==1);
[locs2]=find(diff==(-1));                                       
LL1=length(locs1);LL2=length(locs2);
o=1;
%% 对于locs1和locs2的预处理：补齐
if  LL1<LL2
    if LL1==0
        locs1(1)=0;
    else
        for i=1:LL1
            locs1n(i+1)=locs1(i);
        end
        locs1n(1)=0;
        locs1=locs1n;
    end
elseif LL1>LL2
    locs2(LL1)=floor(length(x)/window);
elseif (LL1==LL2)&&(LL1>0)&&(locs2(1)<locs1(1))
        for i=1:LL1
            locs1n(i+1)=locs1(i);
        end
        locs1n(1)=0;
        locs1=locs1n;
        locs2(LL2+1)=floor(length(x)/window);
end

LL1n=length(locs1);LL2n=length(locs2);
%% 命令识别
 Ncom1=0;Ncom3=0;
if (LL1n==0)&&(LL2n==0)
    Ncom1=0;Ncom3=0;
else
   Ncom1=0;Ncom3=0;
    if LL1n==1
        len(1)=locs2(1)-locs1(1);
        count=0;
    else
      for i=1:LL1n
          len(i)=locs2(i)-locs1(i);
      end
      count=0;
      for i=1:LL1n-1
          dir(i)=locs1(i+1)-locs2(i);
          if dir(i)<=minDir
              len(i-count)=len(i-count)+len(i-count+1);
              len(i-count+1)=[];
              count=count+1;
          end    
      end 
    end
   
    for i=1:length(len)
          if (len(i)*window>=0.2*fs) &&(len(i)*window<=1*fs)
              Ncom1=Ncom1+1;
          elseif (len(i)*window>=1.2*fs)
              Ncom3=Ncom3+1;
          end
    end
end

if Ncom3~=0
    Index=3;
elseif Ncom1>2
    Index=0;
else Index=Ncom1;
end

%Index=EMGcommand;              
%----
% % if EMGcommand>2
% %     Index=0;
% %  else Index=EMGcommand;
% %  end

% subplot(235),plot(Xiemg),title('滤波后Xiemg');hold on;line([1:length(Xiemg)],AmpH*ones(1,length(Xiemg)),'linestyle','-.','linewidth',1,'color',[1,0,0]);
% line([1:length(Xiemg)],AmpL*ones(1,length(Xiemg)),'linestyle','-.','color',[0,1,0]);hold off;
% ylim([0 0.3]);
% subplot(233),plot(c1),title('c1');subplot(236),plot(Index,'*');title('result');ylim([0 3]);  
 a=1;
 end