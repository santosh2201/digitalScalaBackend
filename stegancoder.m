function [J] = stegancoder(img,msg,enc_key)
it=imread(img);
msgtype = ischar(msg);  
msg_temp = double(msg);     % Converts from ASCII to Integer Values.	
msg_dim = num2str(length(msg_temp));
msg_length = length(msg_dim);
z = 0;
    if msg_length < 7
        padtext = 7 - msg_length;
        for z = 1:padtext
            msg_dim = horzcat('0',msg_dim);
        end
        msg_head = horzcat('t',msg_dim);
        % Applying Header To Beginning of Message to be Encoded.
        msg_temp_head = horzcat(msg_head,msg_temp);
    end

msg_enc = bitxor(uint8(msg_temp_head),uint8(enc_key));

msg_enc_set = dec2bin(msg_enc, 8);


img_prep = im2uint8(it);

rm = 1; gm = 1; bm = 1;     % Initializing Counters
rn = 1; gn = 1; bn = 1;

[maxM,maxN] = size(img_prep);
z = 0;

% RUN_TIME Variable indicates the number of Message "Words" that need to be
%   encoded in the IMG_PREP "Canvas" Image.
run_time = length(msg_enc_set);

for z = 1:run_time;
    temp_code = msg_enc_set(z,:);
    % Bit 1: Red
    if str2double(temp_code(1)) == 0
        img_prep(rm,rn,1) = bitand(img_prep(rm,rn,1),uint8(254));
    else
        img_prep(rm,rn,1) = bitor(img_prep(rm,rn,1),uint8(1));
    end
    
    rm = rm + 1;
    % This next step is used to determine whether or not we have reached
    %   the end end of the image. We then need to move to the next column
    %   and reset our pattern to the top row. Since we have no idea when we
    %   will reach this point we have to check this EVERY time after we
    %   increase the rm/gm/bm counter.
    if rm > maxM
        rn = rn + 1;
        rm = 1;
    end
    % Bit 2: Green
    if str2double(temp_code(2)) == 0
        img_prep(gm,gn,2) = bitand(img_prep(gm,gn,2),uint8(254));
    else
        img_prep(gm,gn,2) = bitor(img_prep(gm,gn,2),uint8(1));
    end
    
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
    end
    % Bit 3: Blue
    if str2double(temp_code(3)) == 0
        img_prep(bm,bn,3) = bitand(img_prep(bm,bn,3),uint8(254));
    else
        img_prep(bm,bn,3) = bitor(img_prep(bm,bn,3),uint8(1));
    end
    
    bm = bm + 1;
    if bm > maxM
        bn = bn + 1;
        bm = 1;
    end
    % Bit 4: Blue
    if str2double(temp_code(4)) == 0
        img_prep(bm,bn,3) = bitand(img_prep(bm,bn,3),uint8(254));
    else
        img_prep(bm,bn,3) = bitor(img_prep(bm,bn,3),uint8(1));
    end
    
    bm = bm + 1;
    if bm > maxM
        bn = bn + 1;
        bm = 1;
    end
    % Bit 5: Green
    if str2double(temp_code(5)) == 0
        img_prep(gm,gn,2) = bitand(img_prep(gm,gn,2),uint8(254));
    else
        img_prep(gm,gn,2) = bitor(img_prep(gm,gn,2),uint8(1));
    end
    
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
    end
    % Bit 6: Red
    if str2double(temp_code(6)) == 0
        img_prep(rm,rn,1) = bitand(img_prep(rm,rn,1),uint8(254));
    else
        img_prep(rm,rn,1) = bitor(img_prep(rm,rn,1),uint8(1));
    end
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
    end
    % Bit 7: Red
    if str2double(temp_code(7)) == 0
        img_prep(rm,rn,1) = bitand(img_prep(rm,rn,1),uint8(254));
    else
        img_prep(rm,rn,1) = bitor(img_prep(rm,rn,1),uint8(1));
    end
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
    end
    % Bit 8: Green
    if str2double(temp_code(8)) == 0
        img_prep(gm,gn,2) = bitand(img_prep(gm,gn,2),uint8(254));
    else
        img_prep(gm,gn,2) = bitor(img_prep(gm,gn,2),uint8(1));
    end
    
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
    end
    
end

%% Step 6: Final Output
J = img_prep;       % Final Encoding Output
% J = msg_enc_set;  % ENCRYPTION STEP TEST OUTPUT
end
