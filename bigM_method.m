clc;
clear all;
format rat

variables = {'x1','x2','s2','s3','a1','a2','Sol'}
M=1000;
Cost= [-2 -1 0 0 -M -M 0]
A=[3 1 0 0 1 0 3; 4 3 -1 0 0 1 6; 1 2 0 1 0 0 3]
s=eye(size(A,1))

%find starting basic variables
bv=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            bv=[bv i]
        end   
    end
end

ZjCj=Cost(bv)*A-Cost         

Zcj=[ZjCj ; A]
simpTable=array2table(Zcj);
simpTable.Properties.VariableNames(1:size(Zcj,2))=variables

%loop starts
RUN=true;
while RUN
    Zc=ZjCj(1:size(A,2)-1);
    if any(Zc<0)
       disp('Current BFS is not optimal ');
       disp('******* The next iteration results ******* ');
       disp(' Basic Variables are ');
       disp(variables(bv))
    
       %find entering variable
       
       [minvalZjCj,minindZjCj]=min(Zc)
       fprintf('Entering variable is')
       disp(variables(minindZjCj))
        
        %find leaving variable
    
       sol=A(:,end)
       pivot_column=A(:,minindZjCj)
       if all(pivot_column<=0)
          print('LPP is Unbounded');
       else
          for i=1:size(pivot_column,1)
             if pivot_column(i)>0
                ratio(i)=sol(i)./pivot_column(i)
             else
                ratio(i)=inf
             end    
          end
       end    
       [minratio,ratio_index]=min(ratio)      %value and index of minimum ratio
       fprintf('Leaving variable is')
       disp(variables(bv(ratio_index)))
       
       bv(ratio_index)=minindZjCj             %changing basic variables
       pivot_value=A(ratio_index,minindZjCj)  %pivot_key
    
       %Update the table
       A(ratio_index,:)=A(ratio_index,:)./pivot_value
       for j=1:size(A,1)
          if j~=ratio_index
             A(j,:) = A(j,:) - ( A(j,minindZjCj).*A(ratio_index,:) )
          end  
       end    
       ZjCj=ZjCj - (ZjCj(minindZjCj).*A(ratio_index,:) )
    
       Zcj=[ZjCj ; A]
       simpTable=array2table(Zcj);
       simpTable.Properties.VariableNames(1:size(Zcj,2))=variables
    else
       RUN=false;
       disp('Optimal sol obtained');
       Zcj=[ZjCj; A];
       Table=array2table(Zcj);
       Table.Properties.VariableNames(1:size(Zcj,2))=variables
       fprintf('The final BFS  is : ')
       final=zeros(1,size(A,2));
       final(bv)=A(:,end);
       final(end)=sum(final.*Cost);
       BFS=array2table(final);
       BFS.Properties.VariableNames(1:size(final,2))=variables
    end
end

  
