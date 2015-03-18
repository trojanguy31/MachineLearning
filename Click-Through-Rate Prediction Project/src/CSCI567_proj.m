%clear;
clc;
disp('Start');

load('NaiveBayesMatrix');
%#if('A' matrix exists) set flag
if(exist('A'))
    flag=1
    
else %#else load values into cell array
    flag=0;
    for i=3:24
        if (i~=12 && i~=13)
            str=['.\unique\column',num2str(i),'.txt'];
            temp=getUnique(str);
            Uniq{1,i}=temp;
        end
    end
end

%read csv file line by line
for FileNo = 6:10
    str=['.\newSplitTrain\train_data_out',num2str(FileNo),'.csv'];
    train = readFromCSV(str);
    
    %Calc the 3D
    if (~flag)
        A=zeros(24,8552,2);
        B=zeros(2,1);
    else
        A=C;
        B=D;
    end
    [row, col]=size(train);
    
    for i=1:row
        
        switch train{i,2}
            case 0
                for j=1:col
                    needle=num2str(train{i,j});
                    hay=Uniq{1,j};
                    if (j~=3)
                        index=find(ismember(hay,needle));
                    else
                        len=length(needle);
                        index=find(ismember(hay,needle(len-1:len)));
                    end
                    if(index)
                        A(j,index,1)=A(j,index,1)+1; %if label 0
                    end
                end
                B(1,1)=B(1,1)+1;             %label 0
                                
            case 1
                for j=1:col
                    needle=num2str(train{i,j});
                    hay=Uniq{1,j};
                    if (j~=3)
                        index=find(ismember(hay,needle));
                    else
                        len=length(needle);
                        index=find(ismember(hay,needle(len-1:len)));
                    end
                    if(index)
                        A(j,index,2)=A(j,index,2)+1; %if label 1
                    end
                end
                B(2,1)=B(2,1)+1;             %label 1
        end
    end
    C=A;
    D=B;
    flag=1;
    disp(B);
end


%Calc. probabilities
for FileNo=11:11
    str=['.\newSplitTest\test_data_out',num2str(FileNo),'.csv'];
    test = readFromCSV(str);
    [PofYgivenX,ClassLabel]=calcProb(test,A,B,Uniq);
end

%find Accuracy
[siz_r,siz_c]=size(test);
right=0;
wrong=0;
for i=1:siz_r
    TotalLabel=test{i,2}+ClassLabel(i);
    if(mod(TotalLabel,2))
        wrong=wrong+1;
    else
        right=right+1;
    end
end
Accuracy=right/(right+wrong)*100


disp('Stop');

clear i j str temp row col result len index FileNo prompt needle ans hay needle PofXgivenY PofY PofYgivenX TotalLabel testlabel right wrong siz_r siz_c flag train test FileNo

save('NaiveBayesMatrix');
