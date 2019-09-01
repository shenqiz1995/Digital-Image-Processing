function varargout = experiment5(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @experiment5_OpeningFcn, ...
                   'gui_OutputFcn',  @experiment5_OutputFcn, ...
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

function experiment5_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = experiment5_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function single_q_Callback(hObject, eventdata, handles)  %个体识别结果
function single_q_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function all_Callback(hObject, eventdata, handles)       %集体预测
%% Setup the parameters you will use for this part of the exercise
input_layer_size  = 784;  % 28x28 Input Images of Digits
num_labels = 10;          % 5个数   
  
load('train_digit0');
load('train_digit1');
load('train_digit6');
load('train_digit7');
load('train_digit9'); 
train_digit0=train_digit0(1:1000,:);
train_digit1=train_digit1(1:1000,:);
train_digit6=train_digit6(1:1000,:);
train_digit7=train_digit7(1:1000,:);
train_digit9=train_digit9(1:1000,:);
X=[train_digit0;train_digit1;train_digit6;train_digit7;train_digit9];
X=mat2gray(X);
m = size(X, 1);%m个样本
y=zeros(m,1);
for i=1:m
    if(i>4000)
        y(i,1)=9;
    else if(i>3000)
            y(i,1)=7;
        else if(i>2000)
                y(i,1)=6;
            else if(i>1000)
                    y(i,1)=1;
                else 
                    y(i,1)=10;
                end
            end
        end
    end
end

lambda = 1;
[all_theta] = oneVsAll(X, y, num_labels, lambda);
load('test_digit.mat');
load('test_labels.mat');
for i=1:5110
    if(labels(i,1)==0)
        labels(i,1)=10;
    end
end

%预测结果
test_digit=mat2gray(test_digit);
result = predictOneVsAll(all_theta, test_digit);
save('result.mat','result');
Accuracy=mean(double(result == labels)) * 100;
accuracy_data=findobj('Tag','Accuracy');
set(accuracy_data,'string',sprintf('%f',Accuracy));

function single_Callback(hObject, eventdata, handles)    %个体预测
    load('test_digit.mat');
    load('result.mat');
    n = size(test_digit, 1);
    rp = randperm(n);
    sel=test_digit(rp(1), :)
    sel=uint8(sel);
    displayData(sel);
    pred = result(rp(1),1);
    fprintf('\nNeural Network Prediction: %d (digit %d)\n', pred, mod(pred, 10));
    hrecognize_data=findobj('Tag','single_q');
    set(hrecognize_data,'string',sprintf('%d',int8(pred)));

function Accuracy_Callback(hObject, eventdata, handles)  %集体预测准确率
function Accuracy_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)

function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function index_Callback(hObject, eventdata, handles)
close(experiment5);

function edit4_Callback(hObject, eventdata, handles)

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
