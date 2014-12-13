function [letter, percentage] = recognize(img)
   % this function will call al other recognition and segmentation on image
   % that will be passed by argument img
   
   % function will return
   % letter ... letter that is recognized
   % percentage ... number of percent that we are sure it's that letter
   %                this number will return if we think it's possible to
   %                get

   close all;
   disp('--------------------------------------');
   seg_img = segmentate(img);
   [letter, percentage] = hand_gesture(seg_img);   
end