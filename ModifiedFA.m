function [Sol]=ModifiedFA

n=50;                   
N = 27;                 % number of chairs
alpha=1.0;              % Randomness strength 0--1 (highly random)
beta0=0.5;              % Attractiveness constant at r=0
gamma=0.01;             % Absorption coefficient
% theta=0.97;             % Randomness reduction factor theta=10^(-5/tMax)
d=2;                   % Number of dimensions
tMax=10;                % Maximum number of iterations
Lb=0;       % Lower bounds/limits
Ub=10;        % Upper bounds/limits
% Generating the initial locations of n fireflies

for i=1:n
    for p=1:N
        ns(p,2,i)=Lb+(Ub-Lb).*rand(1,1,1);% Randomization
        ns(p,1,i)=Lb+(0.4*ns(p,2,i)-Lb).*rand(1,1,1);% Randomization
    end

    Lightin(i)=Testing(ns(:,:,i));               % Evaluate objectives
    
%     for j=1:N
%         scatter(ns(j,1,i),ns(j,2,i))       
%         hold on
%     end
%     grid
%     pause
%     hold off
    
end
ns
pause

%%%%%%%%%%%%%%%%% Start the iterations (main loop) %%%%%%%%%%%%%%%%%%%%%%%
for k=1:tMax  %
    %alpha=alpha*theta;    % Reduce alpha by a factor theta
    % Two loops over all the n fireflies
    for i=1:n
        for j=1:n
            % Evaluate the objective values of current solutions
            Lightin(i)=Testing(ns(:,:,i));           % Call the objective %calculate the light intensity at position x_i
            Lightin(j)=Testing(ns(:,:,j));
            % Update moves
            if Lightin(i)<=Lightin(j)           % Brighter/more attractive(comparing the brightness of i and j)
                r=sqrt(sum(sum((ns(:,:,i)-ns(:,:,j)).^2))); %calculating the distance between i and j respectively
                beta0=beta0*exp(-gamma*r^2);    % Attractiveness which vary with distance
                steps=alpha.*(rand(N,d,1)-0.5);%.*scale; %number of steps
                % The FA equation for updating position vectors
                ns(:,:,i)=ns(:,:,i)+beta0.*(ns(:,:,j)-ns(:,:,i))+steps; %movement of a firefly
            end
        end % end for j
    end % end for i
    % Check if the new solutions/locations are within limits/bounds
    for ii=1:N
        for kk=1:n
            
            for jj=1:d
                if ns(ii,jj,kk)<0
                    ns(ii,jj,kk)=0;
                elseif ns(ii,jj,kk)>10
                    ns(ii,jj,kk)=10;                
                end
                
            end
            if ns(ii,2,kk)<=2.5*ns(ii,1,kk)-10
                ns(ii,1,kk)=0.4*ns(ii,2,kk)+4;
            end
        end
    end
                    
    %% Rank fireflies by their light intensity/objectives
    for ij=1:n
        Lightin(ij)=Testing(ns(:,:,ij));
    end
    [Lightnx,Index]=sort(Lightin);
%     nsol_tmp=ns;
%     for i=1:n
%         ns(:,:,i)=nsol_tmp(Index(i),:);
%     end
    
    %% Find the current best solution and display outputs
    fbest(k)=Lightnx(n);
    nbest(:,:,k)=ns(:,:,Index(n));
    
    
    for j=1:N
        scatter(nbest(j,1,k),nbest(j,2,k))       
        hold on
    end
    grid
%    pause(0.25)
    hold off
    
    
    dom(k)=k;
    ran(k)=Lightnx(n);
end % End of the main FA loop (up to tMax)

pause
plot(dom,ran)
grid
%pause
for ii=1:tMax
    Lightinn(ii)=Testing(nbest(:,:,ii));
end
[LL,II]=sort(Lightinn);
Sol=nbest(:,:,II(tMax));
for jj=1:N
    scatter(nbest(jj,1,II(tMax)),nbest(jj,2,II(tMax)))
    grid
    hold on
    
end
LL(tMax)
