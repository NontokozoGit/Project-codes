function [normal]= Testing(x)
%normal  = norm(x(:,1)-x(:,2));
[n,d] = size(x);
%normal = sqrt(sum((x(1,:)-x(2,:)).^2));

normal=norm(x(1,:)-x(2,:));
for i = 1 : n-1
    for j = i+1 : n
%        m = sqrt(sum((x(i,:)-x(j,:)).^2));
m=norm(x(i,:)-x(j,:));
        if m<=normal
            normal=m;
%            display(normal)
        end
    end
end