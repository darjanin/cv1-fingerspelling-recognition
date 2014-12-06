function [letter, percentage] = hand_gesture(seg_img)
    % This function uses segmentated image to find letter
    % updated dimensions after crop
    percentage = 100;
    letter = '.'
    
    if has_thumb(seg_img)
        if has_little_finger(seg_img)
            letter = 'Y'
        else
            letter = 'L'
        end
    else
        count = count_fingers(seg_img)
        
        if count == 1
            letter = 'I'
        elseif count == 2
            letter = 'V'
        elseif count == 3
            letter = 'W'
        elseif count == 4
            letter = '.'
    end
    
    % total = bwarea(img2);
    

    % disp(strcat(num2str((total / (height*width)) * 100), '%'));

    % img3 = zeros(size(img2));
    % img3(1:100, 1:width) = img2(1:100, 1:width);

    % [B, L, N] = bwboundaries(img3);
    %figure
    % imshow(img3)
    % disp(strcat('Objects Found:',num2str(N)));
end