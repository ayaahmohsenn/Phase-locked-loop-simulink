
current_Time=0;
prev_Time=0;
delta=0;
Vq_ref=0;
Accumlative_error=0;
Kp=320;
Ki=400;
A=1;
%A = 565.69;
FreqVec = [];
currTime =[];

while current_Time<0.3
%A, B, and C frame
VA = A*(sin(50*2*pi*current_Time));
VB = A*(sin(50*2*pi*current_Time - 2*pi/3));
VC = A*(sin(50*2*pi*current_Time - 4*pi/3));
%alpha and beta frame
Valpha=(2/3)*(cos(0)*VA+cos(2*pi/3)*VB+cos(4*pi/3)*VC);
Vbeta=(2/3)*(sin(0)*VA+sin(2*pi/3)*VB+sin(4*pi/3)*VC);
%dq frame
Vq=Valpha*sin(-delta)+Vbeta*cos(-delta);
%PI controller
error=Vq_ref-Vq;
Accumlative_error=(Accumlative_error + error * (current_Time - prev_Time));
frequency=Kp*error+Ki*Accumlative_error;

%saturation
if frequency < 40*2*pi
    frequency = 40*2*pi;
elseif frequency > 60*2*pi
    frequency = 60*2*pi;
end

%%integrate
delta=delta+frequency*(current_Time - prev_Time);
FreqVec = [FreqVec frequency];
currTime = [currTime current_Time];
prev_Time = current_Time;
current_Time = current_Time + 7e-5;
end

 plot(currTime,FreqVec)