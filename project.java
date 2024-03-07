import java.util.Scanner;
import java.util.ArrayList;

public class project {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ArrayList<Integer> numbers = new ArrayList<>();
        while (scanner.hasNext()) {
            String line = scanner.nextLine();
            if (line.length() > 225) {
                System.out.println("Помилка:рядок перевищує максимальну довжину");
                break;
            }
            String[] tokens = line.split("\\s+");
            for (String token : tokens) {
                try {
                    int number = Integer.parseInt(token);
                    numbers.add(number);
                    if (number.size() > 10000) {
                        System.out.println("Помилка: число перевищує максимальний розмір");
                        return;
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Помилка: Введено нечислове значення.");
                }
            }
        }
        System.out.println("Зчитані числа:");
        for (Integer number : numbers) {
            System.out.println(number);
    }
}