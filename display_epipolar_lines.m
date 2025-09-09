function display_epipolar_lines(F, v1_points_2d, v2_points_2d, v1_image, v2_image, part_title_text)

    colors =  'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';

    im1 = v1_image;
    im2 = v2_image;
    x1 = v1_points_2d(1, :)';
    y1 = v1_points_2d(2, :)';
    x2 = v2_points_2d(1, :)';
    y2 = v2_points_2d(2, :)';
    v1_points = [x1, y1, ones(length(x1), 1)]';
    v2_points = [x2, y2, ones(length(x2), 1)]';

    %overlay epipolar lines on im2
    L = F * v1_points;
    [nr,nc,~] = size(im2);
    figure; clf; imagesc(im2); axis image;
    hold on; plot(x2,y2,'*'); hold off;
    hold on; title(part_title_text+" on camera v2"); hold off;
    for i=1:size(L,2)
        a = L(1,i); b = L(2,i); c=L(3,i);
        if (abs(a) > (abs(b)))
           ylo = 1; yhi = nr; 
           xlo = (-b * ylo - c) / a;
           xhi = (-b * yhi - c) / a;
           hold on
           h=plot([xlo; xhi],[ylo; yhi], 'Color', colors(i), 'LineWidth', 2);
           hold off
        else
           xlo = 1; xhi = nc; 
           ylo = (-a * xlo - c) / b;
           yhi = (-a * xhi - c) / b;
           hold on
           h=plot([xlo; xhi],[ylo; yhi], 'Color', colors(i), 'LineWidth', 2);
           hold off
        end
       drawnow;
    end
    pause(1);


    %overlay epipolar lines on im1
    L = (v2_points' * F)' ;
    [nr,nc,~] = size(im1);
    figure; clf; imagesc(im1); axis image;
    hold on; plot(x1,y1,'*'); hold off;
    hold on; title(part_title_text+" on camera v1"); hold off;
    for i=1:size(L,2)
        a = L(1,i); b = L(2,i); c=L(3,i);
        if (abs(a) > (abs(b)))
           ylo=0; yhi=nr; 
           xlo = (-b * ylo - c) / a;
           xhi = (-b * yhi - c) / a;
           hold on
           h=plot([xlo; xhi],[ylo; yhi], 'Color',colors(i),'LineWidth',2);
           hold off
        else
           xlo=0; xhi=nc; 
           ylo = (-a * xlo - c) / b;
           yhi = (-a * xhi - c) / b;
           hold on
           h=plot([xlo; xhi],[ylo; yhi], 'Color',colors(i),'LineWidth',2);
           hold off
        end
       drawnow;
    end
    pause(1);

end
