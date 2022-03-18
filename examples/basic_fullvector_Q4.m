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
% rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

% Made the mesh 8 times less dense
dx = dx*8;
dy = dy*8;

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

% Figure number
numFig = 1;

% Vector for ridge half-width from 0.325 to 1 in 10 steps
vecRidgeHalfWidth = linspace(0.325, 1, 10);
vecNeff = zeros(1, length(vecRidgeHalfWidth));

% Loop to changes the ridge half-width from 0.325 to 1 in 10 steps
for rw = vecRidgeHalfWidth
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy); 

    % First consider the fundamental TE mode:
    
    [Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');
    
    fprintf(1,'neff = %.6f\n',neff);
    vecNeff(numFig) = neff;
    
    figure(numFig);
    numFig = numFig + 1;
    subplot(121);
    contourmode(x,y,Hx);
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
    
    subplot(122);
    contourmode(x,y,Hy);
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
end

% Plot of Neff vs. Righe half-width
figure(numFig)
plot(vecRidgeHalfWidth, vecNeff, "-b.")
title("Neff vs. Rigde half-width")
xlabel("Rigde half-width")
ylabel("Neff")
grid on


