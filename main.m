function main

if isempty(getenv('SCA_SERVICE_DIR'))
    disp('setting SCA_SERVICE_DIR to pwd')
    setenv('SCA_SERVICE_DIR', pwd)
end

disp('loading application paths')
% TODO - move this to more permanent location - probably even /N/soft?
addpath(genpath('/N/u/hayashis/BigRed2/git/encode'))
addpath(genpath('/N/u/hayashis/BigRed2/git/vistasoft'))
addpath(genpath('/N/u/hayashis/BigRed2/git/mba'))
addpath(genpath('/N/u/hayashis/BigRed2/git/jsonlab'))
% addpath(genpath(getenv('SCA_SERVICE_DIR')))
addpath(genpath('/N/u/hayashis/Karst/testdata/demo_data_encode'))

config = loadjson('config.json');
disp(config)

disp('Running connectome_evaluator...')
[fh, out] = connectome_evaluator(config);

% all sca service needs to write products.json - empty for now
savejson('',     out, 'FileName', 'out.json');
savejson('w',    out.nnz,         'life_connectome_density.json');
savejson('rmse', out.rmse,        'life_error.json');
saveas(fh, 'figure1.png')

% TODO - generate output
savejson('',     {}, 'products.json');
system('echo 0 > finished');

