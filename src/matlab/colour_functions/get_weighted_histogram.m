% This file is to return colour histogram of region in an image
%
% "3D Trajectory Prediction of Basketball Shot Using Filtering Techniques
% and Computer Vision" project. The project is a self picked topic for implementation
% in the Appied Estimation course at% the KTH Royal Institute of Technology in 2021.
%
% Authors : 
% Matthew William Lock (mwlock@kth.se)
% Miguel Garcia Naude (magn2@kth.se)

% observation likelihood
%           image                
%           binaryImage

%           center_coordinate [y,x]
% Outputs: 
%           histogram            3X8    

function histogram = get_weighted_histogram(image, binaryImage, center_coordinate,a,X,Y)
    
    % Parameters
    h_bins = 16;
    s_bins = 16;
    v_bins = 1;

    % Matrix sizing
    max_bins = max([h_bins,s_bins,v_bins]);
    bins = zeros(1,max_bins);
    
    % Distance mask
    %     distance_mask = sqrt ((X-center_coordinate(2)).^2 + (Y-center_coordinate(1)).^2);
    
    % Reshape image and binary image
    reference_frame = reshape(image, [], 3);
    mask_reshaped = reshape(binaryImage, [], 1);
    
    % Get masked pixels
    masked_pixels = reference_frame(mask_reshaped,:);
    masked_pixels = reshape(masked_pixels, [], 1, 3);

    % Mask distance
    X =  reshape(X, [], 1);
    Y =  reshape(Y, [], 1);
    X = X(mask_reshaped,:);
    Y = Y(mask_reshaped,:);
    pixel_distances = sqrt ((X-center_coordinate(2)).^2 + (Y-center_coordinate(1)).^2);

    %     pixel_distances = reshape(distance_mask, [], 1);
    %     pixel_distances = pixel_distances(mask_reshaped,:);
    n = size(pixel_distances,1);
    
    % Calculate weights using distances
    weights = ones(n,1) - (pixel_distances/a).^2;
    weights = max(weights,0);
    
    % Check if there are weighted pixels
    if sum(weights)==0
        histogram = [0];
        return
    end
    
    % Normalise weights
    weights = weights/sum(weights);
    
    % Get Colours histogram
    [h_counts,~] = weighted_histogram(masked_pixels(:,:,1), weights, 0, 1, h_bins);
    h_counts = h_counts';
    h = bins;
    h(1:size(h_counts,2)) = h_counts;

    [s_counts,~] = weighted_histogram(masked_pixels(:,:,2), weights, 0, 1, s_bins);
    s_counts = s_counts';
    s = bins;
    s(1:size(s_counts,2)) = s_counts;

    [v_counts,~] = weighted_histogram(masked_pixels(:,:,3), weights, 0, 1, v_bins);
    v_counts = v_counts';
    v = bins;
    v(1:size(v_counts,2)) = v_counts;
    
    % Generate target histogram
    histogram = [h;s;v];