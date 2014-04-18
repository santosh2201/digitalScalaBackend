package controllers

import java.io.File
import java.io.FileOutputStream
import scala.util.control.Breaks._
import play.api._
import play.api.libs.iteratee.Enumerator
import play.api.mvc._
import sun.misc.BASE64Decoder
import scalax.io.support.FileUtils
import java.nio.file.Files
import java.io.BufferedWriter
import java.io.FileWriter
object Application extends Controller {

  def index = Action {
    Ok(views.html.index("Your new application is ready."))
  }
  def createMakeFile(message:String,encode:Boolean)={
     val makeFile = new File("Makefile");
    if(makeFile.exists()){
      makeFile.delete();
    }
    var makeString=""
    if(encode){
     makeString ="""all:
	octave3.8 --silent --eval "steganography(\"image.jpg\",\""""+message+"""\",1,1,\"output\")""""
        
    }else{
    	makeString="""all:
	octave3.8 --silent --eval "steganography(\"decode.bmp\",\"message\",1,2,\"output\")""""
    }
    val fw = new FileWriter(makeFile.getAbsoluteFile(), false);
			val bw = new BufferedWriter(fw);
			bw.write(makeString);
			bw.close();
  }
  
  def store = Action(parse.multipartFormData)  { implicit request =>
    val postData = request.body.asFormUrlEncoded // excetion check required
    val userMessage=postData.get("user_message").get(0)
     val encode=postData.get("encode").get(0)
    
    
    
   println(userMessage,encode)
    
    if(encode.contentEquals("true")){
			      val of = new File("image.jpg");
			    if(of.exists()){
			      of.delete();
			    }
		       request.body.file("image").map { picture =>
			    val filename = picture.filename 
			    val contentType = picture.contentType
			    picture.ref.moveTo(new File("image.jpg"))
		    }
    		
    		createMakeFile(userMessage, true)
    		 val source = new File("output.bmp");
			    if(source.exists()){
			      source.delete();
			    }
			    
			    val pr = Runtime.getRuntime().exec("make");
			    
			    while(!source.exists()){
			      Thread.sleep(1000);
			    }
			    val  dest = new File("public/output/output.bmp");
			    if(dest.exists() ) { 
			      dest.delete();
			    }
			    Files.copy(source.toPath(), dest.toPath())
			    Ok("assets/output/output.bmp");
    }else{
    		 val of = new File("decode.bmp");
			    if(of.exists()){
			      of.delete();
			    }
			    val output = new File("output.txt");
			    if(output.exists()){
			      output.delete();
			      
			    }
	    	 request.body.file("image").map { picture =>
		    val filename = picture.filename 
		    val contentType = picture.contentType
		    picture.ref.moveTo(new File("decode.bmp"),true)
		    
	    }
	    	 createMakeFile(userMessage, false)
	    	  val pr = Runtime.getRuntime().exec("make");
	    	 while(!output.exists()){
			      Thread.sleep(1000);
			    }
	    	 val outputString = scala.io.Source.fromFile("output.txt").mkString
	    	 
	    	 Ok(outputString);
    	
    }
    
   
     
     
   
  }

}