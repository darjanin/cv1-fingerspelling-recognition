function [letter, percentage] = recognize(img)
    'reckogasdfads'
   % this function will call al other recognition and segmentation on image
   % that will be passed by argument img
   % in this file can be more functions or they will be splitted in other
   % files
   
   % function will return
   % letter ... letter that is recognized
   % percentage ... number of percent that we are sure it's that letter
   %                this number will return if we think it's possible to
   %                get
   
   
   % following code is just for testing, it should be replaced
   % imshow(img);
   letters = {'a','b','i','l','v','w','y'};
   
   % for testing replace it with function code
   seg_img = segmentate(img);
   letter, percentage = hand_gesture(seg_img);   

   % letter = char(letters(randi(7))); % return letter
   % percentage = 100; % return percentage
end