% part 7: Quantitative evaluation of your estimated F matrices
image1 = imread('im1corrected.jpg');
image2 = imread('im2corrected.jpg');
v1 = load('Parameters_V1_1.mat').Parameters;
v2 = load('Parameters_V2_1.mat').Parameters;
mocap_3d = load('mocapPoints3D.mat').pts3D';
addpath("./");

v1_Kmat = v1.Kmat;
v2_Kmat = v2.Kmat;
v1_Rmat = v1.Rmat;
v2_Rmat = v2.Rmat;
v1_position = v1.position(:);
v2_position = v2.position(:);
v1_points2d = task3_2('Parameters_V1_1.mat', 'mocapPoints3D.mat', 'im1corrected.jpg', 0);
v2_points2d = task3_2('Parameters_V2_1.mat', 'mocapPoints3D.mat', 'im2corrected.jpg', 0);

F1 = get_F_from_camera_calibration_parameters(v1_Rmat, v2_Rmat, v1_Kmat, v2_Kmat, v1_position, v2_position);
F2 = get_F_by_eight_point_algo_with_Hartley_preconditioning(v1_points2d, v2_points2d);
F3 = get_F_by_eight_point_algo_without_Hartley_preconditioning(v1_points2d, v2_points2d);

sed1 = compute_symmetric_epipolar_distance(F1, v1_points2d, v2_points2d);
sed2 = compute_symmetric_epipolar_distance(F2, v1_points2d, v2_points2d);
sed3 = compute_symmetric_epipolar_distance(F3, v1_points2d, v2_points2d);

fprintf("The SED value for the F calculated from camera calibration parameters is: ");
disp(sed1);
fprintf("The SED value for the F calculated by eight-point algorithm with using Hartley preconditioning: ");
disp(sed2);
fprintf("The SED value for the F calculated by eight-point algorithm without using Hartley preconditioning: ");
disp(sed3);

