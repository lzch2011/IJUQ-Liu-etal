function [myModel,myInput]=configUQLab(funName)

if strcmpi(funName,'borehole')
    Model.mHandle = @borehole;
    IOpts.Marginals(1).Type = 'Gaussian';
    IOpts.Marginals(1).Parameters = [0.10, 0.0161812];
    IOpts.Marginals(1).Bounds = [0.05, 0.15];
    IOpts.Marginals(2).Type = 'Lognormal';
    IOpts.Marginals(2).Parameters = [7.71, 1.0056];
    IOpts.Marginals(2).Bounds = [100, 50000];
    IOpts.Marginals(3).Type = 'Uniform';
    IOpts.Marginals(3).Parameters = [63070, 115600];
    IOpts.Marginals(4).Type = 'Uniform';
    IOpts.Marginals(4).Parameters = [990, 1110];
    IOpts.Marginals(5).Type = 'Uniform';
    IOpts.Marginals(5).Parameters = [63.1, 116];
    IOpts.Marginals(6).Type = 'Uniform';
    IOpts.Marginals(6).Parameters = [700, 820];
    IOpts.Marginals(7).Type = 'Uniform';
    IOpts.Marginals(7).Parameters = [1120, 1680];
    IOpts.Marginals(8).Type = 'Uniform' ;
    IOpts.Marginals(8).Parameters = [9855, 12045];
elseif strcmpi(funName,'ishigami')
    Model.mHandle = @ishigami;
    for ii = 1 : 3
        IOpts.Marginals(ii).Type = 'Uniform';
        IOpts.Marginals(ii).Parameters = [-pi, pi];
    end
elseif strcmpi(funName,'sar')
    IOpts.Marginals(1).Type = 'Uniform';
    IOpts.Marginals(1).Parameters = [0.3, 3.7];
    IOpts.Marginals(2).Type = 'Uniform';
    IOpts.Marginals(2).Parameters = [0.3, 1110];
    IOpts.Marginals(3).Type = 'Uniform';
    IOpts.Marginals(3).Parameters = [63.1, 116];
    IOpts.Marginals(4).Type = 'Uniform';
    IOpts.Marginals(4).Parameters = [700, 820];
    IOpts.Marginals(5).Type = 'Uniform';
    IOpts.Marginals(5).Parameters = [1120, 1680];
    IOpts.Marginals(6).Type = 'Uniform' ;
    IOpts.Marginals(6).Parameters = [9855, 12045];
end

myModel = uq_createModel(Model);% create and add the model object to UQLab
myInput = uq_createInput(IOpts);