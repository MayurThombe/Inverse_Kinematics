% A code for the Inverse Kinematics 3R robot manipulator to trace a circle(or any curve) 

T=[0 0 0 1;0 0 0 1;0 0 0 0;0 0 0 1];
Blist = [0 0 0;0 0 0;1 1 1;0 0 0;6 4 2;0 0 0];
Blist2 = [0;0;1;0;2;0];
Blist3 = [0 0;0 0;1 1;0 0;4 2;0 0];
Blist4 = [0 0 0;0 0 0;1 1 1;0 0 0;6 4 2;0 0 0];
M=[1 0 0 6;0 1 0 0;0 0 1 0;0 0 0 1];
M2=[1 0 0 2;0 1 0 0;0 0 1 0;0 0 0 1];
M3=[1 0 0 4;0 1 0 0;0 0 1 0;0 0 0 1];
M4=[1 0 0 6;0 1 0 0;0 0 1 0;0 0 0 1];
thetalist0=[0.1745;0.17455;0.1745];
eomg=0.001;
ev=0.001;
%[thetalist, success] = IKinBody(Blist, M, T, thetalist0, eomg, ev);
%T12 = FKinBody(M2, Blist2, thetalist(1));
%T13=FKinBody(M3, Blist3, thetalist);
%x_coordinate=[0 T12(1,4) T13(1,4)];
%y_coordinate=[0 T12(2,4) T13(1,4)];
%l=line(x_coordinate,y_coordinate,'color','r','linewidth',2);
%hold On
xlim([-4 4]);
ylim([-4 4]);
axis('equal');
% Initialize video
myVideo = VideoWriter('Three_R'); %open video file
myVideo.FrameRate = 10;  %can adjust this, 5 - 10 works well for me
open(myVideo)

%circle of radius 0.5 at 1,1
for ang=6.28:-0.1:0
x=4+cos(ang);
y=0+sin(ang);
plot(x,y,'yo');
hold ON
T=[0 0 0 x;0 0 0 y;0 0 0 0;0 0 0 1];

thetalist0=thetalist;

[thetalist, success] = IKinBody(Blist, M, T, thetalist0, eomg, ev);
%if success==0
 %   return
%end
thetalist = wrapTo2Pi(thetalist);
T12 = FKinBody(M2, Blist2, thetalist(1));
T13=FKinBody(M3, Blist3,[thetalist(1);thetalist(2)]);
T14=FKinBody(M4, Blist4, thetalist);
x_coordinate=[0 T12(1,4) T13(1,4) T14(1,4)];
y_coordinate=[0 T12(2,4) T13(2,4) T14(2,4)];
delete(ll);
ll=line(x_coordinate,y_coordinate,'color','r','linewidth',2);
%delete(ll);
%xlim([-3 3]);
%ylim([-3 3]);
axis('equal')
axis([-8 8 -8 8])
grid ON
pause(0.01)
frame = getframe(gcf); %get frame
    writeVideo(myVideo, frame);
end
close(myVideo)



