import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class project {
    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Будь ласка, вкажіть ім'я файлу як аргумент командного рядка.");
            return;
        }

        File file = new File(args[0]);
        ArrayList<Integer> numbers = new ArrayList<>();

        try (Scanner scanner = new Scanner(file)) {
            while (scanner.hasNextLine()) {
                String line = scanner.nextLine();
                String[] tokens = line.split("\\s+");
                for (String token : tokens) {
                    try {
                        int number = Integer.parseInt(token);
                        if (number > 32767)
                            number = 32767;
                        if (number < -32768)
                            number = -32768;
                        numbers.add(number);
                    } catch (NumberFormatException e) {
                        System.out.println("Помилка: Введено нечислове значення");
                    }
                }
                if (numbers.size() >= 10000)
                    break; // Перериваємо читання, якщо досягнуто ліміту
            }
        } catch (IOException e) {
            System.out.println("Помилка при читанні файлу: " + e.getMessage());
            return;
        }

        ArrayList<String> binaryNumbers = new ArrayList<>();
        for (int number : numbers) {
            binaryNumbers.add(String.format("%16s", Integer.toBinaryString(0xFFFF & number)).replace(' ', '0'));
        }

        bubbleSort(binaryNumbers);

        try (FileWriter writer = new FileWriter("output.txt")) {
            writer.write("Відсортовані бінарні представлення чисел:\n");
            for (String binary : binaryNumbers) {
                writer.write(binary + "\n");
            }

            // Обчислення медіани
            double median;
            int size = binaryNumbers.size();
            if (size % 2 == 0) {
                median = (Integer.parseInt(binaryNumbers.get(size / 2 - 1), 2)
                        + Integer.parseInt(binaryNumbers.get(size / 2), 2)) / 2.0;
            } else {
                median = Integer.parseInt(binaryNumbers.get(size / 2), 2);
            }

            // Обчислення середнього
            double average = 0;
            for (String binary : binaryNumbers) {
                average += Integer.parseInt(binary, 2);
            }
            average /= size;

            writer.write("Медіана: " + median + "\n");
            writer.write("Середнє: " + average + "\n");
        } catch (IOException e) {
            System.out.println("Помилка при записі у файл: " + e.getMessage());
        }
    }

    private static void bubbleSort(ArrayList<String> array) {
        int n = array.size();
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (array.get(j).compareTo(array.get(j + 1)) > 0) {
                    // swap temp and arr[i]
                    String temp = array.get(j);
                    array.set(j, array.get(j + 1));
                    array.set(j + 1, temp);
                }
            }
        }
    }
}
