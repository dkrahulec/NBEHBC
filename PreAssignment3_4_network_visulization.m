clear;
close all;
load('Coactivation_matrix.mat');
load('GroupAverage_rsfMRI_matrix.mat');
a=12;


%Community structure of coactivation matrix
M_coa = community_louvain(Coactivation_matrix);     % get community assignments
[X,Y,INDSORT] = grid_communities(M_coa); % call function
figure;
imagesc(Coactivation_matrix(INDSORT,INDSORT));           % plot ordered adjacency matrix
%set(gca,'YDir','normal');
hold on;                                 % hold on to overlay community visualization
plot(X,Y,'r','linewidth',2); 
title('Co-activation matrix: grid community structure');
xlabel('Node number');
ylabel('Node number');


%Community structure of group average rs-fMRI 
M_garsfmri = community_louvain(GroupAverage_rsfMRI);     % get community assignments
[X,Y,INDSORT] = grid_communities(M_garsfmri); % call function
figure;
imagesc(GroupAverage_rsfMRI(INDSORT,INDSORT));           % plot ordered adjacency matrix
%set(gca,'YDir','normal');
hold on;                                 % hold on to overlay community visualization
plot(X,Y,'r','linewidth',2); 
title('Group average, rsFMRI: grid community structure');
xlabel('Node number');
ylabel('Node number');

a=12;

%Backbone of coactivation matrix with avgdeg of 15
avgdeg=15;
[CIJtree,CIJclus] = backbone_wu(Coactivation_matrix,avgdeg);
figure;
imagesc(CIJclus);
title('Co-activation matrix: backbone of network');
xlabel('Node number');
ylabel('Node number');

a=12;
%Backbone of group average rs fMRI with avgdeg of 15
avgdeg=15;
[CIJtree,CIJclus] = backbone_wu(GroupAverage_rsfMRI,avgdeg);
figure;
imagesc(CIJclus);
title('Group average: rsfMRI: backbone of network');
xlabel('Node number');
ylabel('Node number');


[Mreordered,Mindices,cost] = align_matrices(Coactivation_matrix,GroupAverage_rsfMRI,'sqrdff')
figure;

imagesc(Mreordered);
title('Aligned matrices: group average rsfMRI network with coactivation matrix');
xlabel('Node number');
ylabel('Node number');

figure;
[Mreordered,Mindices,cost] = reorder_matrix(Coactivation_matrix,'line',0)
imagesc(Mreordered);
title('Re-ordered group average rsfMRI network');
xlabel('Node number');
ylabel('Node number');


figure;
[Mreordered,Mindices,cost] = reorder_matrix(GroupAverage_rsfMRI,'line',0)
imagesc(Mreordered);
title('Re-ordered group average rsfMRI network');
xlabel('Node number');
ylabel('Node number');

On_coa = reorder_mod(Coactivation_matrix,M_coa);
a=12;

On_garsfmri = reorder_mod(GroupAverage_rsfMRI,M_garsfmri);
a=12;


figure;
subplot(2,3,1);
stem(On_coa);
title('Stem plot: reordered coactivity connectivity matrix by modular structure');
subplot(2,3,2);
hist(On_coa);
title('Histogram: reordered coactivity connectivity matrix by modular structure');
subplot(2,3,3);
boxplot(On_coa);
title('Boxplot: reordered coactivity connectivity matrix by modular structure');

figure;
subplot(2,3,4);
stem(On_garsfmri);
title('Stem plot: reordered rs-fMRI matrix by modular structure');
subplot(2,3,5);
hist(On_garsfmri);
title('Histogram: reordered rs-fMRI matrix by modular structure');
subplot(2,3,6);
boxplot(On_garsfmri);
title('Boxplot: reordered rs-fMRI matrix by modular structure');


figure;
[MATreordered,MATindices,MATcost] = reorderMAT(Coactivation_matrix,3,'line');
imagesc(MATreordered);
a=12;


figure;
[MATreordered,MATindices,MATcost] = reorderMAT(Coactivation_matrix,3,'line');
imagesc(MATreordered);
% [id,od,deg] = degrees_dir(macaque_network.CIJ);
% figure;
% subplot(3,3,1);
% stem(deg);
% title('Stem plot: total degrees of network');
% subplot(3,3,2);
% hist(deg);
% title('Histogram: total degrees of network');
% subplot(3,3,3);
% boxplot(deg);
% title('Boxplot: total degrees of network');


 
 