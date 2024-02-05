import java.io.IOException;
import java.io.FileWriter;
import java.util.*;

public class project {
    public static int[] ArrGenerator(int size) {
        int[] arr = new int[size];
        for (int i = 0; i < size; i++) {
            arr[i] = (int) Math.floor(Math.random() * (100)) + 100;
        }
        return arr;
    }

    static int getMax(int arr[], int n)
    {
        int mx = arr[0];
        for (int i = 1; i < n; i++)
            if (arr[i] > mx)
                mx = arr[i];
        return mx;
    }
 
    // A function to do counting sort of arr[] according to
    // the digit represented by exp.
    static void countSort(int arr[], int n, int exp)
    {
        int output[] = new int[n]; // output array
        int i;
        int count[] = new int[10];
        Arrays.fill(count, 0);
 
        // Store count of occurrences in count[]
        for (i = 0; i < n; i++)
            count[(arr[i] / exp) % 10]++;
 
        // Change count[i] so that count[i] now contains
        // actual position of this digit in output[]
        for (i = 1; i < 10; i++)
            count[i] += count[i - 1];
 
        // Build the output array
        for (i = n - 1; i >= 0; i--) {
            output[count[(arr[i] / exp) % 10] - 1] = arr[i];
            count[(arr[i] / exp) % 10]--;
        }
 
        // Copy the output array to arr[], so that arr[] now
        // contains sorted numbers according to current
        // digit
        for (i = 0; i < n; i++)
            arr[i] = output[i];
    }
 
    // The main function to that sorts arr[] of
    // size n using Radix Sort
    static void radixsort(int arr[], int n)
    {
        // Find the maximum number to know number of digits
        int m = getMax(arr, n);
 
        // Do counting sort for every digit. Note that
        // instead of passing digit number, exp is passed.
        // exp is 10^i where i is current digit number
        for (int exp = 1; m / exp > 0; exp *= 10)
            countSort(arr, n, exp);
    }

    /*
     * NlogN value to be graphed is 'O(nlogn)'. . . . Read through, just calculated
     * based on what I was shown.
     */
    public static void main(String[] args) {
        int[] sizes = new int[] { 100, 200, 400, 600, 800, 1000, 1250, 1500, 1750, 2000, 2250, 2500, 3000, 4000, 5000,
                6000, 7000, 8000, 9000, 10000, 11000, 12000, 13000, 14000, 15000 };

        String[] prints = new String[sizes.length];
        double[] nlognStored = new double[sizes.length];
        double global_avg = 0;
        for (int m = 0; m < sizes.length; m++) {
            int[] arr = ArrGenerator(sizes[m]);

            long heaptime = System.nanoTime();
            radixsort(arr, arr.length);
            long heapfinaltime = System.nanoTime() - heaptime;
            // double nlogn = (sizes[m]*Math.log(sizes[m]))/Math.log(2);
            double nlogn = sizes[m]*3; //(3 digits)
            double constant = heapfinaltime / nlogn;
            global_avg += constant;
            nlognStored[m] = nlogn;
            prints[m] = sizes[m] + "," + heapfinaltime + "," + constant + "," + nlogn + ",";
        }
        global_avg = global_avg / sizes.length;
        for (int m = 0; m < sizes.length; m++) {
            prints[m] += (global_avg * nlognStored[m]) + "\n";
        }

        try (FileWriter w = new FileWriter("results.txt", true);) {
            w.write("Size,Radix,constant,n,Theoretical\n");
            for (int m = 0; m < sizes.length; m++) {
                w.write(prints[m]);
            }
            w.close();
        } catch (IOException i) {
            i.printStackTrace();
        }

    }
}
