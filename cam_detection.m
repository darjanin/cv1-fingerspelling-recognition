%
%
% PATHS FOR PROJECT NEED TO BE CONFIGURED
%
%
function varargout = cam_detection(varargin)
% cam_detection MATLAB code for cam_detection.fig
%      cam_detection, by itself, creates a new cam_detection or raises the existing
%      singleton*.
%
%      H = cam_detection returns the handle to a new cam_detection or the handle to
%      the existing singleton*.
%
%      cam_detection('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in cam_detection.M with the given input arguments.
%
%      cam_detection('Property','Value',...) creates a new cam_detection or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cam_detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cam_detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cam_detection

% Last Modified by GUIDE v2.5 11-Dec-2014 16:37:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cam_detection_OpeningFcn, ...
                   'gui_OutputFcn',  @cam_detection_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
path('lib/segmentation_method', path); % add lib folder to path
path('lib/recognition', path); % add lib folder to path

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before cam_detection is made visible.
function cam_detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cam_detection (see VARARGIN)
% Choose default command line output for cam_detection
handles.output = hObject;
%get webcam handle
handles.mycam = webcam(1);
%take first snapshots
handles.image1 = snapshot(handles.mycam);    
handles.image0 = snapshot(handles.mycam);    
%set global counter
handles.counter = 0;
%create timers
%autocapture timer
handles.timer = timer('Name','ExampleTimer',          ...
                       'Period',.5,                   ... 
                       'StartDelay',1,                 ... 
                       'TasksToExecute',inf,           ... 
                       'ExecutionMode','fixedSpacing', ...
                       'TimerFcn',{@timerCallback, handles, hObject}); 
%manualcapture timer
handles.timer2 = timer('Name','VideoTimer',          ...
                       'Period',.1,                   ... 
                       'StartDelay',1,                 ... 
                       'TasksToExecute',inf,           ... 
                       'ExecutionMode','fixedSpacing', ...
                       'TimerFcn',{@timer2Callback, handles, hObject});                   
% start the timer
% start(handles.timer);
start(handles.timer2);
% Update handles structure
guidata(hObject,handles);
% UIWAIT makes cam_detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);

 function timerCallback(hObj, eventdata, handles, hObject)
    % do stuff periodically
    %take snapshot
    img = snapshot(handles.mycam);
    %set img2 as persistent beetwen timer iterations
    persistent img2;
    persistent stillcounter;
    %initialize
    if isempty(stillcounter)
        stillcounter = 0;
    end
    if isempty(img2)
        img2 = handles.image1;
    end
    %convert 2 gray and resize
    %resizing filter a lot of camera noise
    Im1 = rgb2gray(img2);
    Im2 = rgb2gray(img);
    Im2 = imresize(Im2,0.5);
    Im1 = imresize(Im1,0.5);
    counter = 0;
    
    C = zeros(size(Im2));
    %get slider values
    distance = get(handles.slider1,'Value');
    move_cutoff = get(handles.slider2,'Value');
    % loop over all rows and columns
    for ii=1:size(Im2,1)
        for jj=1:size(Im2,2)
            % get pixel value
            pixel=Im2(ii,jj);
            pixel2 = Im1(ii,jj);
            % check pixel value and assign new value depending on pixel
            % color distance. WebCamera produces a lot of noise...
            if ((pixel<(pixel2+distance)) && ((pixel>(pixel2-distance))))
                new_pixel=0;
            else
                new_pixel=1;
            end
            % save new pixel value in thresholded image
            C(ii,jj)=new_pixel;
        end
    end
    %sum number of changed pixel between frames
    count = sum(sum(C));
    %f = sum((h1 - hn2).^2)
    [R S] = size(C);
    %get change in % between consecutive frames. If > than cutoff then
    %movement detected, esle image remained relatively still, increase
    %counter
    if(count/(R*S) > move_cutoff)
        set(handles.text1,'String','Movement')
        stillcounter = 0;
    else
        set(handles.text1,'String','Still')
        stillcounter = stillcounter +1;
    end  
    %if 5 consecutive images remained still (hand stopped moving), perform
    %detection
    if(stillcounter > 5)
        set(handles.text1,'String','capture')
        [L P] = recognize(im2double(img2));
        set(handles.recognized,'String',char(L));
        stillcounter = 0;
        %capture and process
    end
    %show captured image
    imshow(img, 'Parent', handles.axes1);
    handles.image0 = img;
    %save current as previous
    img2 = img;
    guidata(hObject,handles);

function timer2Callback(hObj, eventdata, handles, hObject)
   % do stuff periodically
   %take and show snapshot
   img = snapshot(handles.mycam);
   imshow(img, 'Parent', handles.axes1);
   handles.image0 = img;
   guidata(hObject,handles);
 
% --- Outputs from this function are returned to the command line.
function varargout = cam_detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in recognize_button.
function recognize_button_Callback(hObject, eventdata, handles)
% hObject    handle to recognize_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%take snapshot
img = snapshot(handles.mycam);
%show user that we are doing something
set(handles.text1,'String','Recognizing... Please WAIT')
%perform recognition
%WARNING - recognize not always returns expected output (namely when 
%recognition fails)
[L P] = recognize(im2double(img));
%show detected character
set(handles.recognized,'String',char(L));
set(handles.text1,'String','done')
%imshow(imabsdiff(img,handles.bcg), 'Parent', handles.axes1);

% --- Executes when user attempts to close figure1.
    function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%stop(handles.timer);
%clean workspace
delete(timerfind('Name','ExampleTimer'));
delete(timerfind('Name','VideoTimer'));
clear handles.timer;
clear handles.timer2;
clear handles.mycam;
delete(handles.mycam);
% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pd_num,'String',get(hObject,'Value'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',12);
guidata(hObject, handles);


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.mc_num,'String',get(hObject,'Value'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.15);
guidata(hObject, handles);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%change for autocapture to manualcapture and back
if(get(hObject,'Value'))
    out = timerfind('Name','ExampleTimer');
    out2 = timerfind('Name','VideoTimer');
    stop(out2);    
    start(out);    
    set(handles.recognize_button,'Enable','Off');
else
    out = timerfind('Name','ExampleTimer');
    out2 = timerfind('Name','VideoTimer');
    stop(out); 
    start(out2); 
    set(handles.text1,'String','')
    set(handles.recognize_button,'Enable','On');
end
% Hint: get(hObject,'Value') returns toggle state of checkbox1
