clc;
clear all;
tempA=[2 1; 2 3; 3 1]
B=[18; 42; 24]
tempC=[3 2]
s=eye(size(tempA,1))
A=[tempA s B]
t=zeros(1,size(A,2))
t(1:size(tempA,2))=tempC      % now t is cost vector

%%phase2
bv=size(tempA,2)+1:size(A,2)-1
ZjCj=t(bv)*A-t

%loop starts
RUN=true;
while RUN
    Zc=ZjCj(1:size(A,2)-1)
    if any(Zc<0)
        [minvalZjCj,minindZjCj]=min(Zc)
        pivot_col=A(:,minindZjCj)
    if all(pivot_col<=0)
        print('LPP is unbounded')
    else
        for i=1:size(pivot_col,1)
            if pivot_col(i)>0
                ratio(i)=A(i,size(A,2))./pivot_col(i)
            else
                ratio(i)=inf
            end
        end
        [minratio,ratio_ind]=min(ratio)
    end
    bv(ratio_ind)=minindZjCj
    pivot_val=A(ratio_ind,minindZjCj)
    
    A(ratio_ind,:)=A(ratio_ind,:)./pivot_val
    
    for j=1:size(A,1)
        if j~=ratio_ind
            A(j,:)=A(j,:)-(pivot_col(j).*A(ratio_ind,:))
            ZjCj=t(bv)*A-t
        end
    end
    else
      RUN=false;
      disp('Optimal Solution obtained');
    end
end

