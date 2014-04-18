function [result] = steganography(image,secret_message,password,encoding_or_decoding,output_file_name);
% output_file_name= newfilename, 
%secret_message= string or *.txt file, 
%password= key(0-255),
%encoding_or_decoding=(1 for encoding, 2 for decoding)

if encoding_or_decoding == 1 % for ecoding
    if password < 0 || password > 255
        error('invalid key');
    end
    password = uint8(password);
   	result = encoder(image,secret_message,password);    
    if ischar(output_file_name) == 1
        imwrite(result,strcat(output_file_name,'.bmp'));
    else
        error('file name invalid');
    end
    
    
elseif encoding_or_decoding == 2 % for decoding
    if password < 0 || password > 255
        error('invalid key');
    end
    password = uint8(password);
    result = decoder(image,password);
    if ischar(output_file_name) == 1
        sec_file = fopen(strcat(output_file_name,'.txt'),'w');
        fwrite(sec_file,result,'char');
        fclose(sec_file);        
    else
        error('file name invalid');
    end
else
    error('invalid, neither encoding nor decoding selected');
end

