function [letter, percentage] = recognize(img)
   % this function will call al other recognition and segmentation on image
   % that will be passed by argument img
   % in this file can be more functions or they will be splitted in other
   % files
   
   % function will return
   % letter ... letter that is recognized
   % percentage ... number of percent that we are sure it's that letter
   %                this number will return if we think it's possible to
   %                get
   
   
   letters = {'a','b','i','l','v','w','y'};
   
   
   letter = char(letters(randi(7))); % return letter
   percentage = 100; % return percentage

end