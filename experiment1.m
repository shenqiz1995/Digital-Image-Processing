function varargout = experiment1(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @experiment1_OpeningFcn, ...
                   'gui_OutputFcn',  @experiment1_OutputFcn, ...
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

function experiment1_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = experiment1_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function listbox1_Callback(hObject, eventdata, handles)

function listbox1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu1_Callback(hObject, eventdata, handles)

function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function DFT_Callback(hObject, eventdata, handles)
%Original
figure=imread('Lena.bmp');
subplot(1,3,1);
imshow(figure);
title('Original');
%DFT
dft_result=fftshift(fft2(figure));
dft_amplitude=abs(dft_result);
dft_norm=(dft_amplitude-min(min(dft_amplitude)))/(max(max(dft_amplitude))-min(min(dft_amplitude)))*255;
subplot(1,3,2);
imshow(dft_norm);
title('DFT');
%IDFT
size_figure=size(figure);
height=size_figure(1);
width=size_figure(2);
dft_sorted=sort(reshape(dft_amplitude,[1,width*height]));
threshold=dft_sorted(round(width*height*0.95));
for a=1:height
    for b=1:width
        if dft_amplitude(a,b)<=threshold
            dft_polluted(a,b)=0;
        else
            dft_polluted(a,b)=dft_result(a,b);
        end
    end
end
figure_restored=ifft2(ifftshift(dft_polluted))/256;
subplot(1,3,3);
imshow(figure_restored);
title('IDFT');
%PSNR
PSNR=calculate_PSNR(figure,256*figure_restored);
set(handles.edit3,'string',PSNR);

function DCT_Callback(hObject, eventdata, handles)
%Original
figure=imread('Lena.bmp');
subplot(1,3,1);
imshow(figure);
title('Original');
%DCT
dct_result=dct2(figure);
dct_amplitude=abs(dct_result);
dct_norm=(dct_amplitude-min(min(dct_amplitude)))/(max(max(dct_amplitude))-min(min(dct_amplitude)))*255;
subplot(1,3,2);
imshow(dct_norm);
%imshow(dct_amplitude,[0 255]);
title('DCT');
%IDCT
size_figure=size(figure);
height=size_figure(1);
width=size_figure(2);
dct_sorted=sort(reshape(dct_amplitude,[1,width*height]));
threshold=dct_sorted(round(width*height*0.95));
for a=1:height
    for b=1:width
        if dct_amplitude(a,b)<=threshold
            dct_polluted(a,b)=0;
        else
            dct_polluted(a,b)=dct_result(a,b);
        end
    end
end
figure_restored=idct2(dct_polluted)/256;
subplot(1,3,3);
imshow(figure_restored);
title('IDCT');
%PSNR
PSNR=calculate_PSNR(figure,256*figure_restored);
set(handles.edit3,'string',PSNR);


function DHT_Callback(hObject, eventdata, handles)
%Original
figure=imread('Lena.bmp');
subplot(1,3,1);
imshow(figure);
title('Original');
%DHT
H=hadamard(256);
figure=double(figure);
dht_result=H*figure*H/256;
dht_amplitude=abs(dht_result);
dht_norm=(dht_amplitude-min(min(dht_amplitude)))/(max(max(dht_amplitude))-min(min(dht_amplitude)))*255;
subplot(1,3,2);
imshow(dht_norm);
title('DHT');
%IDHT
size_figure=size(figure);
height=size_figure(1);
width=size_figure(2);
dht_sorted=sort(reshape(dht_amplitude,[1,width*height]));
threshold=dht_sorted(round(width*height*0.95));
for a=1:height
    for b=1:width
        if dht_amplitude(a,b)<=threshold
            dht_polluted(a,b)=0;
        else
            dht_polluted(a,b)=dht_result(a,b);
        end
    end
end
figure_restored=H*dht_polluted*H/256/256;
subplot(1,3,3);
imshow(figure_restored);
title('IDCT');
%PSNR
PSNR=calculate_PSNR(figure,256*figure_restored);
set(handles.edit3,'string',PSNR);

function Index_Callback(hObject, eventdata, handles)
close(experiment1);

function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)

function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
