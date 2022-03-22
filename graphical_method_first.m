clc;
clear all;
A=[1 2 ; 1 1 ; 1 -2]
B=[10 ; 6 ; 1]
c=[2 1]

y1=0:1:max(B)
x12=(B(1)-A(1,1)*y1)/A(1,2);
x22=(B(2)-A(2,1)*y1)/A(2,2);
x32=(B(3)-A(3,1)*y1)/A(3,2);
x12=max(0,x12);
x22=max(0,x22);
x32=max(0,x32);
plot(y1,x12,'r',y1,x22,'g',y1,x32,'b');
title('x1 vs x2')
xlabel('value of x1')
ylabel('value of x2')

%find corner points with axis
cx1=find(y1==0)
c1=find(x12==0)
Line1=[y1(:,[c1 cx1]) ; x12(:,[c1 cx1])]'

c2=find(x22==0)
Line2=[y1(:,[c2 cx1]) ; x22(:,[c2 cx1])]'

c3=find(x32==0)
Line3=[y1(:,[c3 cx1]) ; x32(:,[c3 cx1])]'

cornerpts=unique([ Line1 ; Line2 ; Line3],'rows')

%intersection points
pt=[0 ; 0];
for i=1:size(A,1)
    A1=A(i,:);
    B1=B(i,:);
    for j=i+1:size(A,1)
        A2=A(j,:);
        B2=B(j,:);
        P=[A1;A2]
        Q=[B1;B2]
        X=P\Q                      
        pt=[pt X]
    end
end
ptt=pt'

%all corner points
allpts=unique([ptt ; cornerpts],'rows')

%feasible region
PT=constraint(allpts)    %function call
P=unique(PT,'rows')

C=[2 1]

for i=1:size(P,1)
    fn(i,:)=(sum(P(i,:).*C))
end

ver_fns=[P fn]
maxima=max(fn)
indexopt=find(fn==maxima)
optsol=P(indexopt,:)
zopt=maxima

