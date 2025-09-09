% part 4: Triangulation to make measurements about the scene

addpath('./');
v1 = load('Parameters_V1_1.mat').Parameters;
v2 = load('Parameters_V2_1.mat').Parameters;
points3d = load('mocapPoints3D.mat').pts3D;
image1 = imread('im1corrected.jpg');
image2 = imread('im2corrected.jpg');

% Floor points - Start
fprintf('Please select three corresponding points on the floor in both images.\n');
fprintf('These points should represent the same physical locations in both views.\n');

% % Show the image for v1
% figure; clf;
% imshow(image1);
% % Get three points over the image for v1
% v1_floor_points = ginput(3)';
% hold on;
% % Keep the image and display the plots
% plot(v1_floor_points(1,:), v1_floor_points(2,:), 'ro');

v1_floor_points = [410, 1050, 1000;
                   716, 954, 616];
figure;clf;
imshow(image1);
hold on;
plot(v1_floor_points(1,:), v1_floor_points(2,:), 'ro');
title('Three points on the floor in camera v1.')
hold off;
pause(1);


% % Show the image for v2
% figure; clf;
% imshow(image2);
% % Get three points over the image for v2
% v2_floor_points = ginput(3)';
% hold on;
% % Keep the image and display the plots
% plot(v2_floor_points(1,:),v2_floor_points(2,:), 'ro');

v2_floor_points = [960, 1694, 566;
                   884, 708, 606];
figure;clf;
imshow(image2);
hold on;
plot(v2_floor_points(1,:), v2_floor_points(2,:), 'ro');
title('Three points on the floor in camera v2.')
hold off;
pause(1);

% Triangulation
reconstructed_points = task3_3(v1_floor_points, v2_floor_points, 0);

% Fit a plane to the floor points
% Fit plane by ax + by + cz + d = 0
[floor_a, floor_b, floor_c, floor_d] = fit_plane(reconstructed_points);
fprintf('Equation of the floor plane: %fx + %fy + %fz + %f = 0\n', floor_a, floor_b, floor_c, floor_d);



% Create a 3D grid of x and y values
figure;clf;
[x,y] = meshgrid(-100:10:100, -100:10:100); % Adjust grid limits may be needed

z = (-floor_a*x - floor_b*y - floor_d) / floor_c;

surf(x,y,z);

title('Floor Plane Plot');

xlabel('x'), ylabel('y'), zlabel('z');

z_min = min(z, [], 'all');

z_max = max(z, [], 'all');

zticks([floor(z_min):1:ceil(z_max)]);
pause(1);
% Floor points - End

fprintf('\n');
fprintf('\n');











% Wall points - Start
fprintf('Please select three corresponding points on the wall in both images.\n');
fprintf('These points should represent the same physical locations in both views.\n');

% % Show the image for v1
% figure; clf;
% imshow(image1);
% % Get three points over the image for v1
% v1_wall_points = ginput(3)';
% hold on;
% % Keep the image and display the plots
% plot(v1_wall_points(1,:), v1_wall_points(2,:), 'ro');

v1_wall_points = [1236, 1372, 1514;
                  218,  142,  226];
figure;clf;
imshow(image1);
hold on;
plot(v1_wall_points(1,:), v1_wall_points(2,:), 'ro');
title('Three points on the wall in camera v1.')
hold off;
pause(1);


% % Show the image for v2
% figure; clf;
% imshow(image2);
% % Get three points over the image for v2
% v2_wall_points = ginput(3)';
% hold on;
% % Keep the image and display the plots
% plot(v2_wall_points(1,:),v2_wall_points(2,:), 'ro');

v2_wall_points = [340, 508, 674;
                  122, 52,  158];
figure;clf;
imshow(image2);
hold on;
plot(v2_wall_points(1,:), v2_wall_points(2,:), 'ro');
title('Three points on the wall in camera v2.')
hold off;
pause(1);

% Triangulation
reconstructed_points = task3_3(v1_wall_points, v2_wall_points, 0);

% Fit a plane to the wall points
% Fit plane by ax + by + cz + d = 0
[wall_a, wall_b, wall_c, wall_d] = fit_plane(reconstructed_points);
fprintf('Equation of the wall plane: %fx + %fy + %fz + %f = 0\n', wall_a, wall_b, wall_c, wall_d);



% Create a 3D grid of x and y values
figure; clf;
[x,y] = meshgrid(-100:10:100, -100:10:100); % Adjust grid limits may be needed

z = (-wall_a*x - wall_b*y - wall_d) / wall_c;

surf(x,y,z);

title('Wall Plane Plot');

xlabel('x'), ylabel('y'), zlabel('z');

z_min = min(z, [], 'all');

z_max = max(z, [], 'all');

xticks([floor(z_min):1:ceil(z_max)]);
pause(1);
% wall points - End


