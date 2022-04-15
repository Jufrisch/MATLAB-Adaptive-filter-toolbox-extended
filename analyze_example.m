% Author: Justin Frisch
% Analyze predicting a signal that is 2x the frequency as the input
% Add Gaussian Mixture noise to desired signal
%% Generate input and desired signals.
clc;clear;close all;
%Creating 1000 samples of
fs = 10000; % sampling frequency
T = .1;% total recording time
L = T .* fs; % signal length
tt = (0:L-1)/fs; % time vector
freq = 1000; %1KHz
freq2 = freq*2;
out = sin(2*pi*freq2 .* tt); out = out(:); % reference sinusoid
in = sin(2*pi*freq .* tt); in = in(:); % input sinusoid
X = readDataStream(in,10);
d = out(11:end); % shift because model order 10

% Generate random variable obtained from gaussian mixture:
%   p(u) = 0.9G(0,0 . 1) + 0.1G(4,0 . 1)

%Generate the two Gaussian noise distributions
pd1 = makedist('Normal','mu',0,'sigma',0.1);
pd2 = makedist('Normal','mu',4,'sigma',0.1);

% Assigning the noises to d based on the probability of the two Gaussians
size = length(d);
p= 0.9+zeros(1,size);
r = binornd(1,p);
noiseP9 = random(pd1,1,L);
noiseP1 = random(pd2,1,L);
noise = zeros(size,1);
for ii = 1:length(r)
    if r(ii) == 1
        noise(ii) = noiseP1(ii);
    else
        noise(ii) = noiseP9(ii);
    end
end
%Storing orignal desired signal
desired = d;
%Adding the noise to the signal
d = d + noise;

%% Run algorithms
fprintf('training KLMS...')
klms = klms();
klms.train(1,1,X,d,10);

fprintf('training KMEE QIP...')
kmeeq = kmee_qip();
kmeeq.train(100,1,1,1,X,d,10);

%% Analyze Results
close all;

%KLMS results
klms.plotPred(1);
hold on
plot(desired)
hold off
xlim([900 950])
%Plot PDF of Error
klms.plotPdf(2);
%Plot Learning History
klms.plotVal(3)

%KMEEQ results
kmeeq.plotPred(4);
hold on
plot(desired)
hold off
xlim([900 950])

%Plot PDF of Error
kmeeq.plotPdf(5);

%Plot Learning History
kmeeq.plotVal(6);

%Plot Network Growth Rate
kmeeq.plotNet(7);


