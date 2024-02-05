import java.io.IOException;
import java.io.FileWriter;
import java.util.Arrays;

public class project {

    // GFG Jump Search
    public static int jumpSearch(int[] arr, int x) {
        int n = arr.length;

        // Finding block size to be jumped
        int step = (int) Math.floor(Math.sqrt(n));

        // Finding the block where element is
        // present (if it is present)
        int prev = 0;
        while (arr[Math.min(step, n) - 1] < x) {
            prev = step;
            step += (int) Math.floor(Math.sqrt(n));
            if (prev >= n)
                return -1;
        }

        // Doing a linear search for x in block
        // beginning with prev.
        while (arr[prev] < x) {
            prev++;

            // If we reached next block or end of
            // array, element is not present.
            if (prev == Math.min(step, n))
                return -1;
        }

        // If element is found
        if (arr[prev] == x)
            return prev;

        return -1;
    }

    // GFG Binary Search
    public static int binarySearch(int arr[], int l, int r, int x) {
        if (r >= l) {
            int mid = l + (r - l) / 2;

            // If the element is present at the
            // middle itself
            if (arr[mid] == x)
                return mid;

            // If element is smaller than mid, then
            // it can only be present in left subarray
            if (arr[mid] > x)
                return binarySearch(arr, l, mid - 1, x);

            // Else the element can only be present
            // in right subarray
            return binarySearch(arr, mid + 1, r, x);
        }

        // We reach here when element is not present
        // in array
        return -1;
    }

    // GFG Interpolation
    public static int interpolationSearch(int arr[], int lo,
            int hi, int x) {
        int pos;

        // Since array is sorted, an element
        // present in array must be in range
        // defined by corner
        if (lo <= hi && x >= arr[lo] && x <= arr[hi]) {

            // Probing the position with keeping
            // uniform distribution in mind.
            pos = lo
                    + (((hi - lo) / (arr[hi] - arr[lo]))
                            * (x - arr[lo]));

            // Condition of target found
            if (arr[pos] == x)
                return pos;

            // If x is larger, x is in right sub array
            if (arr[pos] < x)
                return interpolationSearch(arr, pos + 1, hi,
                        x);

            // If x is smaller, x is in left sub array
            if (arr[pos] > x)
                return interpolationSearch(arr, lo, pos - 1,
                        x);
        }
        return -1;
    }

    // GFG Ternary Search
    static int ternarySearch(int l, int r, int key, int ar[]) {
        if (r >= l) {

            // Find the mid1 and mid2
            int mid1 = l + (r - l) / 3;
            int mid2 = r - (r - l) / 3;

            // Check if key is present at any mid
            if (ar[mid1] == key) {
                return mid1;
            }
            if (ar[mid2] == key) {
                return mid2;
            }

            // Since key is not present at mid,
            // check in which region it is present
            // then repeat the Search operation
            // in that region

            if (key < ar[mid1]) {

                // The key lies in between l and mid1
                return ternarySearch(l, mid1 - 1, key, ar);
            } else if (key > ar[mid2]) {

                // The key lies in between mid2 and r
                return ternarySearch(mid2 + 1, r, key, ar);
            } else {

                // The key lies in between mid1 and mid2
                return ternarySearch(mid1 + 1, mid2 - 1, key, ar);
            }
        }

        // Key not found
        return -1;
    }

    public static int[] ArrGenerator(int size) {
        int[] arr = new int[size];
        for (int i = 0; i < size; i++) {
            arr[i] = (int) Math.floor(Math.random() * (50000));
        }
        return arr;
    }

    // GFG Exponential Search
    static int exponentialSearch(int arr[],
            int n, int x) {
        // If x is present at first location itself
        if (arr[0] == x)
            return 0;

        // Find range for binary search by
        // repeated doubling
        int i = 1;
        while (i < n && arr[i] <= x)
            i = i * 2;

        // Call binary search for the found range.
        return Arrays.binarySearch(arr, i / 2,
                Math.min(i, n - 1), x);
    }

    // GFG fib Helper function
    public static int min(int x, int y) {
        return (x <= y) ? x : y;
    }

