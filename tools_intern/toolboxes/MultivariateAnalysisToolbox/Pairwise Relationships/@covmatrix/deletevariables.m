function cvm = deletevariables(cvm,to_remove)

% DELETEVARIABLES eliminate variables from a COVMATRIX instance.
% -------------------------------------
% cvm = deletevariables(cvm, to_remove)
% -------------------------------------
% Description: eliminate variables from a COVMATRIX instance. This function
%              works only when the row-variables are identical to the
%              column-variables.
% Input:       {cvm} COVMATRIX instance.
%              {to_remove} variables to delete. Can be either their
%                   indices, or their names (char-matrix or cell-vector).
% Output:      {cvm} updated COVMATRIX instance.

% � Liran Carmel
% Classification: Operators
% Last revision date: 08-Nov-2006

% parse input line
error(nargchk(2,2,nargin));
error(chkvar(cvm,{},'scalar',{mfilename,inputname(1),1}));
if ~isa(to_remove,'double')
    to_remove = colname2colidx(cvm,to_remove);
end

% delete variables from {cvm}
cvm.vvmatrix = deletevariables(cvm.vvmatrix,to_remove);
cvm.no_samples(:,to_remove) = [];
cvm.no_samples(to_remove,:) = [];
for ii = 1:length(cvm.p_value)
    pv = cvm.p_value{ii};
    pv(:,to_remove) = [];
    pv(to_remove,:) = [];
    cvm.p_value{ii} = pv;
end