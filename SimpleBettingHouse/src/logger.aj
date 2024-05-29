import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.Calendar;
import org.aspectj.lang.JoinPoint;
import com.bettinghouse.*;


public aspect logger {
pointcut signUp(User user): execution(* BettingHouse.successfulSignUp(..)) && args(user, ..);
    
 pointcut logIn(User user): execution(* BettingHouse.effectiveLogIn(..)) && args(user);
 
 pointcut logOut(User user): execution(* BettingHouse.effectiveLogOut(..)) && args(user);

 after(User user): signUp(user) {
     logAction("Register.txt", "Registrar usuario", user.getNickname());
 }
 after(User user): logIn(user) {
     logAction("Log.txt", "Iniciar sesión", user.getNickname());
 }

 after(User user): logOut(user) {
     logAction("Log.txt", "Cerrar sesión", user.getNickname());
 }
 private void logAction(String file, String action, String username) {
     try (PrintWriter writer = new PrintWriter(new FileOutputStream(file, true))) {
         writer.write("Acción: " + action + ", Usuario: " + username + ", Fecha: " + LocalDateTime.now().getDayOfMonth()+"/"+LocalDateTime.now().getMonthValue()+"/"+LocalDateTime.now().getYear()+" Hora:"+LocalDateTime.now().getHour()+"-"+LocalDateTime.now().getMinute() + "\n");
     } catch (Exception e) {
         System.out.println(e.getMessage());
     }
 }
 
}
