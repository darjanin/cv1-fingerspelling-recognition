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
        elseif count == 0
            if hand_raised(seg_img)
                letter = 'B'
            else
                letter = 'A'
            end
        end
    end
end