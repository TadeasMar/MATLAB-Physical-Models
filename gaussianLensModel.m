function gaussianLensModel

f = 5;
ho = 2;

figure
ax = axes();

slider = uicontrol('Style','slider', 'Min',6,'Max',20,'Value',12, 'Units','normalized', 'Position',[0.2 0.01 0.6 0.05], 'Callback',@updatePlot);

updatePlot(slider)

    function updatePlot(src,~)
    
        % Mathematically describe all significant observables
        do = get(src,"Value");
        
        di = (do*f)/(do-f);
        M = -di/do;
        hi = M*ho;
            
        % Plot setup
        cla(ax)
        hold(ax,"on")
        ylim(ax, [-25 25])
        xlim(ax, [-20 20])
        grid(ax,"on")
            
        % Optical axis
        plot(ax, [-100 100],[0 0],'k')
          
        % Lens
        plot(ax, [0 0],[-10 10],'b','LineWidth',3)
            
        % Focal points
        plot(ax, [f -f],[0 0],'rx')
            
        % Object
        plot(ax, [-do -do],[0 ho],'g','LineWidth',2)
            
        % Image
        plot(ax, [di di],[0 hi],'r','LineWidth',2)
            
        % Principal Rays
        plot(ax, [-do di], [ho hi],"m")
        plot(ax, [-do 0], [ho, ho], "m")
        plot(ax, [0 di], [ho, hi],"m")
        plot(ax, [-do 0], [ho, hi], "m")
        plot(ax, [0 di], [hi, hi],"m")
            
        title('Gaussian Thin Lens Ray Diagram')
    end
end