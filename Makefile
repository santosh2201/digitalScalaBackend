all:

	octave3.8 --silent --eval "steganography(\"image.jpg\",\"message\",1,1,\"output\")"
	javac test.java

	#php test.php
	#octave3.8 steganography("sa.jpg","file.txt",1,1,"bs")
	java test
	

