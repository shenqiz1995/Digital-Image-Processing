function varargout = experiment2(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @experiment2_OpeningFcn, ...
                   'gui_OutputFcn',  @experiment2_OutputFcn, ...
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

function experiment2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = experiment2_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function signal_T_Callback(hObject, eventdata, handles)

function signal_T_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function input_T_Callback(hObject, eventdata, handles)
global T;
T=str2double(get(hObject,'String'));
%disp(T);

function input_T_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function signal_a_Callback(hObject, eventdata, handles)

function signal_a_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function input_a_Callback(hObject, eventdata, handles)
global a;
a=str2double(get(hObject,'String'));
%disp(a);

function input_a_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function signal_b_Callback(hObject, eventdata, handles)

function signal_b_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function input_b_Callback(hObject, eventdata, handles)
global b;
b=str2double(get(hObject,'String'));
%disp(b);

function input_b_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function inverse_Callback(hObject, eventdata, handles)
%Original
image_original=imread('Lena.bmp');
subplot(3,3,1);
imshow(image_original);
title('Original');
%Degraded
global T;
global a;
global b;
[x,y]=size(image_original);
H=zeros(x,y);
j=sqrt(-1);
for u=1:x
    for v=1:y
        H(u,v)=T/(pi*(a*u+b*v))*sin(pi*(a*u+b*v))*exp(-pi*j*(a*u+b*v));
    end
end
image_original_dft=fft2(image_original);
image_degraded_dft=image_original_dft.*H;
image_degraded=real(ifft2(image_degraded_dft));
image_degraded=uint8(255.*mat2gray(image_degraded));
PSNR=calculate_PSNR(image_original,image_degraded);
subplot(3,3,2);
imshow(image_degraded);
title(sprintf('Degraded  PSNR=%.4fdB',PSNR));
%Inverse
r=[1,0.9,0.8,0.7,0.6,0.4,0.2];
for i=1:7
    image_restored=inverse_filter(r(i),x,y,H,image_degraded_dft);
    subplot(3,3,2+i);
    imshow(image_restored);
    PSNR=calculate_PSNR(image_original,image_restored);
    title(sprintf('r0=%.1f  PSNR=%.4fdB',r(i),PSNR));
end


function wiener_Callback(hObject, eventdata, handles)
%Original
image_original=imread('Lena.bmp');
subplot(3,3,1);
imshow(image_original);
title('Original');
%Degraded
global T;
global a;
global b;
[x,y]=size(image_original);
H=zeros(x,y);
j=sqrt(-1);
for u=1:x
    for v=1:y
        H(u,v)=T/(pi*(a*u+b*v))*sin(pi*(a*u+b*v))*exp(-pi*j*(a*u+b*v));
    end
end
image_original_dft=fft2(image_original);
image_degraded_dft=image_original_dft.*H;
image_degraded=real(ifft2(image_degraded_dft));
image_degraded=uint8(255.*mat2gray(image_degraded));
PSNR=calculate_PSNR(image_original,image_degraded);
subplot(3,3,2);
imshow(image_degraded);
title(sprintf('Degraded  PSNR=%.4fdB',PSNR));
%Wiener
K=[0,0.000001,0.00001,0.0001,0.001,0.01,0.1];
for i=1:7
    image_restored=wiener_filter(K(i),H,image_degraded_dft);
    subplot(3,3,2+i);
    imshow(image_restored);
    PSNR=calculate_PSNR(image_original,image_restored);
    title(sprintf('K=%f  PSNR=%.4fdB',K(i),PSNR)); 
end

% --- Executes on button press in index.
function index_Callback(hObject, eventdata, handles)
close(experiment2);
