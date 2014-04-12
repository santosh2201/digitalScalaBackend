function [output] = steganography(img,msg,enc_key,enc_dec,secfn)% secfn= newfilename, msg= *.txt, enc_key=key(0-255), enc_dec=(1 for encoding, 2 for decoding)
%enc_dec = input('Welcome to the Steganography Program \nEnter 1 for Encoding, 2 for Decoding:\n');

if enc_dec == 1
  %  [FileName,PathName] = uigetfile({'*.jpg';'*.png';'*.gif';'*.bmp'},'Select "Canvas Image" to Hide Message.');
   % img = imread( strcat(PathName,FileName) );
    %msg_type = input('Enter 1 for TEXT Message, 2 for IMAGE Message:\n');
    %if msg_type == 1
    %[FileName,PathName] = uigetfile('*.txt','Select TEXT MESSAGE.');
    %testmsg = fopen( strcat(PathName,FileName) );
    %[msg] = fscanf(msg,'%c');
    
    %% STEP 3A: Prompt User for Encryption Key
    %enc_key = input('Please Enter an Encryption Key Between 0 - 255:\n');
    if enc_key < 0 || enc_key > 255
        error('Invalid Key Selection');
    end
    
    enc_key = uint8(enc_key);
    
    % SEQUENTIAL ENCODING: This only needs an Encryption Key Input.
    output = stegancoder(img,msg,enc_key);
    
   % secfn = input('Enter File Name for Image + Message:\n','s');
    nametest = ischar(secfn);
    if nametest == 1
        imwrite(output,strcat(secfn,'.bmp'));
    else
        error('Invalid File Name');
    end
    
elseif enc_dec == 2
   % [FileName,PathName] = uigetfile('*.bmp','Select "Canvas Image" With Hidden Message.');
    %img = imread( strcat(PathName,FileName) );
    
   % enc_key = input('Please Enter an Encryption Key Between 0 - 255:\n');
    if enc_key < 0 || enc_key > 255
        error('Invalid Key Selection');
    end
    
    enc_key = uint8(enc_key);
    
    output = stegandecoder(img,enc_key);
    
   % secfn = input('Enter File Name for Image + Message:\n','s');
    nametest = ischar(secfn);
    if nametest == 1
        %msgtest = ischar(output);
        % TEXT Message CASE
        fid = fopen(strcat(secfn,'.txt'),'w');
        fwrite(fid,output,'char');
        fclose(fid);
        
    else
        error('Invalid File Name');
    end
    
else
    error('Invalid Selection');
end






