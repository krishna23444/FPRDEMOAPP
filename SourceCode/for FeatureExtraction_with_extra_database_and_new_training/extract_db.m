% Extracts and stores the features of a fingerprint database.
% Currently, the extraction is tuned for the FVC2002 DB1 database.  
% % % % %
clc; clear;

% % Change directory name--as per database sellection
files = dir('DB1_B/*.tif');
cd  'DB1_B';
addpath('../sc_minutia');


IMPRESSIONS_PER_FINGER=8;
file_names = {files.name};
[ START, FINISH ] = size(file_names);

 FINISH = 2;
index1 = START;
FV = []; cnt2 = 1; finger_label = {};

while cnt2 <= FINISH
    
    fileName = file_names{cnt2};
    finger_features = extract_finger_new(fileName);   

    FV = cat(1,FV,finger_features);
    finger_label{cnt2} = { fileName };
    cnt2 = cnt2 + 1;
    [~,c_FV] = size(FV);
    
end

[r_fv, c_fv] = size(FV);

%% target matrix generation
sample = 8;cnt_target=0;
r_target = r_fv/sample;
target = zeros(r_target,r_fv);
% [r_target, ~ ] = size(target);
for i=1:r_target
    target(i,cnt_target+1:cnt_target+sample) = 1; 
    cnt_target = cnt_target + sample;
end
