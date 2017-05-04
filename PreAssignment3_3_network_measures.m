clc; clear all; close all

% Authors: Daniel Krahulec & Timo Nurmi
% Date: May 4, 2017

%% 1) Selected network

%Meta-analysis network of human whole-brain functional coactivations
%with comparable resting-state fMRI network and node coordinates.
%Coactivation_matrix.mat; GroupAverage_rsfMRI_matrix.mat (WU networks).
%638 nodes, 18625 links
%Reference: Crossley et al. (2013).
%Contributor: NC.

load Coactivation_matrix.mat
load GroupAverage_rsfMRI_matrix.mat

%% 2) Degree and Similarity

% Degree
% The number of links connected to the node.
% Output: node degree
Deg_CM = degrees_und(Coactivation_matrix);
Deg_GA = degrees_und(GroupAverage_rsfMRI);

figure(1)
subplot(231)
stem(Deg_CM);title('Stem plot of node degrees (CM)')
subplot(232)
hist(Deg_CM);title('Histogram of node degrees (CM)')
subplot(233)
boxplot(Deg_CM);title('Box plot of node degrees (CM)')
subplot(234)
stem(Deg_GA);title('Stem plot of node degrees (GA)')
subplot(235)
hist(Deg_GA);title('Histogram of node degrees (GA)')
subplot(236)
boxplot(Deg_GA);title('Box plot of node degrees (GA)')

% Strength
% The sum of weights of links connected to the node
% Output: node strength

Str_CM = strengths_und(Coactivation_matrix);
Str_GA = strengths_und(GroupAverage_rsfMRI);

figure(2)
subplot(231)
stem(Str_CM);title('Stem plot of node strengths (CM)')
subplot(232)
hist(Str_CM);title('Histogram of node strengths (CM)')
subplot(233)
boxplot(Str_CM);title('Box plot of node strengths (CM)')
subplot(234)
stem(Str_GA);title('Stem plot of node strengths (GA)')
subplot(235)
hist(Str_GA);title('Histogram of node strengths (GA)')
subplot(236)
boxplot(Str_GA);title('Box plot of node strengths (GA)')

%% 3) Density and Rentian Scaling

% Density
% The fraction of present connections to possible connections.
%   Output:     kden,   density
%               N,      number of vertices
%               K,      number of edges

[kden_CM, N_CM, K_CM] = density_und(Coactivation_matrix);
[kden_GA, N_GA, K_GA] = density_und(GroupAverage_rsfMRI);

%% 4) Clustering and Community Structure

% Clustering coefficient
%   The weighted clustering coefficient is the average "intensity"
%   (geometric mean) of all triangles associated with each node
%   Output: clustering coefficient vector

ClustCoeff_CM = clustering_coef_wu(Coactivation_matrix);
ClustCoeff_GA = clustering_coef_wu(GroupAverage_rsfMRI);

figure(3)
subplot(231)
stem(ClustCoeff_CM);title('Stem plot of clustering coefficients (CM)')
subplot(232)
hist(ClustCoeff_CM);title('Histogram of clustering coefficients (CM)')
subplot(233)
boxplot(ClustCoeff_CM);title('Box plot of clustering coefficients (CM)')
subplot(234)
stem(ClustCoeff_GA);title('Stem plot of clustering coefficients (GA)')
subplot(235)
hist(ClustCoeff_GA);title('Histogram of clustering coefficients (GA)')
subplot(236)
boxplot(ClustCoeff_GA);title('Box plot of clustering coefficients (GA)')

% Transitivity
% The transitivity is the ratio of triangles to triplets
% in the network and is an alternative to the clustering coefficient.
%      Output:  transitivity scalar

Trans_CM = transitivity_wu(Coactivation_matrix);
Trans_GA = transitivity_wu(GroupAverage_rsfMRI);

% Local efficiency
%   Eglob = efficiency_wei(W);
%   Eloc = efficiency_wei(W,2);
%
%   The global efficiency is the average of inverse shortest path length,
%   and is inversely related to the characteristic path length.
%
%   The local efficiency is the global efficiency computed on the
%   neighborhood of the node, and is related to the clustering coefficient.
%   Output:     Eglob,
%                   global efficiency (scalar)
%               Eloc,
%                   local efficiency (vector)

EGlob_CM = efficiency_wei(Coactivation_matrix);
EGlob_GA = efficiency_wei(GroupAverage_rsfMRI);

ELoc_CM = efficiency_wei(Coactivation_matrix,2);
ELoc_GA = efficiency_wei(GroupAverage_rsfMRI,2);

