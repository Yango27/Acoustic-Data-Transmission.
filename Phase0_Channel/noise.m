fs = 48000; %audio sample frequency
N = 4096;
T = 3; %time of recording

%% Recording and getting the data, here we want to measure the "silence" of our system
rec = audiorecorder(fs, 16, 1);
disp('Recording...')
recordblocking(rec, T);
disp('Done')
audio_noise = getaudiodata(rec);
audio_noise = audio_noise(round(0.2*fs)+1:end); % take the first 0.2 seconds out of the recording (may have unwanted noise in it)
[pw, f] = pwelch(audio_noise, N, N/2, N, fs); %calculate power spectral density 

%% Plotting
figure;
plot(f, 10*log10(pw));
xlabel('f (Hz)'), ylabel('PSD (dB/Hz)'), title('Noise, in frequency')
figure;
t = (0:length(audio_noise)-1)/fs + 0.2;
plot(t, audio_noise);
xlabel("time (s)"), ylabel("Amplitude"), title("Noise, in Time")
