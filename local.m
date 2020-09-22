function local

x=ModifiedFA %access the results from the FA

[n, d]=size(x)

MaxGen=5;

m=5;

lM=8;
hold off

for jj=1:n
    scatter(x(jj,1),x(jj,2), 'MarkerEdgeColor',[0 .5 .5],...
        'MarkerFaceColor',[0 .7 .7],...
        'LineWidth',1.5)
    grid
    pause(0.15)
    hold on
end
pause(0.5)


for t=1:MaxGen
    y=x;
    for i=1:n
        scatter(x(i,1),x(i,2),'MarkerEdgeColor',[0 .5 .5],...
            'MarkerFaceColor','red',...
            'LineWidth',1.5)
        
        l=(lM-0.5)*(t-1)/(1-MaxGen) + lM;
        pause(0.5)
        for ij=1:m
            z(:,:,ij)=x(:,:);
            z(:,:,m+ij)=x(:,:);
            d=rand(1,2)-0.5;
            z(i,:,ij)=y(i,:)+l.*(d(1,:));
            z(i,:,m+ij)=y(i,:)-l.*(d(1,:));
            [x(i,1), x(i,2); z(i, 1, ij) z(i, 2, ij); z(i, 1, m+ij) z(i, 2, m+ij)]
            %pause
            
            for k=1:2
                if z(i,k, ij)<0
                    z(i,k,ij)=0;
                elseif z(i,k,ij)>10 %%Restricting the feasible region, x greater than 10
                    z(i,k,ij)=10;
                end
                if z(i,k,m+ ij)<0
                    z(i,k,m+ij)=0;
                elseif z(i,k,m+ij)>10
                    z(i,k,m+ij)=10;
                end
            end
            if z(i,2, ij)<=2.5*z(i, 1, ij)-10 % y greater than 10
                z(i,1,ij)=0.4*z(i,2,ij)+4;
            end
                
                
                
            % z(i,:,ij)=y(i,:);
        end
        [x(i,1), x(i,2) Testing(x(:,:)); z(i, 1, ij) z(i, 2, ij) Testing(z(:,:,ij)); z(i, 1, m+ij) z(i, 2, m+ij) Testing(z(:,:,m+ij))]
   %     pause
        
        for ji=1:2*m
            if Testing(z(:,:,ji))>Testing(x(:,:))
                [i ji Testing(z(:,:,ji)) Testing(x(:,:))]
                x(i,:)=z(i,:,ji);
            end
            [x(i,1), x(i,2) Testing(x(:,:)); z(i, 1, ij) z(i, 2, ij) Testing(z(:,:,ij)); z(i, 1, m+ij) z(i, 2, m+ij) Testing(z(:,:,m+ij))]
            
        end
        [x(i,1), x(i,2)]
   %     pause
        hold off
        for jj=1:n
            scatter(x(jj,1),x(jj,2),'MarkerEdgeColor',[0 .5 .5],...
                'MarkerFaceColor',[0 .7 .7],...
                'LineWidth',1.5)
            grid
            %   pause(0.25)
            hold on
            
        end
    end
    pause(0.25)
    FF(t)=Testing(x);
end

p=4:0.1:8;
plot(p, 2.5*p-10)
hold off
x
FF(MaxGen)
pause
plot(1:MaxGen,FF) % ploting the graph of iterations versus the best value of Maximin
grid