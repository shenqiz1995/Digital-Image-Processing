function varargout = experiment4(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @experiment4_OpeningFcn, ...
                   'gui_OutputFcn',  @experiment4_OutputFcn, ...
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

function experiment4_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = experiment4_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function index_Callback(hObject, eventdata, handles)
close(experiment4);

function noise1_Callback(hObject, eventdata, handles)
%Original
image_original=rgb2gray(imread('houghorg.bmp'));
subplot(3,3,2);
imshow(image_original);
title('Original');
%Gaussian Noise
image_noise1=imnoise(image_original,'gaussian',0,0.2);
subplot(3,3,3);
imshow(image_noise1);
title('Gaussian Noise');
%Edge
image_median_filtered=medfilt2(image_noise1,[9 9]);
image_median_filtered(image_median_filtered<=127)=0;
image_median_filtered(image_median_filtered>=128)=255;
image_edge1=edge(image_median_filtered,'roberts');
subplot(3,3,4);
imshow(image_edge1);
title('Edge  roberts');
image_edge2=edge(image_median_filtered,'sobel');
subplot(3,3,5);
imshow(image_edge2);
title('Edge  sobel');
image_edge3=edge(image_median_filtered,'log');
subplot(3,3,6);
imshow(image_edge3);
title('Edge  log');
%Restore
[center,radius]=restore_image(image_edge1);
subplot(3,3,7);
imshow(image_noise1);
viscircles(center,radius);
title('Restore  roberts');
[center,radius]=restore_image(image_edge2);
subplot(3,3,8);
imshow(image_noise1);
viscircles(center,radius);
title('Restore  sobel');
[center,radius]=restore_image(image_edge3);
subplot(3,3,9);
imshow(image_noise1);
viscircles(center,radius);
title('Restore  log');

function noise2_Callback(hObject, eventdata, handles)
%Original
image_original=rgb2gray(imread('houghorg.bmp'));
subplot(3,3,2);
imshow(image_original);
title('Original');
%Salt & Pepper Noise
image_noise2=imnoise(image_original,'salt & pepper',0.2);
subplot(3,3,3);
imshow(image_noise2);
title('Salt & Pepper Noise');
%Edge
image_median_filtered=medfilt2(image_noise2,[9 9]);
image_median_filtered(image_median_filtered<=127)=0;
image_median_filtered(image_median_filtered>=128)=255;
image_edge1=edge(image_median_filtered,'roberts');
subplot(3,3,4);
imshow(image_edge1);
title('Edge  roberts');
image_edge2=edge(image_median_filtered,'sobel');
subplot(3,3,5);
imshow(image_edge2);
title('Edge  sobel');
image_edge3=edge(image_median_filtered,'log');
subplot(3,3,6);
imshow(image_edge3);
title('Edge  log');
%Restore
[center,radius]=restore_image(image_edge1);
subplot(3,3,7);
imshow(image_noise2);
viscircles(center,radius);
title('Restore  roberts');
[center,radius]=restore_image(image_edge2);
subplot(3,3,8);
imshow(image_noise2);
viscircles(center,radius);
title('Restore  sobel');
[center,radius]=restore_image(image_edge3);
subplot(3,3,9);
imshow(image_noise2);
viscircles(center,radius);
title('Restore  log');
