%Author Π.Καββαδίας, ΑΜ 1054350, Date: 8/01/2020
clear;
load('email.mat');
email=Problem.A;
[X_001,iterations_pcg001,vector_pcg001,time_pcg001]=multiKatz(email,0.01,'pcg',{10^(-7),50});
[~,I_001]=maxk(X_001,5);
[X_002,iterations_pcg002,vector_pcg002,time_pcg002]=multiKatz(email,0.02,'pcg',{10^(-7),50});
[~,I_002]=maxk(X_002,5);
[X_003,iterations_pcg003,vector_pcg003,time_pcg003]=multiKatz(email,0.03,'pcg',{10^(-7),50});
[~,I_003]=maxk(X_003,5);
[X_004,iterations_pcg004,vector_pcg004,time_pcg004]=multiKatz(email,0.04,'pcg',{10^(-7),50});
[~,I_004]=maxk(X_004,5);

[X_001d,iterations_direct001,vector_direct001,time_direct001]=multiKatz(email,0.01,'direct',{});
[~,I_001d]=maxk(X_001d,5);
[X_002d,iterations_direct002,vector_direct002,time_direct002]=multiKatz(email,0.02,'direct',{});
[~,I_002d]=maxk(X_002d,5);
[X_003d,iterations_direct003,vector_direct003,time_direct003]=multiKatz(email,0.03,'direct',{});
[~,I_003d]=maxk(X_003d,5);
[X_004d,iterations_direct004,vector_direct004,time_direct004]=multiKatz(email,0.04,'direct',{});
[~,I_004d]=maxk(X_004d,5);

[X_001pc,iterations_pcg001pc,vector_pcg001pc,time_pcg001pc]=multiKatz(email,0.01,'pcg',{10^(-7),50,ichol(sparse(eye(length(email))-0.01*email)),transpose(ichol(sparse(eye(length(email))-0.01*email)))});
[~,I_001pc]=maxk(X_001pc,5);
[X_002pc,iterations_pcg002pc,vector_pcg002pc,time_pcg002pc]=multiKatz(email,0.02,'pcg',{10^(-7),50,ichol(sparse(eye(length(email))-0.02*email)),transpose(ichol(sparse(eye(length(email))-0.02*email)))});
[~,I_002pc]=maxk(X_002pc,5);
[X_003pc,iterations_pcg003pc,vector_pcg003pc,time_pcg003pc]=multiKatz(email,0.03,'pcg',{10^(-7),50,ichol(sparse(eye(length(email))-0.03*email)),transpose(ichol(sparse(eye(length(email))-0.03*email)))});
[~,I_003pc]=maxk(X_003pc,5);
[X_004pc,iterations_pcg004pc,vector_pcg004pc,time_pcg004pc]=multiKatz(email,0.04,'pcg',{10^(-7),50,ichol(sparse(eye(length(email))-0.04*email)),transpose(ichol(sparse(eye(length(email))-0.04*email)))});
[~,I_004pc]=maxk(X_004pc,5);

figure;
semilogy(0:iterations_pcg001,vector_pcg001,'-x');
hold on;
semilogy(0:length(vector_pcg001pc)-1,vector_pcg001pc,'-o');
legend('pcg','pcg-ichol');
hold off;
title('PCG with a = 0.01');
xlabel('Iterations');
ylabel('abs(b - Ax^k)');

figure;
semilogy(0:iterations_pcg002,vector_pcg002,'-x');
hold on;
semilogy(0:length(vector_pcg002pc)-1,vector_pcg002pc,'-o');
legend('pcg','pcg-ichol');
hold off;
title('PCG with a = 0.02');
xlabel('Iterations');
ylabel('abs(b - Ax^k)');

figure;
semilogy(0:iterations_pcg003,vector_pcg003,'-x');
hold on;
semilogy(0:length(vector_pcg003pc)-1,vector_pcg003pc,'-o');
legend('pcg','pcg-ichol');
hold off;
title('PCG with a = 0.03');
xlabel('Iterations');
ylabel('abs(b - Ax^k)');

figure;
semilogy(0:iterations_pcg004,vector_pcg004,'-x');
hold on;
semilogy(0:length(vector_pcg004pc)-1,vector_pcg004pc,'-o');
legend('pcg','pcg-ichol');
hold off;
title('PCG with a = 0.04');
xlabel('Iterations');
ylabel('abs(b - Ax^k)');