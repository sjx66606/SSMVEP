function mydata=myloadcnt(filename,nchannels)
%Input：文件名
%Output:通道名，脑电数据
% nchannels=9;
fid = fopen(filename,'r','l');
% fseek(fid,656,'cof');
fseek(fid,886,'cof');
eventtablepos=fread(fid,1,'ulong');
fseek(fid,10,'cof');

fseek(fid,75*nchannels,'cof');

begdata=ftell(fid);
enddata=eventtablepos;

nums=floor((enddata-begdata)/nchannels/4);
dataformat='int32';
dat=fread(fid,[nchannels nums],dataformat);

sen=34.3751;
for i=1:nchannels
    cal=0.01;
    mf=sen*(cal/204.8);
    mydata(i,:)=dat(i,:).*mf;
end
for i=1:nchannels
      cal=1;
    mf=sen*(cal/204.8);
    mydata(i,:)=dat(i,:).*mf;
end

end