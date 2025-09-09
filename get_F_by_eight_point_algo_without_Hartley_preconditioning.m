function F = get_F_by_eight_point_algo_without_Hartley_preconditioning(v1_points_2d, v2_points_2d)
    x1 = v1_points_2d(1,:)';
    y1 = v1_points_2d(2,:)';
    x2 = v2_points_2d(1,:)';
    y2 = v2_points_2d(2,:)';

    nx1 = x1;
    ny1 = y1;
    nx2 = x2;
    ny2 = y2;

    A = [];
    for i=1:length(nx1);
        A(i,:) = [nx1(i)*nx2(i) nx1(i)*ny2(i) nx1(i) ny1(i)*nx2(i) ny1(i)*ny2(i) ny1(i) nx2(i) ny2(i) 1];
    end
    %get eigenvector associated with smallest eigenvalue of A' * A
    [u,d] = eigs(A' * A,1,'SM');
    F = reshape(u,3,3);

    %make F rank 2
    oldF = F;
    [U,D,V] = svd(F);
    D(3,3) = 0;
    F = U * D * V';

end
