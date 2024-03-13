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
            ArrayList<String> binaryNumbers = new ArrayList<>();

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
                        if (number > 32767)
                            number = 32767;
                        if (number < -32768)
                            number = -32768;
                        binaryNumbers
                                .add(String.format("%16s", Integer.toBinaryString(0xFFFF & number)).replace(' ', '0')); // Додавання
                                                                                                                        // ведучих
                                                                                                                        // нулів
                    } catch (NumberFormatException e) {
                        System.out.println("Помилка: Введено нечислове значення");
                    }
                }
            }

            System.out.println("Бінарні представлення чисел:");
            for (String binary : binaryNumbers) {
                System.out.println(binary);
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
