function projectileMotion

dt = 0.25;
g = 9.81;
v_i = 700;
b2m = 0.00004;
zo = 10000;
rhoo = 1.225;
flagI = true;
flagD = true;
flagRho = true;
flagG = true;

figure
hold on

cbI = uicontrol('Style','checkbox','String','Ideal',...
        'Position',[20 20 80 20],'Value',1,'Callback',@updatePlot);
cbD = uicontrol('Style','checkbox','String','Drag',...
        'Position',[20 40 80 20],'Value',1,'Callback',@updatePlot);
cbRho = uicontrol('Style','checkbox','String','+Atmosphere density',...
        'Position',[20 60 80 20],'Value',1,'Callback',@updatePlot);
cbG = uicontrol('Style','checkbox','String','+Gravitational acceleration',...
        'Position',[20 80 80 20],'Value',1,'Callback',@updatePlot);
updatePlot([],[])

function updatePlot(~,~)
    cla
    hold on
    flagI   = cbI.Value;
    flagD   = cbD.Value;
    flagRho = cbRho.Value;
    flagG   = cbG.Value;
    for theta = 35:5:55
    
        % Ideal
        v_zi = v_i*sin(theta*pi/180);
        v_xi = v_i*cos(theta*pi/180);
    
        x_space = 0;
        z_space = 0;
        k = 2;
    
        while z_space(end) >= 0 && flagI==true
            x_space(k) = x_space(k-1) + v_xi*dt;
            z_space(k) = z_space(k-1) + v_zi*dt;
            v_zi = v_zi - g*dt;
            k = k + 1;
        end
    
        plot(x_space, z_space)
    
        % Drag 
        v_zi = v_i*sin(theta*pi/180);
        v_xi = v_i*cos(theta*pi/180);
    
        x_space = 0;
        z_space = 0;
        k = 2;
    
        while z_space(end) >= 0 && flagD==true
            x_space(k) = x_space(k-1) + v_xi*dt;
            z_space(k) = z_space(k-1) + v_zi*dt;
    
            v = sqrt(v_zi^2 + v_xi^2);
            v_zi = v_zi - g*dt - b2m*v*v_zi*dt;
            v_xi = v_xi - b2m*v*v_xi*dt;
    
            k = k + 1;
        end
    
        plot(x_space, z_space)
    
        % Atmosphere density consideration
        v_zi = v_i*sin(theta*pi/180);
        v_xi = v_i*cos(theta*pi/180);
    
        x_space = 0;
        z_space = 0;
        k = 2;
    
        while z_space(end) >= 0 && flagRho==true
            x_space(k) = x_space(k-1) + v_xi*dt;
            z_space(k) = z_space(k-1) + v_zi*dt;
    
            rho = rhoo*exp(-z_space(k)/zo);
            v = sqrt(v_zi^2 + v_xi^2);
    
            v_zi = v_zi - g*dt - b2m*rho*v*v_zi*dt;
            v_xi = v_xi - b2m*rho*v*v_xi*dt;
    
            k = k + 1;
        end
    
        plot(x_space, z_space)
    
        % Gravitational acceleration consideration
        v_zi = v_i*sin(theta*pi/180);
        v_xi = v_i*cos(theta*pi/180);
    
        x_space = 0;
        z_space = 0;
    
        G = 6.67e-11;
        rE = 6371000;
        mE = 5.97e24;
    
        k = 2;
    
        while z_space(end) >= 0 && flagG==true
            x_space(k) = x_space(k-1) + v_xi*dt;
            z_space(k) = z_space(k-1) + v_zi*dt;
    
            rho = rhoo*exp(-z_space(k)/zo);
            g_var = (mE*G)/((rE + z_space(k))^2);
    
            v = sqrt(v_zi^2 + v_xi^2);
    
            v_zi = v_zi - g_var*dt - b2m*rho*v*v_zi*dt;
            v_xi = v_xi - b2m*rho*v*v_xi*dt;
    
            k = k + 1;
        end
    
        plot(x_space, z_space)
    
    end
    
    hold off
    xlabel('x')
    ylabel('z')
    title('Projectile Motion with Various Drag Models')
end

end