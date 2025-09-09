function reconstructed_points = task3_3(v1_points2d, v2_points2d, display_mse)
    % part 3: Triangulation to recover 3D mocap points from two views

    v1 = load('Parameters_V1_1.mat').Parameters;
    v2 = load('Parameters_V2_1.mat').Parameters;
    points3d = load('mocapPoints3D.mat').pts3D;

    % Extract parameters for camera 1
    v1_Rmat = v1.Rmat;
    v1_t = v1.position';
    v1_Pmat = v1.Pmat;
    v1_Kmat = v1.Kmat;
    v1_points2d(3,:) = 1;
    v1_vector = transpose(v1_Rmat) * inv(v1_Kmat) * v1_points2d;
    v1_vector_norm = v1_vector ./ vecnorm(v1_vector);

    % Extract parameters for camera 2
    v2_Rmat = v2.Rmat;
    v2_t = v2.position';
    v2_Pmat = v2.Pmat;
    v2_Kmat = v2.Kmat;
    v2_points2d(3,:) = 1;
    v2_vector = transpose(v2_Rmat) * inv(v2_Kmat) * v2_points2d;
    v2_vector_norm = v2_vector./ vecnorm(v2_vector);

    % Compute the cross product of direction vectors to find perpendicular vector for each pair
    cross_product = cross(v1_vector_norm, v2_vector_norm);
    % Normalize the cross product
    cross_product_norm = cross_product ./ vecnorm(cross_product);


    num_points = size(v1_points2d, 2); % 39 points
    reconstructed_points = zeros(3,num_points); % 3x39 matrix
    % Set up triangulation for each point
    for i = 1:num_points
        A = [v1_vector_norm(:, i), -v2_vector_norm(:,i), cross_product_norm(:,i)];
        B = v2_t - v1_t; % Translation vector between the two camera positions

        % Solve for scale factors a, b, and d
        x = A \ B; % x contains [a; b; d]
        a = x(1);
        b = x(2);

        point1 = v1_t + a*v1_vector_norm(:, i);
        point2 = v2_t + b*v2_vector_norm(:, i);

        % The reconstructed point is the midpoint between these two closest points
        reconstructed_points(:,i) = (point1+point2)/2;
    end

    % Calculate MSE between reconstructed points and original 3D points
    if (display_mse)
        squared_errors = (reconstructed_points - points3d) .^ 2;
        mse = mean(squared_errors(:));
        fprintf('Mean squared Error of reconstruction:\n');
        disp(mse);
    end
end

