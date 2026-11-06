fs = 48000; %sampling frequency
T = 5; %chirp duration

N = fs * T; %number of samples
tn = (0:N-1)/fs; 
tn = tn(:);

fo = 100; %initial frequency
f1 = 20000; %finish frequency
k = (f1-fo)/T;

%% DEFINING CHIRP, with this signal we will be able to test the frequency response of our mic and speakers
chirp_function = 0.5*sin(2*pi*(fo.*tn + (k/2).*tn.^2));

%applying ramp at the beggining and at the end to prevent high changes of
%amplitude at the beggining and the end (and abrupt start or end)

time_ramp = 0.01; %10ms of ramp
Nr = round(time_ramp*fs);
% 0->1...1->0
env = ones(N, 1);
ramp = 0:1/Nr:1-1/Nr;
env(1:Nr) = ramp;
env(N - Nr + 1: N) = fliplr(ramp);
env = env(:);

chirp_function = chirp_function.*env;

%% PLOTTING chirp

X  = fftshift(fft(chirp_function));
fc = (-N/2 : N/2-1).* fs/N; % -24 kHz ... +24 kHz

figure;
plot(fc, 10*log10(abs(X).^2)), grid on;
xlabel('f (Hz)'), ylabel('|X|^2 (dB)'), title('Chirp spectrum');

%% Using Chirp, testing 3 times...
rec = audiorecorder(fs, 16, 1);
player = audioplayer(chirp_function, fs); %plays the chirp

for i = 1:3
    display("Recording... Test " + i);
    record(rec);            
    playblocking(player);   
    pause(0.5); %waits for half a second before stopping...           
    stop(rec);
    display("Done Test " + i + "!");
    figure;
    rx = getaudiodata(rec);
    audiowrite("p0_chirp_rx_" + i + ".wav", rx, fs);
    R = fftshift(fft(rx)); %get the fft of the audio recorded
    fx = (-length(rx)/2 : length(rx)/2-1).* fs/length(rx); % -24 kHz ... +24 kHz
    plot(fx, 10*log10(abs(R).^2)), grid on; %plot so we can compare it to the original chirp
    xlabel('f (Hz)'), ylabel('|X|^2 (dB)'), title('Chirp through mic spectrum');
end