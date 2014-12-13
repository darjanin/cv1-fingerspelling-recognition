function [img_seg] = k_means(img)
    cform = makecform('srgb2lab');
    lab_he = applycform(img, cform);

    % Klasifikacia farieb L*a*b modelu pomocou zhlukovania K-means
    ab = double(lab_he(:,:,2:3));
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,2);
    n_colors = 2;
    cluster_idx = kmeans(ab,n_colors,'distance','sqEuclidean','Replicates',3);

    % Rozdelenie pixlov obrazka podla vyskedkov K-means
    pixel_labels = reshape(cluster_idx,nrows,ncols);
    
    % Opening a closing na vysegmentovanom obrazku
    
    % Structural element
    se = strel('disk',25);
    
    %opening by reconstruction
    img_erode = imerode(pixel_labels, se);
    img_obr = imreconstruct(img_erode, pixel_labels);
    
    % closing by reconstruction
    img_obrd = imdilate(img_obr, se);
    img_obrcbr = imreconstruct(imcomplement(img_obrd),imcomplement(img_obr));
    
    % return segmentated result
    img_seg = imcomplement(img_obrcbr);

end