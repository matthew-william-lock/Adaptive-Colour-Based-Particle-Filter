% This file is to return euclidean distances between colour distributions,
% as well as identify particles that are outside of the image
%
% "3D Trajectory Prediction of Basketball Shot Using Filtering Techniques
% and Computer Vision" project. The project is a self picked topic for implementation
% in the Appied Estimation course at% the KTH Royal Institute of Technology in 2021.
%
% Authors : 
% Matthew William Lock (mwlock@kth.se)
% Miguel Garcia Naude (magn2@kth.se)

function distance = pf_get_euclid_distance(target,sample)

        dist_intermediate = sum((target - sample).^2,2);
        distance = sqrt(sum(dist_intermediate.^2));

end