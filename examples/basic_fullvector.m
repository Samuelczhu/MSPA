% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 10;         % number of modes to compute

[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy); 

% First consider the fundamental TE mode:
[Hx1,Hy1,neff1] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');
 % Next consider the fundamental TM mode
% (same calculation, but with opposite symmetry)
[Hx2,Hy2,neff2] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000S');

% Figure number
figNum = 1;
%% Loop through the modes
for imode = 1:nmodes
    iHx1 = Hx1(:,:,imode);
    iHy1 = Hy1(:,:,imode);
    iHx2 = Hx2(:,:,imode);
    iHy2 = Hy2(:,:,imode);
    
    fprintf(1,'neff = %.6f\n',neff1);
    
    figure(figNum);
    figNum = figNum+1;
    subplot(121);
    contourmode(x,y,iHx1);
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
    
    subplot(122);
    contourmode(x,y,iHx1);
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
    
    fprintf(1,'neff = %.6f\n',neff2);
    
    figure(figNum);
    figNum = figNum+1;
    subplot(121);
    contourmode(x,y,iHx2);
    title('Hx (TM mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
    
    subplot(122);
    contourmode(x,y,iHy2);
    title('Hy (TM mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

end
