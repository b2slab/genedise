% need to be in ~/mashup
addpath code

%% Required external dependencies: see README.txt for more information
%addpath /home/sergi/libsvm-3.22/matlab % LIBSVM package (for cross_validation.m)
%addpath /path-to-lbfgs-package % L-BFGS package (only if svd_approx = false)

%% Example parameters
org = 'human';      % use human or yeast data
%onttype = 'level1'; % which type of annotations to use
                    %   options: {bp, mf, cc} for human GO,
                    %            {level1, level2, level3} for yeast MIPS
%ontsize = [];       % consider terms in a specific size range (*human GO only*)
                    %   examples: [11 30], [31 100], [101 300]
%nperm = 5;          % number of cross-validation trials
svd_approx = true;  % use SVD approximation for Mashup
                    %   recommended: true for human, false for yeast
ndim = 800;         % number of dimensions
                    %   recommended: 800 for human, 500 for yeast

%% Construct network file paths
string_nets = {'experiments', 'database'};
network_files = cell(1, length(string_nets));
for i = 1:length(string_nets)
  network_files{i} = sprintf('data/string10/test_mashup_%s.txt', ...
                             string_nets{i});
end

%% Load gene list
gene_file = 'data/string10/node_names.txt';
genes = textread(gene_file, '%s');
ngene = length(genes);

%% Mashup integration
fprintf('[Mashup]\n');
x = mashup(network_files, ngene, ndim, svd_approx);

%% Write matrix
csvwrite('string10_features.csv', x)
