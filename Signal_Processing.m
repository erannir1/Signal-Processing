close all; clear; clc;
%q1 stability
A = [1 -4 4];
B = [20 10];
n = linspace(0,100,10000);
x1 = zeros(1,10000);
x1 = x1+3;
y1 = filter(B, A, x1);
figure; 
plot(n, x1); xlabel('n'); ylabel('x[n]'); title('input');
figure;
plot(n, y1); xlabel('n'); ylabel('y[n]'); title('output');
%%
%q2A
h = [h2; h3; h4; h6];
for i=1:4
    H = abs(fftshift(fft([h(i,1:end) zeros(1, 1000)])));
    w = linspace(-pi,pi,1080);
    figure;hold on; plot(w,H);
    set(gca,'XTick',[-pi -pi/2 -pi/3 -pi/4 -pi/6 0 pi/6 pi/4 pi/3 pi/2 pi]);
    set(gca,'XTickLabel',{'-\pi', '-\pi/2', '-\pi/3', '-\pi/4', '-\pi/6', '0', '\pi/6', '\pi/4', '\pi/3', '\pi/2', '\pi'});
    xlabel('w[rad/sec]')
    ylabel('|H(w)|');
    switch i
        case 1
            title('h2');
        case 2
            title('h3');
        case 3
            title('h4');
        case 4
            title('h6');
    end
end

%%
%q2B2
n = linspace(-10000,10000,20000);
x = zeros(1,length(n));
for i =1:length(n)
    x(1,i) = cos(((2*pi)/5)*i)+cos((pi/5)*i);
end
X_jw = abs(fftshift(fft(x)));
w = linspace(-pi,pi,20000);
figure; plot(w,X_jw); xlabel('frequncy'); ylabel('|X(e^j^w)|');title('X(e^j^w)');
set(gca,'XTick',[-pi -pi/2 -pi/3 -pi/4 -pi/6 0 pi/6 pi/4 pi/3 pi/2 pi]);
set(gca,'XTickLabel',{'-\pi', '-\pi/2', '-\pi/3', '-\pi/4', '-\pi/6', '0', '\pi/6', '\pi/4', '\pi/3', '\pi/2', '\pi'});

%%
H2 = fftshift(fft([h2 zeros(1, 19920)]));
H3 = fftshift(fft([h3 zeros(1, 19920)]));
H4 = fftshift(fft([h4 zeros(1, 19920)]));
H6 = fftshift(fft([h6 zeros(1, 19920)]));
w = linspace(-pi,pi,20000);
for i = 1:4
    switch i
        case 1
            H = H2;
        case 2
            H = H3;
        case 3
            H = H4;
        case 4
            H = H6;
    end
    Y_jw = H.*X_jw;
    figure; plot(w, abs(Y_jw));xlabel('frequncy'); ylabel('|Y(e^j^w)|');title('Y(e^j^w)');
    set(gca,'XTick',[-pi -pi/2 -pi/3 -pi/4 -pi/6 0 pi/6 pi/4 pi/3 pi/2 pi]);
    set(gca,'XTickLabel',{'-\pi', '-\pi/2', '-\pi/3', '-\pi/4', '-\pi/6', '0', '\pi/6', '\pi/4', '\pi/3', '\pi/2', '\pi'});
    switch i
        case 1
            title('Y2(e^j^w)');
        case 2
            title('Y3(e^j^w)');
        case 3
            title('Y4(e^j^w)');
        case 4
            title('Y6(e^j^w)');
    end
    y = ifft(ifftshift(Y_jw));
    figure; plot(n, y);hold on; plot(n,x); legend('y[n]', 'x[n]');xlabel('n'); ylabel('signal'); xlim([-20 20]);
    switch i
        case 1
            title('y2 and x');
        case 2
            title('y3 and x');
        case 3
            title('y4 and x');
        case 4
            title('y6 and x');
    end    
