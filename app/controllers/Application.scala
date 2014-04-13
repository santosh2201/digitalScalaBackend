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
object Application extends Controller {

  def index = Action {
    Ok(views.html.index("Your new application is ready."))
  }
  def store = Action(parse.multipartFormData)  { implicit request =>
    //val postData = request.body.asFormUrlEncoded // excetion check required
 
    
    val of = new File("image.jpg");
    if(of.exists()){
      of.delete();
    }
    request.body.file("image").map { picture =>
	    val filename = picture.filename 
	    val contentType = picture.contentType
	    picture.ref.moveTo(new File("image.jpg"))
    }
    val source = new File("output.bmp");
    if(source.exists()){
      source.delete();
    }
    val pr = Runtime.getRuntime().exec("make");
    
    while(!source.exists()){
      Thread.sleep(1000);
    }
    val  dest = new File("public/output/output.bmp");
    if(dest.exists() ) { /* do something */ 
      dest.delete();
    }
    Files.copy(source.toPath(), dest.toPath());
     
     
    Ok("assets/output/output.bmp");
  }

}