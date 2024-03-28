import java.util.Scanner;
import java.util.ArrayList;

public class projects2 {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ArrayList<Integer> numbers = new ArrayList<>();

        // Reading numbers until EOF
        while (scanner.hasNextInt()) {
            int number = scanner.nextInt();
            // Limiting the value within the 16-bit range
            if (number > 32767) {
                number = 32767;
            } else if (number < -32768) {
                number = -32768;
            }
            numbers.add(number);
        }

        // Sorting the decimal numbers before converting to binary format
        bubbleSortIntegers(numbers);

        // Converting sorted numbers to binary format
        ArrayList<String> binaryNumbers = new ArrayList<>();
        for (int number : numbers) {
            binaryNumbers.add(toBinary(number));
        }

        // Calculating and displaying median and average values
        double median = calculateMedian(numbers);
        double average = calculateAverage(numbers);
        System.out.println((int) median); // Displaying the median in the console
        System.out.println((int) average); // Displaying the average in the console
    }

    // Bubble sort for integers
    private static void bubbleSortIntegers(ArrayList<Integer> arr) {
        int n = arr.size();
        for (int i = 0; i < n - 1; i++)
            for (int j = 0; j < n - i - 1; j++)
                if (arr.get(j) > arr.get(j + 1)) {
                    // Swap arr[j+1] and arr[j]
                    int temp = arr.get(j);
                    arr.set(j, arr.get(j + 1));
                    arr.set(j + 1, temp);
                }
    }

    // Converting to binary with padding to ensure 16 characters
    private static String toBinary(int number) {
        return String.format("%16s", Integer.toBinaryString(0xFFFF & number)).replace(' ', '0');
    }

    // Calculating median
    private static double calculateMedian(ArrayList<Integer> numbers) {
        int size = numbers.size();
        if (size % 2 == 0) {
            return (numbers.get(size / 2 - 1) + numbers.get(size / 2)) / 2.0;
        } else {
            return numbers.get(size / 2);
        }
    }

    // Calculating average
    private static double calculateAverage(ArrayList<Integer> numbers) {
        double sum = 0;
        for (int number : numbers) {
            sum += number;
        }
        return sum / numbers.size();
    }
}