function feature = feature_bool_handLeftSideways(mot,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tests if left wrist is located to the left of a test plane orthogonal to the lshoulder-rshoulder line
%
% Feature value 0: Hand not sideways.
% Feature value 1: Hand sideways.
%
% Parameters:
% shoulder_offset .... default value of -1 corresponds to placement of test plane at one shoulder width left of lshoulder

if (nargin<=1)
    shoulder_offset = -0.4;
else
    shoulder_offset = varargin{1};
end

shoulder_width = sqrt(sum((mot.jointTrajectories{trajectoryID(mot,'lshoulder')}(:,1) - mot.jointTrajectories{trajectoryID(mot,'rshoulder')}(:,1)).^2));

feature = feature_distPointNormalPlane(mot,'rshoulder','lshoulder','lshoulder','lwrist') + shoulder_offset * shoulder_width;
feature = (feature >= 0);