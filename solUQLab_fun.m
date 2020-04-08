function [YPC, Q2] = solUQLab_fun(XCons,YCons,XTest,funName,myInput,method)

% this function is to get a PCE model with UQLab package
MetaOpts.ExpDesign.X = XCons;
MetaOpts.ExpDesign.Y = YCons;

MetaOpts.Type = 'Metamodel';
MetaOpts.MetaType = 'PCE';
MetaOpts.Degree = 1:5;
% MetaOpts.DegreeEarlyStop = 1;
MetaOpts.Method = method;
[~,myPCE] = evalc('uq_createModel(MetaOpts);');
YPC = uq_evalModel(myPCE,XTest);
Q2 = 1-myPCE.Error.ModifiedLOO; % determination coefficient from inner cross-validation
% coeff = myPCE.PCE.Coefficients; % PCE coefficients
