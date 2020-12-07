function [X,iterations,resnorm,time,maxelemind] = multiKatz(A,alpha,mth,pcg_parms)
%Author Π.Καββαδίας, ΑΜ 1054350, Date: 8/01/2020
iterations=0;
resnorm=0;
if strcmp(mth,'direct')
    tic;
    X=(eye(length(A))-alpha*transpose(A))\ones(length(A),1);
    time=toc;
end
if strcmp(mth,'pcg')
    if isempty(pcg_parms)
        tic;
        [X,~,~,iter,resvec]=pcg(eye(length(A))-alpha*transpose(A),ones(length(A),1));
        time=toc;
    elseif length(pcg_parms)==1
        tic;
        [X,~,~,iter,resvec]=pcg(eye(length(A))-alpha*transpose(A),ones(length(A),1),pcg_parms{1,1});
        time=toc;
    elseif length(pcg_parms)==2
        tic;
        [X,~,~,iter,resvec]=pcg(eye(length(A))-alpha*transpose(A),ones(length(A),1),pcg_parms{1,1},pcg_parms{1,2});
        time=toc;
        elseif length(pcg_parms)==3
        tic;
        [X,~,~,iter,resvec]=pcg(eye(length(A))-alpha*transpose(A),ones(length(A),1),pcg_parms{1,1},pcg_parms{1,2},pcg_parms{1,3});
        time=toc;
        elseif length(pcg_parms)==4
        tic;
        [X,~,~,iter,resvec]=pcg(eye(length(A))-alpha*transpose(A),ones(length(A),1),pcg_parms{1,1},pcg_parms{1,2},pcg_parms{1,3},pcg_parms{1,4});
        time=toc;
    end
    iterations=iter;
    resnorm=resvec;    
end
[~,maxelemind]=maxk(X,5);