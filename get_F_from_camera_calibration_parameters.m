function F = get_F_from_camera_calibration_parameters(v1_Rmat, v2_Rmat, v1_Kmat, v2_Kmat, v1_position, v2_position)

    % Relative rotation and translation of camera 2, respect to camera 1 (camera 1 is primary camera)
    relative_Rmat = v2_Rmat * v1_Rmat';
    relative_position = v1_Rmat * (v2_position - v1_position);

    % Get the matrix about nullspace from Lecture 17 - P 12, for spinning camera correctly
    relative_spin = [   0                   , -relative_position(3),  relative_position(2);
                        relative_position(3), 0                    , -relative_position(1);
                      - relative_position(2),  relative_position(1), 0                    ];

    % Essential matrix
    E = relative_Rmat * relative_spin;

    % Fundamental matrix
    % From lecture, Fundamental matrix F = K_{right}^{-T} R S K_{left}^{-1}
    F = inv(v2_Kmat') * E * inv(v1_Kmat);

end
