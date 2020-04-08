% This code is for the double cross-validation in IJUQ paper
% "Surrogate modeling of indoor down-link human exposure based on sparse
% polynomial chaos expansion" by Liu, et al.
% The Matlab-based software UQLab (https://www.uqlab.com) is downloaded and installed in advance
% Date of release: April 8, 2020
% The code is only for academic researches.

clear all;
close all;

clearvars % uqlab command
uqlab

nTrial = 20; % number of Monte Carlo simulations
vec_nTrain = 10:10:70;  % number of training data
funName = 'ishigami'; 
[myModel,myInput] = configUQLab(funName); % true model

nTest = 1e4; % number of testing data
XTest = uq_getSample(nTest,'LHS'); % generate input data by Latin hypercube sampling method
YTest = uq_evalModel(myModel,XTest); % compute corresponding output

matR2 = zeros(nTrial,length(vec_nTrain));  % determination coefficient from independent tests
matDCVQ2 = zeros(nTrial,length(vec_nTrain)); % determination coefficient from double cross-validation
matQ2 = zeros(nTrial,length(vec_nTrain)); % determination coefficient from inner cross-validation
for i_nTrain = 1:length(vec_nTrain)
    nTrain = vec_nTrain(i_nTrain);
    
    for iTrial = 1:nTrial
        fprintf('Running nTrain = %d, the %d-th trial\n', nTrain, iTrial)
        
        % generate data for training
        XTrain = uq_getSample(nTrain,'LHS');
        YTrain = uq_evalModel(myModel,XTrain);
        
        % surrogate modeling and predict testing data
        [YPred,matQ2(iTrial,i_nTrain)]=solUQLab_fun(XTrain,YTrain,XTest,funName,myInput,'LARS');  % methods available 'LARS','OMP'
        matR2(iTrial,i_nTrain) = 1-sum((YPred-YTest).^2)/var(YTest)/length(YTest);
        
        % double cross validation
        YPCE = zeros(nTrain,1);
        for iSample = 1:nTrain
            XVal = XTrain(iSample,:); % data left out for validation
            YVal = YTrain(iSample);
            idCons = setdiff(1:nTrain,iSample);
            XCons = XTrain(idCons,:); % remaining data for training
            YCons = YTrain(idCons);
            YPCE(iSample) = solUQLab_fun(XCons,YCons,XVal,funName,myInput,'LARS');
        end
        matDCVQ2(iTrial,i_nTrain) = 1-sum((YPCE-YTrain).^2)/var(YTrain)/nTrain;
    end
end
figure
plot(vec_nTrain,mean(matR2))
hold on;
plot(vec_nTrain,mean(matDCVQ2))
plot(vec_nTrain,mean(matQ2))
legend('R2','DCV','ICV')




