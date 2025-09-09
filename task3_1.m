% part 1: Understanding pinhole camera model parameters

v1 = load('Parameters_V1_1.mat').Parameters;
v2 = load('Parameters_V2_1.mat').Parameters;

addpath("./");

v1_foclen = v1.foclen;
v1_orientation = v1.orientation;
v1_position = v1.position;
v1_prinpoint = v1.prinpoint;
v1_radial = v1.radial;
v1_aspectratio = v1.aspectratio;
v1_skew = v1.skew;
v1_Pmat = v1.Pmat;
v1_Rmat = v1.Rmat;
v1_Kmat = v1.Kmat;
v1_im = imread('im1corrected.jpg');


v2_foclen = v2.foclen;
v2_orientation = v2.orientation;
v2_position = v2.position;
v2_prinpoint = v2.prinpoint;
v2_radial = v2.radial;
v2_aspectratio = v2.aspectratio;
v2_skew = v2.skew;
v2_Pmat = v2.Pmat;
v2_Rmat = v2.Rmat;
v2_Kmat = v2.Kmat;
v2_im = imread('im2corrected.jpg');

% list of varaibles in Parameters_V*_*.mat
% foclen
% orientation
% position
% prinpoint
% radial
% aspectratio
% skew
% Pmat
% Rmat
% Kmat

% position

% intrinsic parameters
% focal length, note f_x = f_y / f/s_x =f/s_y  always in real world: foclen
% offset/image center/principle point: prinpoint
% describe non-perpendicular images axes: skew; always zero for modern manufactured CCD and CMOS cameras
% aspect ratio, s_y/s_x: aspectratio
% intrinsic parameter matrix: Kmat (L15-P24, L17-P19~P21, constructed by foclen, skew, aspectratio, and prinpoint)
% radial: represents the nonlinear radial lens distortion. (May not correct)
%
% extrinsic parameters
% Rotation matrix: Rmat
% projection matrix in 3D for projecting world to camera: Pmat (Rmat is part of Pmat)
% orientation: hint for project description: Rmat represents the same thing with orientation.
% position: location of the camera compare with the world coordinate. (May not correct)
%
fprintf('Camera Parameters for Parameters_V1_1.mat:\n');
fprintf('Extrinsic Parameters:\n');
fprintf('Camera orientation:\n');
disp(v1_orientation);
fprintf('Rotation Matrix R:\n');
disp(v1_Rmat);
fprintf('Translation Vector t:\n');
disp(v1_position);
fprintf('Projection Matrix P:\n');
disp(v1_Pmat);


fprintf("\n");
fprintf("\n");

fprintf('Intrinsic Parameters\n');
fprintf('focal length, foclen:\n');
disp(v1_foclen);
fprintf('skew: \n');
disp(v1_skew);
fprintf('aspect ratio:\n');
disp(v1_aspectratio);
fprintf('principle point:\n');
disp(v1_prinpoint);
fprintf('intrinsic parameter matrix for projecting camera coords to film and film coords to pixels, build by focal length, skew, aspect ration, and principle point: Kmat: \n');
disp(v1_Kmat);
fprintf('the nonlinear radial lens distortion: radial:\n')
disp(v1_radial);

fprintf("\n");
fprintf("\n");
fprintf("\n");
fprintf("\n");

fprintf('Camera Parameters for Parameters_V2_1.mat:\n');
fprintf('Extrinsic Parameters:\n');
fprintf('Camera orientation:\n');
disp(v2_orientation);
fprintf('Rotation Matrix R:\n');
disp(v2_Rmat);
fprintf('Translation Vector t:\n');
disp(v2_position);
fprintf('Projection Matrix P:\n');
disp(v2_Pmat);


fprintf("\n");
fprintf("\n");

fprintf('Intrinsic Parameters\n');
fprintf('focal length, foclen:\n');
disp(v2_foclen);
fprintf('skew: \n');
disp(v2_skew);
fprintf('aspect ratio:\n');
disp(v2_aspectratio);
fprintf('principle point:\n');
disp(v2_prinpoint);
fprintf('intrinsic parameter matrix for projecting camera coords to film and film coords to pixels, build by focal length, skew, aspect ration, and principle point: Kmat: \n');
disp(v2_Kmat);
fprintf('the nonlinear radial lens distortion: radial:\n')
disp(v2_radial);