    // GFG Fibonacci Search
    public static int fibMonaccianSearch(int arr[], int x,
            int n) {
        /* Initialize fibonacci numbers */
        int fibMMm2 = 0; // (m-2)'th Fibonacci No.
        int fibMMm1 = 1; // (m-1)'th Fibonacci No.
        int fibM = fibMMm2 + fibMMm1; // m'th Fibonacci

        /*
         * fibM is going to store the smallest
         * Fibonacci Number greater than or equal to n
         */
        while (fibM < n) {
            fibMMm2 = fibMMm1;
            fibMMm1 = fibM;
            fibM = fibMMm2 + fibMMm1;
        }

        // Marks the eliminated range from front
        int offset = -1;

        /*
         * while there are elements to be inspected.
         * Note that we compare arr[fibMm2] with x.
         * When fibM becomes 1, fibMm2 becomes 0
         */
        while (fibM > 1) {
            // Check if fibMm2 is a valid location
            int i = min(offset + fibMMm2, n - 1);

            /*
             * If x is greater than the value at
             * index fibMm2, cut the subarray array
             * from offset to i
             */
            if (arr[i] < x) {
                fibM = fibMMm1;
                fibMMm1 = fibMMm2;
                fibMMm2 = fibM - fibMMm1;
                offset = i;
            }

            /*
             * If x is less than the value at index
             * fibMm2, cut the subarray after i+1
             */
            else if (arr[i] > x) {
                fibM = fibMMm2;
                fibMMm1 = fibMMm1 - fibMMm2;
                fibMMm2 = fibM - fibMMm1;
            }

            /* element found. return index */
            else
                return i;
        }

        /* comparing the last element with x */
        if (fibMMm1 == 1 && arr[n - 1] == x)
            return n - 1;

        /* element not found. return -1 */
        return -1;
    }

    public static void main(String[] args) {

        long binarytot =0;
        long Jumptot =0;
        long Interpolationtot =0;
        long Ternarytot =0;
        long Exponentialtot =0;
        long Fibonaccitot =0;


        try (FileWriter w = new FileWriter("results.txt", true);) {
            w.write("SearchValue,Binary,Jump,Interpolation,Ternary,Exponential,Fibonacci\n");
        } catch (IOException i) {
            i.printStackTrace();
        }
        for (int run = 0; run < 10; run++) {
            // Create an array of size 20,000 with values 1-50,000
            int[] arr = ArrGenerator(20000);
            // Select an index randomly from 1-20,000 to search for.
            int SearchFor = (int) Math.floor(Math.random() * (20000));
            // Sorting the array in ascending order.
            Arrays.sort(arr);

            long binaryt = System.nanoTime();
            int found = binarySearch(arr, 0, arr.length, SearchFor);
            long binaryft = System.nanoTime() - binaryt;
            binarytot += binaryft;

            long Jumpt = System.nanoTime();
            int Jump = jumpSearch(arr, SearchFor);
            long Jumpft = System.nanoTime() - Jumpt;
            Jumptot += Jumpft;

            long Interpolationt = System.nanoTime();
            int Interpolation = interpolationSearch(arr, 0, arr.length-1, SearchFor);
            long Interpolationft = System.nanoTime() - Interpolationt;
            Interpolationtot += Interpolationft;

            long Ternaryt = System.nanoTime();
            int Ternary = ternarySearch(0, arr.length, SearchFor, arr);
            long Ternaryft = System.nanoTime() - Ternaryt;
            Ternarytot += Ternaryft;

            long Exponentialt = System.nanoTime();
            int Exponential = exponentialSearch(arr, arr.length, SearchFor);
            long Exponentialft = System.nanoTime() - Exponentialt;
            Exponentialtot += Exponentialft;

            long Fibonaccit = System.nanoTime();
            int Fibonacci = fibMonaccianSearch(arr, SearchFor, arr.length);
            long Fibonaccift = System.nanoTime() - Fibonaccit;
            Fibonaccitot += Fibonaccift;

            try (FileWriter w = new FileWriter("results.txt", true);) {
                w.write(SearchFor + "," + binaryft + "," + Jumpft + "," + Interpolationft + "," + Ternaryft + ","
                        + Exponentialft + "," + Fibonaccift + "\n");
                w.close();
            } catch (IOException i) {
                i.printStackTrace();
            }
        }
        try (FileWriter w = new FileWriter("results.txt", true);) {
            w.write("Averages," + binarytot/10 + "," + Jumptot/10 + "," + Interpolationtot/10 + "," + Ternarytot/10 + ","
                    + Exponentialtot/10 + "," + Fibonaccitot/10 + "\n");
            w.close();
        } catch (IOException i) {
            i.printStackTrace();
        }
    }
}
