fs = 48000; %sampling frequency
T = 5; %chirp duration

N = fs * T; %number of samples
tn = (0:N-1)/fs; 
tn = tn(:);

fo = 100;
f1 = 20000;
k = (f1-fo)/T;
chirp_function = 0.5*sin(2*pi*(fo.*tn + (k/2).*tn.^2));