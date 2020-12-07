function [P] = mask_band(varargin)
%Author Π.Καββαδίας, ΑΜ 1054350, Date: 22/12/2019

n=varargin{1};
type=varargin{2};
p=varargin{3};
if nargin==3
  q=p;
elseif nargin==4
  q=varargin{4};
else
  error('Function accepts 3 or 4 input arguments')
end
if(strcmp(type,'band'))
    e=ones(n,p+q+1);
    P = spdiags(e,-p:q,n,n);
    P=full(P);
elseif(strcmp(type,'btdr'))
    if (mod(n,p) == 0)
            k = floor(n/p) ;
            M = diag(ones(k,1)) + diag(ones(k-1,1),1) + diag(ones(k-1,1),-1);
            A = ones(p);
            P = kron(M,A);
            
    elseif (mod(n,p) ~= 0 )

            k = floor(n/p) ;
            M = diag(ones(k,1)) + diag(ones(k-1,1),1) + diag(ones(k-1,1),-1);
            A = ones(p);
            r = mod(n,p) ;
            R = ones(r) ;
            P(1:k*p,1:k*p) = kron(M,A);
            
            %Insert R at last block of main diagonial
            P(k*p+1:n,k*p+1:n) = R ;
    end
end
        
end