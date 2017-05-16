%Initialize orginal vectors with random values
vectorA=round(rand(1,50))*20;
vectorB=round(rand(1,50))*20;

%Number of permutations (=surrogate vectors) and number of subsets to be
%replaced per permutation
numberOfPermutations=100;
elementsInSubset=12;

%Calling the function that does the permutations
[surrogateVectorsA surrogateVectorsB meanDifferences]=swapVectorValuePermutations(vectorA, vectorB, numberOfPermutations, elementsInSubset); 

%Visualize the results by plotting a histogram
figure
histogram(meanDifferences);
hold on
line([mean(vectorA-vectorB) mean(vectorA-vectorB)],[0 50], 'Color', 'red', 'LineWidth',6)
title('Histogram of the mean difference between surrogate vectors')
hold off

function [surrogateVectorsA surrogateVectorsB meanDifferences]=swapVectorValuePermutations(vectorA, vectorB, numberOfPermutations, elementsInSubset) 
    %initialize vector of surrogate vectors (=matrices of surrogate vectors)
    surrogateVectorsA=zeros(numberOfPermutations,length(vectorA));
    surrogateVectorsB=zeros(numberOfPermutations,length(vectorB));
    
    %Initialize the vector of mean difference values
    meanDifferences=zeros(numberOfPermutations,1);
    
    %Run through all permutations
    for permutationIndex=1:numberOfPermutations
       
        %Put the orginal vectors as a starting point for the surrogates
        surrogateVectorsA(permutationIndex,:)=vectorA;
        surrogateVectorsB(permutationIndex,:)=vectorB;

        %Loop through each swap of elements
        for swapIndex=1:elementsInSubset
            %Select the index of the elements to be swapped randomly
            elementAIndex=round(rand(1,1)*length(vectorA));
            elementBIndex=round(rand(1,1)*length(vectorA));
            
            %Make sure that element index is not zero
            while (elementAIndex==0 || elementBIndex==0)
                elementAIndex=round(rand(1,1)*length(vectorA));
                elementBIndex=round(rand(1,1)*length(vectorA));
            end
            
            %Temporal variables to save the element values
            elementA=vectorA(elementAIndex);
            elementB=vectorB(elementBIndex);
            
            %Swap the orginal vector values in the surrogates
            surrogateVectorsA(permutationIndex,elementAIndex)=elementB;
            surrogateVectorsB(permutationIndex,elementBIndex)=elementA;
            
            %Calculate the mean difference between the surrogates
            meanDifferences(permutationIndex)=mean(surrogateVectorsA(permutationIndex,:)-surrogateVectorsB(permutationIndex,:));
        end
    end
end