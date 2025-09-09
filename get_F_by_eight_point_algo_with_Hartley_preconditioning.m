function F = get_F_by_eight_point_algo_with_Hartley_preconditioning(v1_points_2d, v2_points_2d)

    x1 = v1_points_2d(1,:)';
    y1 = v1_points_2d(2,:)';
    x2 = v2_points_2d(1,:)';
    y2 = v2_points_2d(2,:)';

    %do Hartley preconditioning
    mux = mean(x1);
    muy = mean(y1);
    stdxy = (std(x1)+std(y1))/2;
    T1 = [1 0 -mux; 0 1 -muy; 0 0 stdxy]/stdxy;
    nx1 = (x1-mux)/stdxy;
    ny1 = (y1-muy)/stdxy;
    mux = mean(x2);
    muy = mean(y2);
    stdxy = (std(x2)+std(y2))/2;
    T2 = [1 0 -mux; 0 1 -muy; 0 0 stdxy]/stdxy;
    nx2 = (x2-mux)/stdxy;
    ny2 = (y2-muy)/stdxy;

    A = [];
    for i=1:length(nx1);
        A(i,:) = [nx1(i)*nx2(i) nx1(i)*ny2(i) nx1(i) ny1(i)*nx2(i) ny1(i)*ny2(i) ny1(i) nx2(i) ny2(i) 1];
    end
    %get eigenvector associated with smallest eigenvalue of A' * A
    [u,d] = eigs(A' * A,1,'SM');
    F_normalized = reshape(u,3,3);

    %make F rank 2
    oldF = F_normalized;
    [U,D,V] = svd(F_normalized);
    D(3,3) = 0;
    F_unnormalized = U * D * V';

    %unnormalize F to undo the effects of Hartley preconditioning
    F = T2' * F_unnormalized * T1;

end
