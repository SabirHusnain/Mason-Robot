clear all;
clc;

a2=1.5;a3=2;d6=0.5;

L(1)=Link([0 0 0 pi/2 0]);
L(2)=Link([0 0 a2 0 0]);
L(3)=Link([0 0 a3 pi/2 0]);
L(4)=Link([0 0 0 pi/2 0]);
L(5)=Link([0 0 0 pi/2 0]);
L(6)=Link([0 d6 0 0 0]);

L(1).qlim=[-pi/2 pi/2];
L(2).qlim=[-pi/3 pi/3];
L(3).qlim=[-pi/2 pi/2];
L(4).qlim=[-pi/2 pi/2];
L(5).qlim=[0 pi];
L(6).qlim=[-pi/2 pi/2];

robot=SerialLink(L,'name','Lay Clay Robot');

if(~isfile('Robotics_CEP_Workspace.mat'))
    i=0;
    for a=-pi/2:d2r(10):pi/2
        for b=-pi/3:d2r(30):pi/3
            for c=-pi/2:d2r(30):pi/2
                for d=-pi/2:d2r(30):pi/2
                    for e=0:d2r(30):pi
                        for f=-pi/2:d2r(30):pi/2
                            i=i+1;
                            disp(i);
                            T=robot.fkine([a b c d e f]);
                            px(i)=T(1,4);
                            py(i)=T(2,4);
                            pz(i)=T(3,4);
                        end
                    end
                end
            end
        end
    end
    save('Robotics_CEP_Workspace.mat');
    clc;
else
    load('Robotics_CEP_Workspace.mat');
end

figure(2);
robot.plot([0 0 0 0 0 0],'fps',120,'jvec');
robot.teach();

figure(1);
robot.plot([0 0 0 0 0 0],'fps',120,'jvec');
hold on;
plot3(px,py,pz,':.','color','#33BEFF','MarkerSize',...
    1,'LineWidth',1,'MarkerEdgeColor','#33BEFF');