figure(4)
subplot(231)
stem(ELoc_CM);title('Stem plot of loc. eff. (CM)')
subplot(232)
hist(ELoc_CM);title('Histogram of loc. eff. (CM)')
subplot(233)
boxplot(ELoc_CM);title('Box plot of loc. eff. (CM)')
subplot(234)
stem(ELoc_GA);title('Stem plot of loc. eff. (GA)')
subplot(235)
hist(ELoc_GA);title('Histogram of loc. eff. (GA)')
subplot(236)
boxplot(ELoc_GA);title('Box plot of loc. eff. (GA)')


% Community louvain
% The optimal community structure is a subdivision
% of the network into nonoverlapping groups of nodes
% in a way that maximizes the number of within-group
% edges, and minimizes the number of between-group edges.
%   Output: nodal community-affiliation matrix
%           binary matrix of size CxN [communities x nodes]

%   M     = community_louvain(W);
%   [M,Q] = community_louvain(W,gamma);
%   [M,Q] = community_louvain(W,gamma,M0);
%   [M,Q] = community_louvain(W,gamma,M0,'potts');
%   [M,Q] = community_louvain(W,gamma,M0,'negative_asym');
%   [M,Q] = community_louvain(W,[],[],B);

[Louvain_CM] = community_louvain(Coactivation_matrix);
[Louvain_GA] = community_louvain(GroupAverage_rsfMRI);

figure(5)
subplot(231)
stem(Louvain_CM);title('Stem plot of Louvain (CM)')
subplot(232)
hist(Louvain_CM);title('Histogram of Louvain (CM)')
subplot(233)
boxplot(Louvain_CM);title('Box plot of Louvain (CM)')
subplot(234)
stem(Louvain_GA);title('Stem plot of Louvain (GA)')
subplot(235)
hist(Louvain_GA);title('Histogram of Louvain (GA)')
subplot(236)
boxplot(Louvain_GA);title('Box plot of Louvain (GA)')

% Modularity degeneracy
% Modularity degeneracy is the existence of
% multiple distinct high-modularity partitions
% of the same network.
%   Outputs:   agreement matrix

%Agr_CM = agreement(Coactivation_matrix)
%Agr_GA = agreement(GroupAverage_rsfMRI)

% Consensus partitioning
% Consensus partitioning aims to provide a single consensus
% partition of these degenerate partitions.
% D = agreement matrix, TAU = threshold, Reps = repetitions
% CIU = CONSENSUS(D,TAU,REPS)
%   Outputs:    CIU,    consensus partition

%% 5) Assortativity and Core Structure

% Assortativity
% The assortativity coefficient is a correlation coefficient between the
%   strengths (weighted degrees) of all nodes on two opposite ends of a link.
%   A positive assortativity coefficient indicates that nodes tend to link to
%   other nodes with the same or similar strength.
%   Outputs:    r,      assortativity coefficient

Assort_CM = assortativity_wei(Coactivation_matrix, 0);
Assort_GA = assortativity_wei(GroupAverage_rsfMRI, 0);

% Rich club coefficient
%   The weighted rich club coefficient, Rw, at level k is the fraction of
%   edge weights that connect nodes of degree k or higher out of the
%   maximum edge weights that such nodes might share.
%   Output:
%       Rw:         rich-club curve

RC_CM = rich_club_wu(Coactivation_matrix);
RC_GA = rich_club_wu(GroupAverage_rsfMRI);

figure(6)
subplot(121)
plot(RC_CM);title('Plot of rich club (CM)')
grid on
xlabel('k')
ylabel('\Phi(k)')
subplot(122)
plot(RC_GA);title('Plot of rich club (GA)')
grid on
xlabel('k')
ylabel('\Phi(k)')

% Core-periphery structure
%   Outputs:    binary vector of optimal core structure
%               C = 1 represents nodes in the core
%               C = 0 represents nodes in the periphery
%               q,      maximized core-ness statistic
CorPer_CM = core_periphery_dir(Coactivation_matrix);
CorPer_GA = core_periphery_dir(GroupAverage_rsfMRI);

figure(7)
subplot(221)
stem(CorPer_CM);title('Stem plot of core periphery (CM)')
subplot(222)
hist(CorPer_CM);title('Histogram of core periphery (CM)')
subplot(223)
stem(CorPer_GA);title('Stem plot of core periphery (GA)')
subplot(224)
hist(CorPer_GA);title('Histogram of core periphery (GA)')

