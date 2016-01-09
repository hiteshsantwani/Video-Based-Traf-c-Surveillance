function  morphedgebseg(I)
Icro = I;
Ieqb = adapthisteq(Icro);           % enhances the contrast of the grayscale image I by transforming the values using contrast-limited adaptive histogram equalization (CLAHE).
bw = im2bw(Ieqb, graythresh(Ieqb)); % graythresh(I) computes a global threshold (level) that can be used to convert an intensity image to a binary image with im2bw. 

                                    %BW = im2bw(I, level) converts the grayscale image I to a binary image.

bw2 = imfill(bw,'holes');

                                    %fills holes in the binary image BW. A hole is a set of background pixels
                                    %that cannot be reached by filling in the background from the edge of the image.

bw3 = imopen(bw2, ones(5,5));
                                    %IM2 = imopen(IM,SE) performs morphological opening on the grayscale or
                                    %binary image IM with the structuring element SE. The argument SE must be a single structuring element object, as opposed to an array of objects. The morphological open operation is an erosion followed by a dilation, using the same structuring element for both operations.

bw4 = bwareaopen(bw3,50);

                                    %removes from a binary image all connected components (objects) that have
                                    %fewer than P pixels, producing another binary image, BW4.
bw5= bwperim(bw4);
                                    %returns a binary image containing only the perimeter pixels of objects in
                                    %the input image BW1
                                    
                                    %____

masem = imextendedmax(Ieqb, 30);
masem = imclose(masem, ones(5,5));
masem = imfill(masem, 'holes');
masem = bwareaopen(masem, 40);
copyimv = masem;
[a b] = size(copyimv);
for i = 1:a
    for j = 1:b
        if copyimv(i,j) == 0
            Icro(i,j) = copyimv(i,j);
        end
    end
end

%------------------------------------
%this part is for showing and writing image

figure(2),
imshow(Icro)
axis off
imwrite(Icro,'out2.jpg');
