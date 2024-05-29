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
}
