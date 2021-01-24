clc;    
clear all;  
close all;

%instructions
single_instruction={'OUT A','HLT','SHR D','POP C','RET','MOV B,A','NEG C','PUSH B','INC D','IN A','NOT A','MUL B,C'};
single_opcode=[2 4 5 6 9 10 12 13 15 17 19 20];
double_instruction={'MOV, D','MOV, B','MOV, C','SUB A'};
double_opcode=[16 25 26 27];
triple_instruction={'IN','CALL','XCHG ','JA','OR ','PUSH','POP','MOV B','TEST'};
triple_opcode=[3 7 8 11 14 21 22 23 24];

%file operation
fp=fopen('Code.txt.','r');
fid=fopen('Code.bin','w');
dec=0;
fwrite(fid,dec);
tline = fgetl(fp)

while ischar(tline)
 
    single=0;    
    double=0;    
    triple=0;          
    value=0; 

    for i=1:length(single_instruction)
        if  strcmpi(single_instruction(i),tline)
            dec=single_opcode(i)
            fwrite(fid,dec); 
            single=1;    
            break;
        end       
    end
     
     
    if(single==0)
       for i=1:length(double_instruction)
           
           if    strncmpi(double_instruction(i),tline,length(char(double_instruction(i))))
                 dec=double_opcode(i)     
                 fwrite(fid,dec) ;   
                 
                 temp=length(char(double_instruction(i)));
                 byte=tline(temp+2:temp+3);      
                 if      strcmpi(tline(temp+4),'H')||strcmpi(tline(temp+4),'h')
                         dec=hex2dec(byte)
                 elseif strcmpi(tline(temp+4),'D')||strcmpi(tline(temp+4),'d')||strcmpi(tline(temp+4),'')
                         dec=byte
                 end
                 fwrite(fid,dec);        
                 double=1;    
                 break;
           end       
       end
    end
    
    if(single==0 && double==0)
        
        for i=1:length(triple_instruction)
                if  (strncmpi(triple_instruction(i),tline,length(char(triple_instruction(i)))))
                    dec=triple_opcode(i)     
                    fwrite(fid,dec);    
                    temp=length(char(triple_instruction(i)));
                    if(i==3 || i==5)        %for CALL/JBE
                            gap=[2 4];       
                    else    gap=[3 5];  
                    end
                    
                    byte=tline(temp+gap(1):temp+gap(1)+1)
                    dec=hex2dec(byte);
                    fwrite(fid,dec);    
                    
                    byte=tline(temp+gap(2):temp+gap(2)+1)
                    dec=hex2dec(byte);
                    fwrite(fid,dec);    
                    triple=1;        
                    break;
                end
               
            end
    end

    if (single==0 && double==0 && triple==0 )

        byte=tline(1:2)
        if  strcmpi(tline(3),'H')||strcmpi(tline(3),'h')
                     dec=hex2dec(byte)
        elseif strcmpi(tline(3),'D')||strcmpi(tline(3),'d')||strcmpi(tline(3),'')
                     dec=byte
        end
        
        fwrite(fid,dec);
        value=1;
    end
    
   
    if(single==0 && double==0 && triple==0 && value==0 )
         disp('Error in Code.....Aborting.......');     
         break;
    end
    
    %reading next instruction
    tline = fgetl(fp);
   
end

fclose(fp);
fclose(fid);

