function SED = compute_symmetric_epipolar_distance(F, v1_points_2d, v2_points_2d)

    num_points = size(v1_points_2d, 2);

    v1_points_homo = [v1_points_2d; ones(1, num_points)];
    v2_points_homo = [v2_points_2d; ones(1, num_points)];

    total_error = 0;

    for i = 1:num_points
        % Get homogeneous coordinates for points in image 1 and image 2
        x1 = v1_points_homo(:, i);  % 3x1 vector for point in image 1
        x2 = v2_points_homo(:, i);  % 3x1 vector for point in image 2

        % Compute the epipolar line in image 2 for the point in image 1
        l2 = F * x1;  % 3x1 vector (epipolar line in image 2)

        % Compute the epipolar line in image 1 for the point in image 2
        l1 = F' * x2;  % 3x1 vector (epipolar line in image 1)

        % Compute the distances from points to epipolar lines
        % Distance from x2 to l2 (in image 2)
        d2 = (x2' * l2)^2 / (l2(1)^2 + l2(2)^2);

        % Distance from x1 to l1 (in image 1)
        d1 = (x1' * l1)^2 / (l1(1)^2 + l1(2)^2);

        % Add to total error
        total_error = total_error + d1 + d2;
    end

    % Compute mean symmetric epipolar distance (average squared distance)
    SED = total_error / num_points;

end
