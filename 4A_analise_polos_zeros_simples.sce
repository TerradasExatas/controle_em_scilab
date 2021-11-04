// cria a função de transferência 
s=poly(0,'s');
//P_s = syslin('c',[2+s],[1+s]) 
P_s = syslin('c',[1+s],[15+8*s+s^2])
disp('P_s = ',P_s) 
[z,p,k]=tf2zp(P_s)
disp('zeros = ',z) 
disp('polos = ',p) 
scf(2); clf(2);
plzr(P_s)


