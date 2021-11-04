// terradasexatas 
clear
T_sim = 10;
// cria a função de transferência 
s=poly(0,'s');
P_s = syslin('c',[2+s],[1+s]) 
R_s = syslin('c',[1],[s])
disp('P_s = ',P_s) 
disp('R_s =',R_s)
C_s = R_s*P_s;
disp('C_s =',C_s)
// calcula os polos e zeros
[z,p,k]=tf2zp(C_s)
disp('zeros = ',z) 
disp('polos = ',p) 
scf(2); clf(2);
//plota o mapa de polos e zeros
plzr(C_s)
//resposta ao degrau 
t=linspace(0,T_sim,1e4) ;t1=linspace(-1,T_sim,1e4) 
y_degrau=[0*t1(t1<=0) t1(t1>0)./t1(t1>0)]; 
y_sis_C_s=csim('step',t,P_s)
scf(3); clf(3); 
plot(t1,y_degrau,'r-','LineWidth',3); 
plot(t,y_sis_C_s,'b-','LineWidth',3) 
xlabel "$tempo (s)$" fontsize 5 
L=legend(['degrau unitário','resposta ao degrau'],4); 
L.font_size=4 
set(gca(),'font_size',5) ;set(gca(),"grid",[1 1]) 
stepinfo(C_s)


