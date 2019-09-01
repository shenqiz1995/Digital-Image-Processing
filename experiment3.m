function varargout = experiment3(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @experiment3_OpeningFcn, ...
                   'gui_OutputFcn',  @experiment3_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function experiment3_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = experiment3_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function index_Callback(hObject, eventdata, handles)
close(experiment3);

function start_Callback(hObject, eventdata, handles)
%Original
image_original=rgb2gray(imread('dock.png'));
subplot(3,3,1);
imshow(image_original);
title('Original');
%Median filtering
image_median_filtered=medfilt2(image_original);
subplot(3,3,2);
imshow(image_median_filtered);
title('Median Filtering');
%Image Segmentation
threshold=calculate_threshold(image_median_filtered);
image_segmented=image_median_filtered;
image_segmented(image_segmented<=threshold)=0;
image_segmented(image_segmented>threshold)=255;
subplot(3,3,3);
imshow(image_segmented);
title('Image Segmentation');
%Dilation & Erosion
for r=1:3
    element=strel('disk',r,8);
    image_dilated=imdilate(image_segmented,element);
    subplot(3,3,3+r);
    imshow(image_dilated);
    title(sprintf('Dilation  r=%d',r));
    image_eroded=imerode(image_segmented,element);
    subplot(3,3,6+r);
    imshow(image_eroded);
    title(sprintf('Erosion  r=%d',r));
end
