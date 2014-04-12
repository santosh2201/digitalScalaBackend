<?php 
$data = file_get_contents("output.bmp");
$base64 = 'data:image/' . $type . ';base64,' . base64_encode($data);
echo $base64;
$File = "base64.txt"; 
$Handle = fopen($File, 'w'); 
fwrite($Handle, $base64); 
fclose($Handle);
?>
