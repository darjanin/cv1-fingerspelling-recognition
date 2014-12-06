function [detected_letter, percentage] = hand_gesture(seg_img)
    % This function uses segmentated image to find letter
    % updated dimensions after crop
    if has_thumb(seg_img)
        detected_letter = 'X'
        percentage = 100
    else
        detected_letter = 's'
        percentage = 100;
    end
        
    
    
    figure; imshow(seg_img);
    % total = bwarea(img2);
    
    % height = size(img2, 1);
    % width = size(img2, 2);

    % disp(strcat(num2str((total / (height*width)) * 100), '%'));

    % img3 = zeros(size(img2));
    % img3(1:100, 1:width) = img2(1:100, 1:width);

    % [B, L, N] = bwboundaries(img3);
    %figure
    % imshow(img3)
    % disp(strcat('Objects Found:',num2str(N)));
end