package controllers
import java.io.File
import play.api._
import play.api.mvc._
import java.io.FileOutputStream
import java.io.BufferedReader;
import java.io.InputStreamReader;
import scala.util.control.Breaks._

import sun.misc.BASE64Encoder;
import sun.misc.BASE64Decoder;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import javax.imageio.ImageIO;
import scala.io.Source
import java.io.IOException;

object Application extends Controller {

  def index = Action {
    Ok(views.html.index("Your new application is ready."))
  }
  def store = Action { implicit request =>
    val postData = request.body.asFormUrlEncoded // excetion check required
    val image = postData.get.get("image").get(0)
    val btDataFile = new sun.misc.BASE64Decoder().decodeBuffer(image);
    val of = new File("image.jpg");
    val osf = new FileOutputStream(of);
    osf.write(btDataFile)
    osf.flush();

    val pr = Runtime.getRuntime().exec("make");
    //pr.waitFor();

    var imageString = "";
    var bos = new ByteArrayOutputStream();

    try {
      var image = ImageIO.read(new File("output.bmp"));

      ImageIO.write(image, "bmp", bos);
      var imageBytes = bos.toByteArray();

      var encoder = new BASE64Encoder();
      imageString = encoder.encode(imageBytes);
      println(imageString);
      bos.close();
    } catch {
      case t => println(t)
    }

    /*val pr1 = Runtime.getRuntime().exec("javac test.java|java test");
    pr1.waitFor()*/
    /*    val encImage = new StringBuilder
for(line <- Source.fromFile("base64.txt").getLines()){
  encImage.append(line)
  println(line)
}*/

    //   println(image)

    //Ok(encImage.toString())
    Ok(imageString)
  }

}