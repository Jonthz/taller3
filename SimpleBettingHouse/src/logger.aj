import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.Calendar;
import org.aspectj.lang.JoinPoint;
import com.bettinghouse.Person;
import com.bettinghouse.User;


public aspect logger {
File file1 = new File("Register.txt");
File file2 = new File("Log.txt");
pointcut signUp(User user): execution(* BettingHouse.successfulSignUp(..)) && args(user, ..);
    
 pointcut logIn(User user): execution(* BettingHouse.effectiveLogIn(..)) && args(user);
 
 pointcut logOut(User user): execution(* BettingHouse.effectiveLogOut(..)) && args(user);

 after(User user): signUp(user) {
     logAction(file1, "Registrar usuario", user.getNickname());
 }
 after(User user): logIn(user) {
     logAction(file2, "Iniciar sesión", user.getNickname());
 }

 after(User user): logOut(user) {
     logAction(file2, "Cerrar sesión", user.getNickname());
 }
 private void logAction(File file, String action, String username) {
     try (PrintWriter writer = new PrintWriter(new FileOutputStream(file, true))) {
         writer.write("Acción: " + action + ", Usuario: " + username + ", Fecha: " + LocalDateTime.now().getDayOfMonth()+"/"+LocalDateTime.now().getMonthValue()+"/"+LocalDateTime.now().getYear()+" Hora:"+LocalDateTime.now().getHour()+"-"+LocalDateTime.now().getMinute() + "\n");
         System.out.println("Hola");
     } catch (Exception e) {
         System.out.println(e.getMessage());
     }
 }
 
}
