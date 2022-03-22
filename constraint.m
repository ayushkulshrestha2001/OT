function output = constraint(X)
    X1=X(:,1)
    X2=X(:,2)
    cons1=round(X1+(2.*X2)-10)
    S1=find(cons1>0)
    X(S1,:)=[]
    X1=X(:,1)
    X2=X(:,2)
    cons2=round((X1+X2)-6)
    S2=find(cons2>0)
    X(S2,:)=[]
    X1=X(:,1)
    X2=X(:,2)
    cons3=round((X1-(2.*X2))-1)
    S3=find(cons1>0)
    X(S3,:)=[]
    output=X
end