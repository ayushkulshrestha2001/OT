clc;
clear all;
format rat

variables={'x1','x2','x3','s2','s3','a1','a2','Sol'};
optimal_variables={'x1','x2','x3','s2','s3','Sol'};
A=[3 -1 -1 -1 0 1 0 3; 1 -1 1 0 -1 0 1 2];
original_cost=[-7.5 3 0 0 0 -1 -1 0]
s=eye(size(A,1))
bv=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            bv=[bv i]
        end   
    end
end

fprintf('**********   PHASE 1 STARTS   **********\n')
Cost=[0 0 0 0 0 -1 -1 0]
startbv=find(Cost<0)
[A,newbv]=general_simplex(A,bv,Cost,variables)               %fnc calling


fprintf('**********   PHASE 2 STARTS   **********\n')
A(:,startbv)=[]
original_cost(:,startbv)=[]
[A,OptBFS]=general_simplex(A,newbv,original_cost,optimal_variables)    %fnc calling

fprintf('The final BFS  is : ')
final=zeros(1,size(A,2));
final(OptBFS)=A(:,end)
final(end)=sum(final.*original_cost)     
BFS=array2table(final);
BFS.Properties.VariableNames(1:size(final,2))=optimal_variables
       
       