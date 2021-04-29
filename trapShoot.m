function [] = trapShoot ()
close all; % Closes all windows previously opened in Matlab
    global pull; % Creates the global variable pull
    pull.hits = 0;
    pull.misses = 0;
    pull.fig = figure('numbertitle','off','name','Target Counter'); 
    % Opens the figure where all of the information goes
    
    pull.hitsDisplayMessage = uicontrol('style','text','units','normalized','position',[.034 .78 .09 .095],'string','Targets Hit:','horizontalalignment','right');
    pull.hitsDisplay = uicontrol('style','text','units','normalized','position',[.15 .79 .09 .05],'string',num2str(pull.hits),'horizontalalignment','right');
    % These two lines display how many targets the user has hit
    
    pull.missesDisplayMessage = uicontrol('style','text','units','normalized','position',[.034 .52 .09 .095],'string','Targets Missed:','horizontalalignment','right');
    pull.missesDisplay = uicontrol('style','text','units','normalized','position',[.15 .54 .09 .05],'string',num2str(pull.misses),'horizontalalignment','right');
    % These two lines display how many targets the user has missed
    
    pull.stock = uicontrol('style','text','units','normalized','position',[.15 .28 .09 .05],'string','25','horizontalalignment','right');    
    pull.totalDisplayMessage = uicontrol('style','text','units','normalized','position',[.034 .26 .12 .095],'string','Targets Remaining:','horizontalalignment','right');
    % These two lines display how many targets are left before the game needs to be reset
    
    pull.hitTarget = uicontrol('style','pushbutton','units','normalized','position',[.75 .80 .14 .05],'string','Hit','callback',{@addHit,1});
    % Creates a button called "Hit". When pressed, it calls back to the addHit function
    
    pull.missedTarget = uicontrol('style','pushbutton','units','normalized','position',[.75 .60 .14 .05],'string','Miss','callback',{@addMiss,1});
    % Creates a button called "Miss". When pressed, it calls back to the addMiss function.
    
    whatRoundButtons = uibuttongroup();
    whatRoundButtons.SelectionChangeFcn = @whatRound;
    whatRoundButtons.Units = 'normalized';
    whatRoundButtons.Position = [.05 .01 .55 .075];
    % These 4 lines create a button group and identifies the function it
    % calls, the untis, and the position
    
    c1 = uicontrol(whatRoundButtons); % Creates the first button and identifies which button group it belings to
    c1.Style = 'radiobutton'; % Identifies what style button it is
    c1.Units = 'normalized'; % Identifies the units
    c1.Position = [0 .4 .4 .6]; % Determines where the button is positioned within the button group
    c1.String = 'Practice Round'; % Gives the button a name
    c1.HandleVisibility = 'on';
    
    c2 = uicontrol(whatRoundButtons); % Creates the second button and identifies which button group it belongs to
    c2.Style = 'radiobutton'; % Identifies what style button it is
    c2.Units = 'normalized'; % Identifies the units
    c2.Position = [.5 .4 .4 .6]; % Determines where the button is positioned within the button group
    c2.String = 'Competitive Round'; % Gives the button a name
    c2.HandleVisibility = 'on';
    
    pull.newRound = uicontrol('style','pushbutton','units','normalized','position',[.8 .03 .1 .05],'string','New Round','callback',{@newRound});
    % Creates a button, that when clicked, will call on the newRound function

    function [] = whatRound(source, event)
        if (strcmp('Practice Round',event.NewValue.String))
            msgbox('This is a Practice Round');
        elseif (strcmp('Competitive Round',event.NewValue.String))
            msgbox('This is a Competitive Round');
        end
    end
    % This function displays a message to the user, depending on which radiobutton is selected


    function [] = addHit(source, event, hits)
        % This function assumes that the last button clicked was Hit
        
        if str2num(pull.stock.String) == 1 && str2num(pull.hitsDisplay.String) >= 19 
            pull.hits = pull.hits + hits;
            pull.hitsDisplay.String = pull.hits;
        
            x = str2num(pull.stock.String) - 1;
            pull.stock.String = x;
           
            msgbox('Great Job!');
            % If there is only 1 target remaining and the number of hits is
            % greater than or equal to 19, a target is: added to the number
            % of targets hit, subtracted from targets remaining, and a
            % message is displayed
            
        elseif str2num(pull.stock.String) == 1 && str2num(pull.hitsDisplay.String) < 19
            pull.hits = pull.hits + hits;
            pull.hitsDisplay.String = pull.hits;
        
            x = str2num(pull.stock.String) - 1;
            pull.stock.String = x;
            
            msgbox ('Keep Practicing!');
            % If there is only 1 target remaining and the number of hits is
            % less than 19, a target is: added to the number
            % of targets hit, subtracted from targets remaining, and a
            % message is displayed            
            
        elseif str2num(pull.stock.String) >= 1
            pull.hits = pull.hits + hits;
            pull.hitsDisplay.String = pull.hits;
        
            x = str2num(pull.stock.String) - 1;
            pull.stock.String = x;
            % If there is more than 1 target remaining, a target is added
            % to the number of targets hit, and subtracted from targets
            % remaining
        end
    end

    function [] = addMiss(source, event, misses)
        % This function assumes that the last button clicked was Miss
        
        if str2num(pull.stock.String) == 1  && str2num(pull.hitsDisplay.String) >= 20 
            pull.misses = pull.misses + misses;
            pull.missesDisplay.String = pull.misses;
        
            x = str2num(pull.stock.String) - 1;
            pull.stock.String = x;
            
            msgbox('Great Job!');
            % If there is only 1 target remaining and the number of hits is
            % greater than or equal to 20, a target is: added to the number
            % of targets missed, subtracted from targets remaining, and a
            % message is displayed            
            
        elseif str2num(pull.stock.String) == 1 && str2num(pull.hitsDisplay.String) < 20
            pull.misses = pull.misses + misses;
            pull.missesDisplay.String = pull.misses;
        
            x = str2num(pull.stock.String) - 1;
            pull.stock.String = x;
           
            msgbox ('Keep Practicing!');
            % If there is only 1 target remaining and the number of hits is
            % less than 20, a target is: added to the number
            % of targets missed, subtracted from targets remaining, and a
            % message is displayed
            
        elseif str2num(pull.stock.String) >= 1
            pull.misses = pull.misses + misses;
            pull.missesDisplay.String = pull.misses;
        
            x = str2num(pull.stock.String) - 1;
            pull.stock.String = x;
            % If there is more than 1 target remaining, a target is added
            % to the number of targets missed, and subtracted from targets
            % remaining
            
        end
    end

    function [] = newRound(source, event)
        pull.hits = 0;
        pull.hitsDisplay.String = 0;
        
        pull.misses = 0;
        pull.missesDisplay.String = 0;
        
        pull.stock.String = "25";        
        % If this button is clicked, the number of targets hit returns to
        % 0, the number of targets missed returns to 0, and the number of
        % targets remaining returns to 25.
        
    end
end