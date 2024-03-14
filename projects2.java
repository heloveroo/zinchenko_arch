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

        ArrayList<String> binaryNumbers = new ArrayList<>();
        for (int number : numbers) {
            binaryNumbers.add(toBinary(number));
        }

        bubbleSort(binaryNumbers);

        // Запис результатів у файл
        try (FileWriter writer = new FileWriter("result.txt")) {
            writer.write("mediana: " + calculateMedian(binaryNumbers) + "\n");
            writer.write("Average: " + calculateAverage(binaryNumbers) + "\n");
        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
        }
    }

    private static String toBinary(int number) {
        return String.format("%16s", Integer.toBinaryString(0xFFFF & number)).replace(' ', '0');
    }

    private static void bubbleSort(ArrayList<String> array) {
        boolean swapped = true;
        int j = 0;
        String tmp;
        while (swapped) {
            swapped = false;
            j++;
            for (int i = 0; i < array.size() - j; i++) {
                if (array.get(i).compareTo(array.get(i + 1)) > 0) {
                    tmp = array.get(i);
                    array.set(i, array.get(i + 1));
                    array.set(i + 1, tmp);
                    swapped = true;
                }
            }
        }
    }

    private static double calculateMedian(ArrayList<String> binaryNumbers) {
        int size = binaryNumbers.size();
        Collections.sort(binaryNumbers);
        if (size % 2 == 0) {
            return (Integer.parseInt(binaryNumbers.get(size / 2 - 1), 2)
                    + Integer.parseInt(binaryNumbers.get(size / 2), 2)) / 2.0;
        } else {
            return Integer.parseInt(binaryNumbers.get(size / 2), 2);
        }
    }

    private static double calculateAverage(ArrayList<String> binaryNumbers) {
        double sum = 0;
        for (String binary : binaryNumbers) {
            sum += Integer.parseInt(binary, 2);
        }
        return sum / binaryNumbers.size();
    }
}
