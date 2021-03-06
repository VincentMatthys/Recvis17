% PART I: basic features

% setup MATLAB to use our software
setup ;

%%
% --------------------------------------------------------------------
%                                   Stage I.A: SIFT features detection
% --------------------------------------------------------------------

%% Load an image
im1 = imread('data/oxbuild_lite/all_souls_000002.jpg') ;
%%
% Let the second image be a rotated and scaled version of the first
im3 = imresize(imrotate(im1, 35, 'bilinear'), 0.7) ;
% Display the images
subplot(1,2,1) ; imagesc(im1) ; axis equal off ; hold on ;
subplot(1,2,2) ; imagesc(im3) ; axis equal off ;

%% Compute SIFT features for each

[frames1, descrs1] = getFeatures(im1, 'peakThreshold', 0.001) ;
[frames3, descrs3] = getFeatures(im3, 'peakThreshold', 0.001) ;

figure(1) ;
set(gcf,'name', 'Part I.A: SIFT features detection - synthetic pair') ;
subplot(1, 2,1) ; imagesc(im1) ; axis equal off ; hold on ;
vl_plotframe(frames1, 'linewidth', 1) ;

subplot(1,2,2) ; imagesc(im3) ; axis equal off ; hold on ;
vl_plotframe(frames3, 'linewidth', 1) ;
% saveas(gcf, '1A_0_001.png')


%% Load a second image of the same scene
im2 = imread('data/oxbuild_lite/all_souls_000015.jpg') ;
[frames2, descrs2] = getFeatures(im2, 'peakThreshold', 0.001) ;

figure(2) ;
set(gcf,'name', 'Part I.A: SIFT features detection - real pair') ;
subplot(1,2,1) ; imagesc(im1) ; axis equal off ; hold on ;
vl_plotframe(frames1, 'linewidth', 2) ;

subplot(1,2,2) ; imagesc(im2) ; axis equal off ; hold on ;
vl_plotframe(frames2, 'linewidth', 2) ;

%% Sift detections for 3 different thresholds
[frames1_1, descrs1_1] = getFeatures(im1, 'peakThreshold', 0.0001) ;
[frames1_2, descrs1_2] = getFeatures(im1, 'peakThreshold', 0.001) ;
[frames1_3, descrs1_3] = getFeatures(im1, 'peakThreshold', 0.01) ;

[frames2_1, descrs2_1] = getFeatures(im2, 'peakThreshold', 0.0001) ;
[frames2_2, descrs2_2] = getFeatures(im2, 'peakThreshold', 0.001) ;
[frames2_3, descrs2_3] = getFeatures(im2, 'peakThreshold', 0.01) ;

%%
imshow(im1, 'InitialMagnification', 'fit');
axis equal off ; hold on ;
vl_plotframe(frames1_3, 'linewidth', 1) ;

%%
[ha, pos] = tight_subplot(2,3,[.01 .03],[.1 .01],[.01])
axes(ha(1)); imshow(im1, 'InitialMagnification', 'fit');
axis equal off ; hold on ;
vl_plotframe(frames1_1, 'linewidth', 1) ;
axes(ha(2)); imshow(im1, 'InitialMagnification', 'fit');
axis equal off ; hold on ;
vl_plotframe(frames1_2, 'linewidth', 1) ;
axes(ha(3)); imshow(im1, 'InitialMagnification', 'fit');
axis equal off ; hold on ;
vl_plotframe(frames1_3, 'linewidth', 1) ;
axes(ha(4)); imshow(im2, 'InitialMagnification', 'fit');
axis equal off ; hold on ;
vl_plotframe(frames2_1, 'linewidth', 1) ;
axes(ha(5)); imshow(im2, 'InitialMagnification', 'fit');
axis equal off ; hold on ;
vl_plotframe(frames2_2, 'linewidth', 1) ;
axes(ha(6)); imshow(im2, 'InitialMagnification', 'fit');
axis equal off ; hold on ;
vl_plotframe(frames2_3, 'linewidth', 1) ;

%%
% --------------------------------------------------------------------
%     Stage I.B: SIFT features descriptors and matching between images
% --------------------------------------------------------------------

%% Visualize SIFT descriptors (only a few)
figure(3) ; clf ;
set(gcf,'name', 'Part I.B: SIFT descriptors') ;
imagesc(im1) ; axis equal off ;
vl_plotsiftdescriptor(descrs1(:,1:50:end), ...
                      frames1(:,1:50:end)) ;
hold on ;
vl_plotframe(frames1(:,1:50:end)) ;

%% Find for each desriptor in im1 the closest descriptor in im2
nn = findNeighbours(descrs1, descrs2) ;

% Construct a matrix of matches. Each column stores two index of
% matching features in im1 and im2
matches = [1:size(descrs1,2) ; nn(1,:)] ;

% Display the matches
figure(4) ; clf ;
set(gcf,'name', 'Part I.B: SIFT descriptors - matching') ;
plotMatches(im1,im2,frames1,frames2,matches) ;
% plotMatches(im1,im2,frames1,frames2,matches(:,[203 1603 1803])) ;
title('Nearest neighbour matches') ;

%%
% --------------------------------------------------------------------
%  Stage I.C: Better matching (i) Lowe's second nearest neighbour test
% --------------------------------------------------------------------

% Find the top two neighbours as well as their distances
[nn, dist2] = findNeighbours(descrs1, descrs2, 2) ;

%% Accept neighbours if their second best match is sufficiently far off
nnThreshold = 0.95 ;
ratio2 = dist2(1,:) ./ dist2(2,:) ;
ok = ratio2 <= nnThreshold^2 ;

% Construct a list of filtered matches
matches_2nn = [find(ok) ; nn(1, ok)] ;

% Alternatively, do not do the second nearest neighbourhod test.
% Instead, match each feature to its two closest neighbours and let
% the geometric verification step figure it out.

% matches_2nn = [1:size(nn,2), 1:size(nn,2) ; nn(1,:), nn(2,:)] ;

% Display the matches
figure(5) ; clf ;
set(gcf,'name', 'Part I.C: SIFT descriptors - Lowe''s test') ;
plotMatches(im1,im2,frames1,frames2,matches_2nn) ;
title('');
% title('Matches filtered by the second nearest neighbour test') ;

size(matches_2nn)
%%
% --------------------------------------------------------------------
%             Stage I.D: Better matching (ii) geometric transformation
% --------------------------------------------------------------------

inliers = geometricVerification(frames1, frames2, matches_2nn, 'numRefinementIterations', 8) ;
matches_geo = matches_2nn(:, inliers) ;

size(matches_geo)
%% Display the matches
figure(6) ; clf ;
set(gcf,'name', 'Part I.D: SIFT descriptors - geometric verification') ;
plotMatches(im1,im2,frames1,frames2,matches_geo) ;
% title('Matches filtered by geometric verification') ;
title('');
