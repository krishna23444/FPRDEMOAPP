function [ testIndices_inputTest, testIndices_outputTest ] = recognition( net, idx, FV_input, target, finger_label )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

testX = FV_input(:,idx);
testT = target(:,idx);

testY = net(testX);

testIndices_inputTest = vec2ind(testT);
testIndices_outputTest = vec2ind(testY);

end

