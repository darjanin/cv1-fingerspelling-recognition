function [seg_pic] = k_means(pic)
    he = pic;
    %figure, imshow(he); %Naèítanie obrázka
    cform = makecform('srgb2lab');
    lab_he = applycform(he,cform);
    %figure, imshow(lab_he);
    %Konvertovanie obrázka do L*a*b* priestoru kvôli lepšiemu rozlíšeniu dominantných farieb (biela, modrá, ružová)

    %Klasifikácia farieb L*a*b modelu pomocou zhlukovania K-means
    ab = double(lab_he(:,:,2:3));
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,2);
    nColors = 2;
    [cluster_idx,cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',3);

    %Rozdelenie pixlov obrázka pod¾a výskedkov K-means
    pixel_labels = reshape(cluster_idx,nrows,ncols);
    %figure, imshow(pixel_labels,[]), set(gca,'position',[0 0 1 1],'units','normalized')
    seg_pic = pixel_labels; %return result
end