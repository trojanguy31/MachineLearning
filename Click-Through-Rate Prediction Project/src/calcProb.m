function [ PofYgivenX,ClassLabel ] = calcProb( test,A,B,Uniq )
%CALCPROB
% A general function to calculate the probabilities for Naive Bayes!

[row,col]=size(test)
PofY=zeros(2,1);
%Calc P(Y)
for i=1:2
    PofY(i)=B(i)/sum(B);
end


%Calc P(X|Y)*P(Y)
for i=1:row %for every row in test data
    PofXgivenY=PofY;
	%PofX=1;
    for j=2:col %for every feature
        %find the index
        needle=num2str(test{i,j});
        hay=Uniq{1,j+1};
        if (j~=2)
            k=find(ismember(hay,needle));
        else
            len=length(needle);
            k=find(ismember(hay,needle(len-1:len)));
        end
        
        
        %find probability of that index
        if(k)
			%Calc and multiply P(X)
			%PofX=PofX*( ( A(j,k,1)/(sum(A(j,:,1))) ) + ( A(j,k,2) / sum(A(j,:,2))) );
            %PofX=PofX*( ( A(j,k,1)/(sum(A(j,:,1))) ) + ( A(j,k,2) / sum(A(j,:,2))) );

            %Calc.for both label 0 and 1
            for label=1:2
                if (A(j,k,label)~=0)
                    PofXgivenY(label)=PofXgivenY(label)*(A(j,k,label)/B(label));
                else
                    PofXgivenY(label)=PofXgivenY(label)*0.01;
                end
            end
        end
        
    end
    
    %Calc P(Y|X) and retain max of them
    if(PofXgivenY(1)>PofXgivenY(2))
        PofYgivenX(i)=PofXgivenY(1)/(PofXgivenY(1)+PofXgivenY(2));
        ClassLabel(i)=0;
    else
        PofYgivenX(i)=PofXgivenY(2)/(PofXgivenY(1)+PofXgivenY(2));        
        ClassLabel(i)=1;
    end
    
    
end



end

