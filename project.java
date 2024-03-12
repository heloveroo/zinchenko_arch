import java.util.Scanner;
import java.util.ArrayList;
import java.io.File;
import java.io.FileNotFoundException;

public class project {
    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Будь ласка, передайте ім'я файлу як аргумент.");
            return;
        }
        File file = new File(args[0]);
        Scanner scanner = null;

        try {
            scanner = new Scanner(file);
            ArrayList<Integer> numbers = new ArrayList<>();

            while (scanner.hasNextLine()) {
                String line = scanner.nextLine();
                if (line.length() > 255) {
                    System.out.println("Помилка: рядок перевищує максимальну довжину");
                    continue;
                }

                String[] tokens = line.split("\\s+");
                for (String token : tokens) {
                    try {
                        int number = Integer.parseInt(token);
                        numbers.add(number);
                        if (numbers.size() > 10000) {
                            System.out.println("Помилка: кількість чисел перевищує максимальний розмір");
                            return;
                        }
                    } catch (NumberFormatException e) {
                        System.out.println("Помилка: Введено нечислове значення");
                    }
                }
            }

            System.out.println("Зчитані числа:");
            for (Integer number : numbers) {
                System.out.println(number);
            }

        } catch (FileNotFoundException e) {
            System.out.println("Файл не знайдено: " + e.getMessage());
        } finally {
            if (scanner != null) {
                scanner.close();
            }
        }
    }
}
