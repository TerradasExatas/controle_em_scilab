//terradasexatas 
clear
// função para calcular grandezas da resposta no tempo
//CUIDADO, para funcionar o tempo da simulação 
//tem que ser grande o suficiente
function [peak_time, overshoot, rise_Time, settling_Time]=my_step_info(t, curva)
    [val_max,ind_max]= max(curva);
    val_final=curva(length(curva));
     peak_time = t(ind_max);
    overshoot=(val_max/val_final-1)*100;
  for i=1:length(curva)-1
    if (curva(i)>val_final*.10)
        i_10=i
        break
    end, end
  for i=1:length(curva)-1
    if (curva(i)>val_final*.90)
        i_90=i
        break
    end, end
  rise_Time=t(i_90)-t(i_10)
  for i=(length(curva)-1):-1:1
    if (abs(curva(i)/val_final)>1.02) | (abs(curva(i)/val_final)<0.98)
     qts=i
     break
    end, end
  settling_Time=(t(qts))
endfunction

T_sim = 10;
// cria a função de transferência 
s=poly(0,'s');
H_s = syslin('c',[9],[s^2+3*s+9]) 
//H_s = syslin('c',[4],[s^2+0.8*s+4])
//H_s = syslin('c',[0.25],[s^2+0.1*s+0.25])
disp('H_s = ',H_s)
//resposta ao degrau 
t=linspace(0,T_sim,1e3) ;t1=linspace(-1,T_sim,1e4) 
y_degrau=[0*t1(t1<=0) t1(t1>0)./t1(t1>0)]; 
y_sis=csim('step',t,H_s)
[tp,os,tr,ts]=my_step_info(t, y_sis)
disp('Peak time (s)= ',tp)
disp('Overshoot (%)= ',os)
disp('Rise Time (s)= ',tr)
disp('Settling Time (s)= ',ts)
scf(1); clf(1); 
plot(t1,y_degrau,'r-','LineWidth',3); 
plot(t,y_sis,'b-','LineWidth',3) 
xlabel "$tempo (s)$" fontsize 5 
L=legend(['degrau unitário','resposta ao degrau'],4); 
L.font_size=4 
set(gca(),'font_size',5) ;set(gca(),"grid",[1 1]) 



