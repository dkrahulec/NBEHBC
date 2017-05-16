%% Function A

% Number of permutations
numOfPermutations=70;
% Input vector
inputVector=round(rand(1,50)*10);
% Number of flips
numOfFlips=10; 

permutationVectors = signFlipPermutation(inputVector, numOfPermutations, numOfFlips); %input parameters for the function

% Visualisation
figure()
histogram(mean(permutationVectors,1))
title('Distribution of surrogate data')
hold on
line([mean(inputVector) mean(inputVector)], [0 20], 'Color','red');
hold off
%p_value=1-()

% Initialize an empty matrix for permutation vectors
function permutationVectors = signFlipPermutation(inputVector, numOfPermutations, numOfFlips)
permutationVectors = zeros(numOfPermutations, length(inputVector)); 
for permutationIndex = 1:numOfPermutations % run through all permutations
    permutationVectors(permutationIndex, :) = inputVector; % fill the matrix with indexed permutation vectors 
    flippedVectorElementIndeX = zeros(1,numOfFlips); % initialize indexing for flipping 
    for flipIndex = 1:numOfFlips % run through all flips
        flippedVectorElementIndeX(flipIndex) = round(rand(1,1)*length(inputVector));
        if flipIndex > 1 % Checking that flip index does not go equal zero
            while any(flippedVectorElementIndeX(flipIndex) == flippedVectorElementIndeX(1:flipIndex - 1)) || flippedVectorElementIndeX(flipIndex) < 0
                flippedVectorElementIndeX(flipIndex) = round(rand(1,1)*length(inputVector));
            end
        end
        permutationVectors(permutationIndex, flippedVectorElementIndeX(flipIndex))= permutationVectors(permutationIndex, flippedVectorElementIndeX(flipIndex)) * -1;
        
       
    end
end
end