% S-core
% based on node strengths
%   output:    CIJscore,    connection matrix of the s-core.  This matrix
%                           contains only nodes with a strength of at least s.
%                    sn,    size of s-score
[Score_CM,sn] = score_wu(Coactivation_matrix,.5);
[Score_GA,sn] = score_wu(GroupAverage_rsfMRI,.5);

figure(8)
subplot(121)
imagesc(flipud(Score_CM));title('S-core (CM)')
colorbar
set(gca,'YDir','normal')
caxis([0 .3])
subplot(122)
imagesc(flipud(Score_GA));title('S-core (GA)')
colorbar
set(gca,'YDir','normal')
caxis([0 .3])

%% 6) Paths and Distances

% Distance and characteristic path length

% Distance matrix, Floyd-Warshall algortithm
%   Outputs:
%
%       SPL,
%           Unweighted/Weighted shortest path-length matrix.
%           If W is directed matrix, then SPL is not symmetric.
%
%       hops,
%           Number of edges in the shortest path matrix. If W is
%           unweighted, SPL and hops are identical.
%
%       Pmat,
%           Elements {i,j} of this matrix indicate the next node in the
%           shortest path between i and j. This matrix is used as an input
%           argument for function 'retrieve_shortest_path.m', which returns
%           as output the sequence of nodes comprising the shortest path
%           between a given pair of nodes.

[SPL_CM,hops,Pmat] = distance_wei_floyd(Coactivation_matrix);
[SPL_GA,hops,Pmat] = distance_wei_floyd(GroupAverage_rsfMRI);

figure(9)
subplot(131)
imagesc(flipud(SPL_CM));title('Shortest path-length matrix (CM)')
colorbar
set(gca,'YDir','normal')
%caxis([0 5])
subplot(132)
imagesc(flipud(SPL_GA));title('Shortest path-length matrix (GA)')
colorbar
set(gca,'YDir','normal')
caxis([0 5])
subplot(133)
imagesc(flipud(hops));title('Number of edges in the shortest path matrix')
colorbar
set(gca,'YDir','normal')
caxis([0 5])

% Retrieve shortest path
% sequence of nodes that comprise the
% shortest path between a given source
% and target node.

%   Output:
%   path,
%     Nodes comprising the shortest path between nodes s and t.


% Distance matrix, Dijkstra's algorithm
%   Output:     D,      distance (shortest weighted path) matrix
%               B,      number of edges in shortest weighted path matrix
[D_CM,B] = distance_wei(Coactivation_matrix);
[D_GA,B] = distance_wei(GroupAverage_rsfMRI);

figure(10)
subplot(121)
imagesc(flipud(D_CM));title('Dijkstra distance matrix (CM)')
colorbar
set(gca,'YDir','normal')
%caxis([0 5])
subplot(122)
imagesc(flipud(D_GA));title('Dijkstra distance matrix (GA)')
colorbar
set(gca,'YDir','normal')
%caxis([0 5])

% Characteristic path length
%   Outputs:    lambda,         network characteristic path length

lambda_CM = charpath(Coactivation_matrix)
lambda_GA = charpath(GroupAverage_rsfMRI)

%% 7) Efficiency and Diffusion

% Rout efficiency
%   Outputs:
%
%       GErout,
%           Mean global routing efficiency (scalar).
%
%   	Erout,
%           Pair-wise routing efficiency (matrix).
%
%    	Eloc,
%           Local efficiency (vector)
[GlobEffRout_CM,Erout_CM,EffLoc_CM] = rout_efficiency(Coactivation_matrix,[]);
[GlobEffRout_GA,Erout_GA,EffLoc_GA] = rout_efficiency(GroupAverage_rsfMRI,[]);

figure(11)
subplot(121)
imagesc(flipud(Erout_CM));title('Pair-wise routing efficiency (CM)')
%colormap(gray)
colorbar
set(gca,'YDir','normal')
subplot(122)
imagesc(flipud(Erout_GA));title('Pair-wise routing efficiency (GA)')
%colormap(gray)
colorbar
set(gca,'YDir','normal')

figure(12)
subplot(231)
stem(EffLoc_CM);title('Stem plot of Local efficiency (CM)')
subplot(232)
hist(EffLoc_CM);title('Histogram of Local efficiency (CM)')
subplot(233)
boxplot(EffLoc_CM);title('Box plot of Local efficiency (CM)')
subplot(234)
stem(EffLoc_GA);title('Stem plot of Local efficiency (GA)')
subplot(235)
hist(EffLoc_GA);title('Histogram of Local efficiency (GA)')
subplot(236)
boxplot(EffLoc_GA);title('Box plot of Local efficiency (GA)')

