t=5;
p=0.885185185;

n=15;

rr=log2(n)+p*log2(p)+(1-p)*log2((1-p)/(n-1));
itrs=(60/t)*rr;

t=5;
p=0.886296296;

n=4;

rr=log2(n)+p*log2(p)+(1-p)*log2((1-p)/(n-1));
itre=(60/t)*rr;

t=5;
p=0.76037037;

n=60;

rr=log2(n)+p*log2(p)+(1-p)*log2((1-p)/(n-1));
itrh=(60/t)*rr;

itr=[itrs,itre,itrh];
