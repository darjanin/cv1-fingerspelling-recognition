function raised_hand = hand_raised( seg_img )
    %Checks whether hand is raised
    
    height = size(seg_img, 1);
    width = size(seg_img, 2);

     if width/height > 57
        raised_hand = 1
     else
         raised_hand = 0
     end
end

