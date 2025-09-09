% mocap_3d = load('mocapPoints3D.mat').pts3D';
% v1 = load('Parameters_V1_1.mat').Parameters;
% v2 = load('Parameters_V2_1.mat').Parameters;

% addpath("./");

%% part 1: Understanding pinhole camera model parameters

task3_1;

%% part 2: Projecting 3D mocap points into 2D pixel locations

v1_points2d = task3_2('Parameters_V1_1.mat', 'mocapPoints3D.mat', 'im1corrected.jpg', 1);
v2_points2d = task3_2('Parameters_V2_1.mat', 'mocapPoints3D.mat', 'im2corrected.jpg', 1);

%% part 3: Triangulation to recover 3D mocap points from two views

reconstructed_points = task3_3(v1_points2d, v2_points2d, 1);

%% part 4: Triangulation to make measurements about the scene

task3_4;

%% part 5: Compute the Fundamental matrix from known camera calibration parameters

task3_5;

%% part 6: Compute the Fundamental matrix using the eight-point algorithm

task3_6;

%% part 7: Quantitative evaluation of your estimated F matrices

task3_7;

%% part 8: extra credit 1: Modify F matrix for cropped views

task3_extra_1;

%% part 9: extra credit 2: Generate a top-down view of the floor plane

task3_extra_2;

