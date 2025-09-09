% part 9: extra credit 2: Generate a top-down view of the floor plane


%read source image

source = imread('im1corrected.jpg');
%source = imread('bldg4.jpg');
%source = imread('bldg3.jpg');
[nr,nc,nb] = size(source);

%make new image
% dest = zeros(200,300,nb);
dest = zeros(nr, nc, nb);

% % not needed 
% % click four points in source
% figure(1); colormap(gray); clf;
% imagesc(source);
% axis image
% [xpts,ypts] = ginput(4);

% pre-set points for image1
% xpts = [408; 1052; 1602; 1004];
% ypts = [710; 952;  734;  614 ];
xpts = [1052; 1602; 1004; 408];
ypts = [952;  734;  614 ; 710];
% xpts = [1602; 1004; 408; 1052];
% ypts = [734;  614 ; 710; 952 ];
% xpts = [1004; 408; 1052; 1602];
% ypts = [614 ; 710; 952;  734 ];

% % use setted rectangle directly
% % input rectangle in destination image
% figure(2); colormap(gray); clf;
% imagesc(dest);
% axis image
% rect = getrect;
% xp1 = rect(1);
% yp1 = rect(2);
% xp2 = xp1+rect(3);
% yp2 = yp1+rect(4);


% display the points in original graph
figure; clf;
imshow(source);
hold on;
plot(xpts, ypts, 'ro', 'MarkerSize', 10, 'LineWidth', 2); % Plot points
for i = 1:length(xpts)
    text(xpts(i), ypts(i), sprintf(' %d', i), 'Color', 'yellow', 'FontSize', 12, 'FontWeight', 'bold');
end
hold off;
title("Plotted points on the original graph.");
pause(1);


% Define destination rectangle for the top-down view directly
xp1 = 100; yp1 = 100;
xp2 = 1000; yp2 = 1000;


xprimes = [xp1 xp2 xp2 xp1]';
yprimes = [yp1 yp1 yp2 yp2]';

%compute homography (from im2 to im1 coord system)
p1 = xpts; p2 = ypts;
p3 = xprimes; p4 = yprimes;
vec1 = ones(size(p1,1),1);
vec0 = zeros(size(p1,1),1);
Amat = [p3 p4 vec1 vec0 vec0 vec0 -p1.*p3 -p1.*p4; vec0 vec0 vec0 p3 p4 vec1 -p2.*p3 -p2.*p4];
bvec = [p1; p2];
h = Amat \ bvec;
fprintf(1,'Homography:');
fprintf(1,' %.2f',h); fprintf(1,'\n');

%warp im1 forward into im2 coord system 
[xx,yy] = meshgrid(1:size(dest,2), 1:size(dest,1));
denom = h(7)*xx + h(8)*yy + 1;
hxintrp = (h(1)*xx + h(2)*yy + h(3)) ./ denom;
hyintrp = (h(4)*xx + h(5)*yy + h(6)) ./ denom;
for b = 1:nb
 dest(:,:,b) = interp2(double(source(:,:,b)),hxintrp,hyintrp,'linear')/255.0;
end

%display result
figure(1); colormap(gray); clf;
imagesc(dest);
axis image;
title('Automated Top-Down View of the Floor Plane');

