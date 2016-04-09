% clc; clear;

%% Paths
% addpath('/home/shivangpatel/Desktop/2015_Dec_fingerprintRecognition/code_example/sc_minutia/sc_minutia');

%% load data...
% files = dir('/home/shivangpatel/Desktop/2015_Dec_fingerprintRecognition/Database/FVC2002/DB1_B/*.tif');
% cd  '/home/shivangpatel/Desktop/2015_Dec_fingerprintRecognition/Database/FVC2002/DB1_B';



%% Classification/Prediction
% input matrix --> columan describe number of fingerprint, row presonting
% elements/features of each fingerprint
FV_input = FV';
% [r_input, c_input] = size(FV_input);

% ANN creation
setdemorandstream(391418381);

% trainFcn = 'trainrp';
trainFcn = 'trainscg';
% trainFcn = 'trainlm';

net = patternnet(19,trainFcn);
net = configure(net, FV_input, target);
net = init(net);
net.trainParam.epochs = 1000;
net.trainParam.goal = 0.01;
net.trainParam.max_fail = 500;

[net,tr] = train(net,FV_input,target);  % train network
% y1 = net(FV_input);
% plot(FV_input,target,'o',FV_input,y1,'*')

% % testX = FV_input(:,tr.testInd);
% % testT = target(:,tr.testInd);
testX = FV_input;
testT = target;

testY = net(testX);

testIndices_inputTest = vec2ind(testT);
testIndices_outputTest = vec2ind(testY);
% plotconfusion(testT,testY)

[c,cm] = confusion(testT,testY);

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);

%% Extract Resutltent image
[~, c_testIndices_inputTest] = size(testIndices_inputTest);
[~, c_testIndices_outputTest] = size(testIndices_outputTest);

for i=1:c_testIndices_inputTest
    img_input{i} = finger_label{tr.testInd(testIndices_inputTest(i))};
    img_output{i} = finger_label{tr.testInd(testIndices_outputTest(i))};
end




