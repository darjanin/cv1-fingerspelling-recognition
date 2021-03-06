function [seg_pic] = k_means(pic)
    % from http://stackoverflow.com/questions/20644498/hand-gesture-recognition-in-matlab

    %Read the image, and capture the dimensions
    img_orig = img;
    height = size(img_orig,1);
    width = size(img_orig,2);

    %Initialize the output images
    out = img_orig;
    bin = zeros(height,width);

    %Convert the image from RGB to YCbCr
    img_ycbcr = rgb2ycbcr(img_orig);
    Cb = img_ycbcr(:,:,2);
    Cr = img_ycbcr(:,:,3);

    %Detect Skin
    [r,c,v] = find(Cb>=77 & Cb<=127 & Cr>=133 & Cr<=173);
    % [r,c,v] = find(Cb>=76 & Cb<=130 & Cr>=129 & Cr<=175);
    numind = size(r,1);

    % Mark Skin Pixels
    for i=1:numind
        out(r(i),c(i),:) = [0 0 255];
        bin(r(i),c(i)) = 1;
    end
    % imshow(img_orig);
    % figure; imshow(out);
    % figure; imshow(bin);

    bin = bwareaopen(bin, 10000);

    figure; imshow(bin);

    se = strel('disk', 2);
    se2 = strel('disk', 1);

    img2 = imdilate(bin, se);
    % img2 = imerode(img2, se2);

    % img2 = bwareaopen(img2, 20000);
    figure; imshow(img2);
    seg_pic = img2; %return result
end