% door points - Start
fprintf('Please select two corresponding points on the top and bottom of door in both images.\n');
fprintf('These points should represent the same physical locations in both views.\n');

% % Show the image for v1
% figure; clf;
% imshow(image1);
% % Get three points over the image for v1
% v1_door_points = ginput(2)';
% hold on;
% % Keep the image and display the plots
% plot(v1_door_points(1,:), v1_door_points(2,:), 'ro');

v1_door_points = [1202, 1188;
                  306,  560];
figure;clf;
imshow(image1);
hold on;
plot(v1_door_points(1,:), v1_door_points(2,:), 'ro');
title('Two points on the door in camera v1.')
hold off;
pause(1);

% % Show the image for v2
% figure; clf;
% imshow(image2);
% % Get three points over the image for v2
% v2_door_points = ginput(2)';
% hold on;
% % Keep the image and display the plots
% plot(v2_door_points(1,:),v2_door_points(2,:), 'ro');

v2_door_points = [310, 334;
                  226, 526];
figure;clf;
imshow(image2);
hold on;
plot(v2_door_points(1,:), v2_door_points(2,:), 'ro');
title('Two points on the door in camera v2.')
hold off;
pause(1);

% Triangulation
reconstructed_points = task3_3(v1_door_points, v2_door_points, 0);
door_height = abs(reconstructed_points(3,1)- reconstructed_points(3,2));
fprintf("The height of doorway: %f mm, or %f cm\n", door_height, door_height/10);
% door points - End


% person points - Start
fprintf('Please select two corresponding points on the top and bottom of person in both images.\n');
fprintf('These points should represent the same physical locations in both views.\n');

% % Show the image for v1
% figure; clf;
% imshow(image1);
% % Get three points over the image for v1
% v1_person_points = ginput(2)';
% hold on;
% % Keep the image and display the plots
% plot(v1_person_points(1,:), v1_person_points(2,:), 'ro');

v1_person_points = [592, 604;
                    372, 734];
figure;clf;
imshow(image1);
hold on;
plot(v1_person_points(1,:), v1_person_points(2,:), 'ro');
title('Two points may represent the height of person in camera v1.')
hold off;
pause(1);

% % Show the image for v2
% figure; clf;
% imshow(image2);
% % Get three points over the image for v2
% v2_person_points = ginput(2)';
% hold on;
% % Keep the image and display the plots
% plot(v2_person_points(1,:),v2_person_points(2,:), 'ro');

v2_person_points = [1110, 1102;
                    344,  788];
figure;clf;
imshow(image2);
hold on;
plot(v2_person_points(1,:), v2_person_points(2,:), 'ro');
title('Two points may represent the height of person in camera v2.')
hold off;
pause(1);

% Triangulation
reconstructed_points = task3_3(v1_person_points, v2_person_points, 0);
person_height = abs(reconstructed_points(3,1)- reconstructed_points(3,2));
fprintf("The height of person in graph: %f mm, or %f cm\n", person_height, person_height/10);
% person points - End


% camera points - Start
fprintf('Please select one corresponding point on the top of camera in both images.\n');
fprintf('These points should represent the same physical locations in both views.\n');

% % Show the image for v1
% figure; clf;
% imshow(image1);
% % Get three points over the image for v1
% v1_camera_points = ginput(1)';
% hold on;
% % Keep the image and display the plots
% plot(v1_camera_points(1,:), v1_camera_points(2,:), 'co');

v1_camera_points = [1554;
                    270];
figure;clf;
imshow(image1);
hold on;
plot(v1_camera_points(1,:), v1_camera_points(2,:), 'co');
title('The point on the other camera in camera v1.')
hold off;
pause(1);


% % Show the image for v2
% figure; clf;
% imshow(image2);
% % Get three points over the image for v2
% v2_camera_points = ginput(1)';
% hold on;
% % Keep the image and display the plots
% plot(v2_camera_points(1,:),v2_camera_points(2,:), 'co');

v2_camera_points = [764;
                    200];
figure;clf;
imshow(image2);
hold on;
plot(v2_camera_points(1,:), v2_camera_points(2,:), 'co');
title('The point on the other camera in camera v2.')
hold off;
pause(1);


% Triangulation
reconstructed_points = task3_3(v1_camera_points, v2_camera_points, 0);
fprintf("Center of the camera is at x: %f, y: %f, z: %f\n", reconstructed_points(1,1), reconstructed_points(2,1), reconstructed_points(3,1));
% camera points - End


function [a,b,c,d] = fit_plane(points)
    A = points(:, 1);
    B = points(:, 2);
    C = points(:, 3);

    AB = B - A;
    AC = C - A;

    % Calculation the normal vector to the plane
    normal = cross(AB, AC);

    % Components of the plane equation
    a = normal(1);
    b = normal(2);
    c = normal(3);
    d = -dot(normal, A);
end

