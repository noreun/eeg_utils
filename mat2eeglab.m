% Simple Function to save a matlab matrix as an EEGLAB file
%
% data : [channels , time, trials]
% time : vector with time in seconds (to specify baseline if needed)
% fsample : sampling rate
% setname : the name of your data set
%
% This function is provided as is. It only works for some specific type of
% data. This is a simple function to help the developer and by no mean
% an all purpose function.
%
% adapted from EEGLAB
%
% https://sccn.ucsd.edu/svn/software/eeglab/functions/miscfunc/fieldtrip2eeglab.m
%
% Leonardo Barbosa - lsbarbosa@gmail.com
% 24-10-2014

function [EEG] = mat2eeglab(data, time, fsample, setname)

[ALLEEG EEG] = eeglab;

% load chanlocs.mat
% EEG.chanlocs = chanlocs;
EEG.chanlocs = [];

nchan = size(data,1);
ntime = size(data,2);
ntrials = size(data,3);

for i=1:ntrials
  EEG.data(:,:,i) = single(data(:,:,i));
end

EEG.setname    = setname;
EEG.filename   = '';
EEG.filepath   = '';
EEG.subject    = '';
EEG.group      = '';
EEG.condition  = '';
EEG.session    = [];
EEG.comments   = 'manually preprocessed in matlab';
EEG.nbchan     = nchan;
EEG.pnts       = ntime;
EEG.trials     = ntrials;
EEG.srate      = fsample;
EEG.xmin       = time(1);
EEG.xmax       = time(end);
EEG.times      = time;
EEG.ref        = []; %'common';

% try to export event information ?

EEG.event      = [];
EEG.epoch      = [];

% EEG.epoch(2)
% ans = 
%             event: [4 5 6]
%         eventtype: {'DIN2'  'DIN2'  ''}
%        eventvalue: {'trigger'  'trigger'  'trial'}
%      eventlatency: {[-4]  [256]  [952]}
%     eventduration: {[0]  [0]  [1448]}
% EEG.event(1)
% ans = 
%         type: 'DIN2'
%        value: 'trigger'
%      latency: 62
%     duration: 0
%        epoch: 1
%      urevent: 1

EEG.icawinv    = [];
EEG.icasphere  = [];
EEG.icaweights = [];
EEG.icaact     = [];
EEG.saved      = 'no';

[~, EEG] = eeg_store(ALLEEG, EEG);
% eeglab redraw
% pop_eegplot( EEG, 1, 1, 1);

 