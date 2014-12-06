function result_img = segmentate(img)
    % This function reruns segmentated and cropped image.
    'sasd'
    img2 = k_means(img);
    
    % Cropping of image.
    [B, L, N] = bwboundaries(img2);

    s = regionprops(img2,'FilledImage');
    img2 = s.FilledImage;

    total = bwarea(img2);
    % disp(total);
    figure
    imshow(img2)
    % text(10,10,strcat('\color{green}Objects Found:',num2str(N),' \color{red}Area:',num2str(total)))
    % hold on

    % Return result
    result_img = img2;
end