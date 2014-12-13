function has_thumb = has_thumb( seg_img )
    %HAS_THUMB Detect if segmentated img has thumb raised
    
    %seg_img = seg_img(int32(end*0.05):int32(end*0.6), 1:end);
    
    height = size(seg_img, 1);
    width = size(seg_img, 2);
    
    %seg_img(1:end, int32(width*0.9):int32(width*0.91)) = 1;
    %seg_img(1:end, int32(width*0.8):int32(width*0.81)) = 1;
    %seg_img(1:end, int32(width*0.7):int32(width*0.71)) = 1;
    %seg_img(1:end, int32(width*0.6):int32(width*0.61)) = 1;
    %seg_img(1:end, int32(width*0.5):int32(width*0.51)) = 1;
    %seg_img(1:end, int32(width*0.4):int32(width*0.41)) = 1;
    %seg_img(1:end, int32(width*0.3):int32(width*0.31)) = 1;
    %seg_img(1:end, int32(width*0.2):int32(width*0.21)) = 1;
    %seg_img(1:end, int32(width*0.1):int32(width*0.11)) = 1;
    
    set1 = seg_img(int32(end*0.25):int32(end*0.65), int32(end*0.9):int32(end*0.9));
    
    %figure; imshow(seg_img);
    %figure; imshow(set1);
    
    %stat = regionprops(set1, 'Centroid','Area','PixelIdxList');
    %[maxValue,index] = max([stat.Area]);
    
    
    count = 0;
    total_areas = 0;
    good_areas = 0;
    
    percentage = 0;
    
    for i = 1:size(set1, 1)
        count =  count + set1(i, 1);
        
        if set1(i, 1) == 0
            percentage = count / size(set1, 1);
            count = 0;
            
            if (0.03 < percentage)
                total_areas = total_areas + 1;
                
                if (0.1 < percentage) && (0.35 > percentage)
                    good_areas = good_areas + 1;
                end
            end
        end
    end

    percentage = count / size(set1, 1);
    if (0.03 < percentage)
        total_areas = total_areas + 1;

        if (0.2 < percentage) && (0.35 > percentage)
            good_areas = good_areas + 1;
        end
    end
    
    % total_areas
    % good_areas

    if total_areas == 1 && good_areas == 1
        has_thumb = 1;
    else
        has_thumb = 0;
    end
    
    disp(['Has thumb: ',num2str(has_thumb)]);
end