end
%%
%Q3
t = linspace(-10000,10000,20000);
x1 = sinc(t/6);
x2 = (sinc(t/12)).^2;
x3 = cos(pi*t/12);
x4 = cos(pi*t/12) + sin(pi*t/6);
w = linspace(-pi,pi,20000);
X_jw1 = fftshift(fft(x1));
X_jw2 = fftshift(fft(x2));
X_jw3 = fftshift(fft(x3));
X_jw4 = fftshift(fft(x4));

%%
%Q3C
t = linspace(-10000,10000,20001);
l_t = length(t);

for i = 1:2
    T=i*4;
    n=-10000:T:10000;
    x1 = sinc(n/6);
    x2 = (sinc(n/12)).^2;
    x3 = cos(pi*n/12);
    x4 = cos(pi*n/12) + sin(pi*n/6);
    x1t = sinc(t/6);
    x2t = (sinc(t/12)).^2;
    x3t = cos(pi*t/12);
    x4t = cos(pi*t/12) + sin(pi*t/6);
    w=linspace(-pi,pi,length(n));
    % Calculating X(e^jw)
    X_ejw1 = abs(fftshift(fft(x1)));
    X_ejw2 = abs(fftshift(fft(x2)));
    X_ejw3 = abs(fftshift(fft(x3)));
    X_ejw4 = abs(fftshift(fft(x4)));
    % ploting X_ejw1 along side x1[n]
    figure; subplot(2,1,1);plot(w,X_ejw1); title(['|X_1(e^{jw})| with T = ', num2str(T)]); xlabel('w [rad/samp]'); ylabel('X_{c1}(e^{jw})');
    xticks([-pi -pi/2 -pi/4 0 pi/4 pi/2 pi]);
    xticklabels({'-\pi','-\pi/2','-\pi/4','0','\pi/4','\pi/2','\pi'});
    subplot(2,1,2);plot(t,x1t); title('x_{c1}[n] in the time dimension'); xlim([-60 60]); xlabel('n [DT]'); ylabel('x_{c1}[n]');
    % ploting X_ejw2 along side x2[n]
    figure; subplot(2,1,1);plot(w,X_ejw2); title(['|X_2(e^{jw})| with T = ', num2str(T)]); xlabel('w [rad/samp]'); ylabel('X_{c2}(e^{jw})');
    xticks([-pi -pi/2 -pi/4 0 pi/4 pi/2 pi]);
    xticklabels({'-\pi','-\pi/2','-\pi/4','0','\pi/4','\pi/2','\pi'});
    subplot(2,1,2);plot(t,x2t); title('x_{c2}[n] in the time dimension'); xlim([-60 60]); xlabel('n [DT]'); ylabel('x_{c2}[n]');
    % ploting X_ejw2 along side x2[n]
    figure; subplot(2,1,1);plot(w,X_ejw3); title(['|X_3(e^{jw})| with T = ', num2str(T)]); xlabel('w [rad/samp]'); ylabel('X_{c3}(e^{jw}])');
    xticks([-pi -pi/2 -pi/4 0 pi/4 pi/2 pi]);
    xticklabels({'-\pi','-\pi/2','-\pi/4','0','\pi/4','\pi/2','\pi'});
    subplot(2,1,2);plot(t,x3t); title('x_{c3}[n] in the time dimension'); xlim([-60 60]); xlabel('n [DT]'); ylabel('x_{c3}[n]');
    % ploting X_ejw4 along side x4[n]
    figure; subplot(2,1,1);plot(w,X_ejw4); title(['|X_4(e^{jw})| with T = ', num2str(T)]); xlabel('w [rad/samp]'); ylabel('X_{c4}(e^{jw})');
    xticks([-pi -pi/2 -pi/4 0 pi/4 pi/2 pi]);
    xticklabels({'-\pi','-\pi/2','-\pi/4','0','\pi/4','\pi/2','\pi'});
    subplot(2,1,2);plot(t,x4t); title('x_{c4}[n] in the time dimension'); xlim([-60 60]); xlabel('n [DT]'); ylabel('x_{c4}[n]');
    
end
    

