% steganography decoder function
function [msg] = decoder(image,password)
image=imread(image);
rm = 1; gm = 1; bm = 1;     
rn = 1; gn = 1; bn = 1;
header = [];
[maxM, maxN, chan] = size(image);
for z = 1:8;
    temp = zeros(1,8);
    
    temp(1,1) = mod(image(rm,rn,1),2);    
    rm = rm + 1;
    
    if rm > maxM
        rn = rn + 1;
        rm = 1;
        if rn > maxN
            break
        end
    end
   
    temp(1,2) = mod(image(gm,gn,2),2);
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
        if gn > maxN
            break
        end
    end

    temp(1,3) = mod(image(bm,bn,3),2);
    bm = bm + 1;
    if bm > maxM
        bn = bn + 1;
        bm = 1;
    end
    temp(1,4) = mod(image(bm,bn,3),2);
    bm = bm + 1;
    if bm > maxM
        bn = bn + 1;
        bm = 1;
    end
    temp(1,5) = mod(image(gm,gn,2),2);
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
        if gn > maxN
            break
        end
    end
    temp(1,6) = mod(image(rm,rn,1),2);    
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
        if rn > maxN
            break
        end
    end
    temp(1,7) = mod(image(rm,rn,1),2);    
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
        if rn > maxN
            break
        end
    end
    temp(1,8) = mod(image(gm,gn,2),2);
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
        if gn > maxN
            break
        end
    end      
    tempstr = num2str(temp);
    header = vertcat(header,tempstr);
end

msg_head_set = bin2dec(header);
temp_head = bitxor(uint8(msg_head_set),uint8(password));
    
dim1 = char(temp_head(2:8));
m = str2double(dim1');
n = 1;    


z = 0;

enc_msg = [];
stopmax = (m * n);

for z = 1:stopmax
    temp = zeros(1,8);
     
    temp(1,1) = mod(image(rm,rn,1),2);    
    rm = rm + 1;
   
    if rm > maxM
        rn = rn + 1;
        rm = 1;
        if rn > maxN
            break
        end
    end
  
    temp(1,2) = mod(image(gm,gn,2),2);
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
        if gn > maxN
            break
        end
    end
  
    temp(1,3) = mod(image(bm,bn,3),2);
    bm = bm + 1;
    if bm > maxM
        bn = bn + 1;
        bm = 1;
    end
  
    temp(1,4) = mod(image(bm,bn,3),2);
    bm = bm + 1;
    if bm > maxM
        bn = bn + 1;
        bm = 1;
    end
    
    temp(1,5) = mod(image(gm,gn,2),2);
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
        if gn > maxN
            break
        end
    end
        
    temp(1,6) = mod(image(rm,rn,1),2);    
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
        if rn > maxN
            break
        end
    end
      
    temp(1,7) = mod(image(rm,rn,1),2);    
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
        if rn > maxN
            break
        end
    end
   
    temp(1,8) = mod(image(gm,gn,2),2);
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
        if gn > maxN
            break
        end
    end      
    tempstr = num2str(temp);
    enc_msg = vertcat(enc_msg,tempstr);
end


enc_msg;
msg_dec_set = bin2dec(enc_msg);
msg_dec = bitxor(uint8(msg_dec_set),uint8(password));

    msg_set = msg_dec;
    msg_out = char(msg_set');


msg = msg_out;
end
