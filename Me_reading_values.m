%a=arduino()             % connecting to arduino 
%s = servo(a,'D9');      % attaching the esc to digital pin 9

wait=1;

i=0;

%The coming 3 lines are used to calibrate the speed controller (esc)
writePosition(s,1);   
pause(2);
writePosition(s,0);
pause(2);


init_angle = readVoltage(a,'A1');  % Reading the initial angle to prevent any offset


tic % tic toc functions to measure time 


while (toc<20) % reading from the arduino for 20 seconds
   
    i=i+1;
    
    input = readVoltage(a,'A0'); % reading the input from the user (in the form of potentiometer voltage)
    input = input/5; % normalizing the input as the maximum input = 5 volts
    
    
    
    angle = -(readVoltage(a,'A1')-init_angle); % measuring the current angle of the rod
    angle = angle*50/0.7771; % mapping the input from A1 to angle degrees
    
    data(i) = angle;    % stroing the values of the angle in a vector data
    input_2(i) = input;
    t(i)=toc;           % storing the value of the current time from the beginning of the code
    
    disp(input); % prinring the input
    writePosition(s,input); % depending on the input there are is a pulse modulation signal 
    
end

%writePosition(s,0); % turning of the motor
plot(t,data); % plotting the data
xlabel('time (s)'); 
ylabel('angle (degrees)')
title('20 Seconds of Data')


