image = imread('im1corrected.jpg');
addpath("./");

figure;

imshow(image); 
hold on;

[points_x, points_y] = ginput(4);

points2d = [points_x'; points_y'];

% Display the clicked points in the console
disp('You clicked the following points:');
for i = 1:size(points2d, 2)
    fprintf('Point %d: (%.2f, %.2f)\n', i, points2d(1,i), points2d(2,i));
end

% Plot the points and annotate them with their sequence numbers
plot(points2d(1,:), points2d(2,:), 'ro', 'MarkerSize', 10, 'LineWidth', 2); % Mark points
for i = 1:size(points2d, 2)
    text(points2d(1,i), points2d(2,i), sprintf(' %d', i), 'Color', 'yellow', 'FontSize', 12, 'FontWeight', 'bold');
end

hold off;

