clc;
clear all;
close all;

A=xlsread('F:\4-1\microprocessor and embedded system\new\SAP Assignment\SAP_1506023\ROM.xlsx','A:B');
fid1=fopen('C_ROM1.bin','w');
for i=1:length(A)
   value=A(i,1)*16+A(i,2); 
   fwrite(fid1,value);
end
fclose(fid1);


B=xlsread('F:\4-1\microprocessor and embedded system\new\SAP Assignment\SAP_1506023\ROM.xlsx','C:D');
fid2=fopen('C_ROM2.bin','w');
for i=1:length(B)
   value=B(i,1)*16+B(i,2); 
   fwrite(fid2,value);  
end
fclose(fid2);

C=xlsread('F:\4-1\microprocessor and embedded system\new\SAP Assignment\SAP_1506023\ROM.xlsx','E:F');
fid3=fopen('C_ROM3.bin','w');
for i=1:length(C)
   value=C(i,1)*16+C(i,2); 
   fwrite(fid3,value);  
end
fclose(fid3);

E=xlsread('F:\4-1\microprocessor and embedded system\new\SAP Assignment\SAP_1506023\ROM.xlsx','G:G');
fid5=fopen('C_ROM4.bin','w');
for i=1:length(E)
   value=E(i,1)*16;
   fwrite(fid5,value);
end
fclose(fid5);


D=xlsread('F:\4-1\microprocessor and embedded system\new\SAP Assignment\SAP_1506023\ROM.xlsx','H:I');
fid4=fopen('ADD_ROM.bin','w');
for i=1:length(D)
   value=D(i,1)*16+D(i,2); 
   fwrite(fid4,value);  
end
fclose(fid4);