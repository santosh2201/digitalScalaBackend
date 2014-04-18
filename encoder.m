% steganography encoder function
function [J] = encoder(image,message,password);
it=imread(image);
messagetype = ischar(message);  
message_temp = double(message);     	
message_dim = num2str(length(message_temp));
message_length = length(message_dim);
z = 0;
    if message_length < 7
        padtext = 7 - message_length;
        for z = 1:padtext
            message_dim = horzcat('0',message_dim);
        end
        message_head = horzcat('t',message_dim);
        message_temp_head = horzcat(message_head,message_temp);
    end

message_enc = bitxor(uint8(message_temp_head),uint8(password));
message_enc_set = dec2bin(message_enc, 8);
image_prep = im2uint8(it);
rm = 1; gm = 1; bm = 1;     
rn = 1; gn = 1; bn = 1;
[maxM,maxN] = size(image_prep);
z = 0;
run_time = length(message_enc_set);
for z = 1:run_time;
    temp_code = message_enc_set(z,:);
   
    if str2double(temp_code(1)) == 0
        image_prep(rm,rn,1) = bitand(image_prep(rm,rn,1),uint8(254));
    else
        image_prep(rm,rn,1) = bitor(image_prep(rm,rn,1),uint8(1));
    end
    
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
    end
  
    if str2double(temp_code(2)) == 0
        image_prep(gm,gn,2) = bitand(image_prep(gm,gn,2),uint8(254));
    else
        image_prep(gm,gn,2) = bitor(image_prep(gm,gn,2),uint8(1));
    end
    
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
    end
 
    if str2double(temp_code(3)) == 0
        image_prep(bm,bn,3) = bitand(image_prep(bm,bn,3),uint8(254));
    else
        image_prep(bm,bn,3) = bitor(image_prep(bm,bn,3),uint8(1));
    end
    
    bm = bm + 1;
    if bm > maxM
        bn = bn + 1;
        bm = 1;
    end
 
    if str2double(temp_code(4)) == 0
        image_prep(bm,bn,3) = bitand(image_prep(bm,bn,3),uint8(254));
    else
        image_prep(bm,bn,3) = bitor(image_prep(bm,bn,3),uint8(1));
    end
    
    bm = bm + 1;
    if bm > maxM
        bn = bn + 1;
        bm = 1;
    end

    if str2double(temp_code(5)) == 0
        image_prep(gm,gn,2) = bitand(image_prep(gm,gn,2),uint8(254));
    else
        image_prep(gm,gn,2) = bitor(image_prep(gm,gn,2),uint8(1));
    end
    
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
    end
 
    if str2double(temp_code(6)) == 0
        image_prep(rm,rn,1) = bitand(image_prep(rm,rn,1),uint8(254));
    else
        image_prep(rm,rn,1) = bitor(image_prep(rm,rn,1),uint8(1));
    end
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
    end
  
    if str2double(temp_code(7)) == 0
        image_prep(rm,rn,1) = bitand(image_prep(rm,rn,1),uint8(254));
    else
        image_prep(rm,rn,1) = bitor(image_prep(rm,rn,1),uint8(1));
    end
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
    end
 
    if str2double(temp_code(8)) == 0
        image_prep(gm,gn,2) = bitand(image_prep(gm,gn,2),uint8(254));
    else
        image_prep(gm,gn,2) = bitor(image_prep(gm,gn,2),uint8(1));
    end
    
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
    end
    
end
J = image_prep;      
end