% Mean first passage time
%   Output:
%   Pairwise mean first passage time matrix.

MFPT_CM = mean_first_passage_time(Coactivation_matrix);
%MFPT_GA = mean_first_passage_time(GroupAverage_rsfMRI)

figure(13)
imagesc(flipud(MFPT_CM));title('Pairwise mean first passage time matrix (CM)')
%colormap(gray)
colorbar
set(gca,'YDir','normal')

% Diffusion efficiency
% The diffusion efficiency is the inverse of the mean first passage time.
%   Outputs:
%       GEdiff, Mean Global diffusion efficiency (scalar)
%       Ediff,  Pair-wise diffusion efficiency (matrix)

[GEdiff_CM, Ediff_CM] = diffusion_efficiency(Coactivation_matrix);
%[GEdiff_GA, Ediff] = diffusion_efficiency(GroupAverage_rsfMRI);
str=sprintf('Pair-wise diffusion efficiency (CM), Mean Global diffusion eff. = %d', GEdiff_CM);

figure(14)
imagesc(flipud(Ediff_CM));title(str)
set(gca,'YDir','normal')
colorbar

%% 8) Centrality

% Betweenness (Brandes's algorithm)
%   Output: node betweenness centrality vector.
Btw_CM = betweenness_wei(Coactivation_matrix);
Btw_GA = betweenness_wei(GroupAverage_rsfMRI);

% Edge betweenness centrality
%  Output:     EBC,edge betweenness centrality matrix.
%               BC,nodal betweenness centrality vector.

[EBC_CM BC_CM] = edge_betweenness_wei(Coactivation_matrix);
[EBC_GA BC_GA] = edge_betweenness_wei(GroupAverage_rsfMRI);

figure(15)
subplot(231)
stem(BC_CM);title('Stem plot of nodal betweenness centrality (CM)')
subplot(232)
hist(BC_CM);title('Histogram of nodal betweenness centrality (CM)')
subplot(233)
boxplot(BC_CM);title('Box plot of nodal betweenness centrality (CM)')
subplot(234)
stem(BC_GA);title('Stem plot of nodal betweenness centrality (GA)')
subplot(235)
hist(BC_GA);title('Histogram of nodal betweenness centrality (GA)')
subplot(236)
boxplot(BC_GA);title('Box plot of nodal betweenness centrality (GA)')

figure(16)
subplot(121)
imagesc(flipud(EBC_CM));title('Edge betweenness centrality matrix (CM)')
colorbar
set(gca,'YDir','normal')
caxis([0 150])
subplot(122)
imagesc(flipud(EBC_GA));title('Edge betweenness centrality matrix (GA)')
colorbar
set(gca,'YDir','normal')
caxis([0 150])

% Within-module degree z-score
%   Output:  within-module degree z-score.

%ZScore_CM = module_degree_zscore(Coactivation_matrix,Ci,0);
%ZScore_GA = module_degree_zscore(GroupAverage_rsfMRI,Ci,0);

% Participation and related coefficients
% - participation
%   Output:     P,      participation coefficient
% P = participation_coef(W,Ci);

% - gateway
%   Output:     Gpos,     gateway coefficient for positive weights
%
%               Gneg,     gateway coefficient for negative weights

% - diversity
%   Output:     Hpos,   diversity coefficient based on positive connections
%               Hneg,   diversity coefficient based on negative connections


% Eigenvector centrality
%   Outputs: eigenvector associated with the largest
%            eigenvalue of the adjacency matrix CIJ.
EigV_CM = eigenvector_centrality_und(Coactivation_matrix);
EigV_GA = eigenvector_centrality_und(GroupAverage_rsfMRI);

figure(17)
subplot(231)
stem(EigV_CM);title('Stem plot of eigenvector centrality (CM)')
subplot(232)
hist(EigV_CM);title('Histogram of eigenvector centrality (CM)')
subplot(233)
boxplot(EigV_CM);title('Box plot of eigenvector centrality (CM)')
subplot(234)
stem(EigV_GA);title('Stem plot of eigenvector centrality (GA)')
subplot(235)
hist(EigV_GA);title('Histogram of eigenvector centrality (GA)')
subplot(236)
boxplot(EigV_GA);title('Box plot of eigenvector centrality (GA)')

% PageRank centrality

%PageRank_CM = pagerank_centrality(Coactivation_matrix, 0.85, 0.5)
%PageRank_GA = pagerank_centrality(GroupAverage_rsfMRI, 0.85, 0.5)