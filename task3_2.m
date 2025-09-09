function points2d = task3_2(camera_file, mocap_points_3d_file, image_file, display)
    % part 2: Projecting 3D mocap points into 2D pixel locations

    camera = load(camera_file).Parameters;
    points3d = load(mocap_points_3d_file).pts3D;

    P = camera.Pmat;
    K = camera.Kmat;

    % Add a row of ones at the bottom (4-th row) of points,
    % for satisfying the later calculation.
    points3d(4,:)= 1;


    % project the 3d points to 2d
    tmp = K * (P * points3d);

    tmp(1,:) = tmp(1,:) ./ tmp(3, :);
    tmp(2,:) = tmp(2,:) ./ tmp(3, :);
    tmp(3,:) = 1; 

    points2d = tmp(1:2,:);

    if (display)
        im1 = imread(image_file);
        figure;
        clf;
        imshow(im1);
        hold on;
        plot(points2d(1,:), points2d(2,:), 'r*', 'Linewidth', 1);
        hold off;
        pause(1);
    end;

end

