import java.util.Scanner;
import java.util.ArrayList;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Collections;

public class projects2 {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ArrayList<Integer> numbers = new ArrayList<>();

        // Читання чисел до EOF
        while (scanner.hasNextInt()) {
            int number = scanner.nextInt();
            // Обмеження значення в межах 16-бітного діапазону
            if (number > 32767)
                number = 32767;
            else if (number < -32768)
                number = -32768;
            numbers.add(number);
        }
// Виведення чисел до сортування
System.out.println("Numbers before sorting: " + numbers);

// Сортування
Collections.sort(numbers);

// Виведення чисел після сортування
System.out.println("Numbers after sorting: " + numbers);
        // Спочатку сортуємо десяткові числа
        Collections.sort(numbers);

        // Потім конвертуємо відсортовані числа в бінарний формат
        ArrayList<String> binaryNumbers = new ArrayList<>();
        for (int number : numbers) {
            binaryNumbers.add(toBinary(number));
        }

        // Обчислення медіани та середнього значення на основі відсортованих десяткових чисел
        double median = calculateMedian(numbers); // Змінили на вхідний список десяткових чисел
        double average = calculateAverage(numbers); // Змінили на вхідний список десяткових чисел

        System.out.println((int)median); // Вивід медіани в консоль
        System.out.println((int)average); // Вивід середнього значення в консоль

        // Запис результатів у файл
        try (FileWriter writer = new FileWriter("result.txt")) {
            writer.write("Mediana: " + median + "\n");
            writer.write("Average: " + average + "\n");
        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
        }
    }

    private static String toBinary(int number) {
        return String.format("%16s", Integer.toBinaryString(0xFFFF & number)).replace(' ', '0');
    }

    // Змінені методи для роботи з десятковими числами
    private static double calculateMedian(ArrayList<Integer> numbers) {
        int size = numbers.size();
        if (size % 2 == 0) {
            return (numbers.get(size / 2 - 1) + numbers.get(size / 2)) / 2.0;
        } else {
            return numbers.get(size / 2);
        }
    }

    private static double calculateAverage(ArrayList<Integer> numbers) {
        double sum = 0;
        for (int number : numbers) {
            sum += number;
        }
        return sum / numbers.size();
    }
}
