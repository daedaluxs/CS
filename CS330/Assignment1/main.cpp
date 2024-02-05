#include <stdio.h>
#include <iostream>
#include <string>
#include <sstream>
#include <cmath>
#include <cstring>

using namespace std;

int sum_positive(int arr[])
{
    int sum = 0;
    for (int x =0;x<5;x++){
        if(arr[x]>0){
            sum += arr[x];
        }
    }
    return sum;
}

void revString(string& str)
{
    int len = str.length();
    int n = len-1;
    int i = 0;
    while(i<=n){
        swap(str[i],str[n]);
        n = n-1;
        i = i+1;
  }
 
}

int main()
{
    //-=-Problem 1-=-
    int input;
    do{
        cout << "Enter: ";
        cin >> input; 
    }while(floor(sqrt(input)) != sqrt(input));
    cout << "Accepted" << "\n";

    //-=-Problem 2-=-
    int arr[] = {2,-5,6,-3,1};
    cout << arr[0]<<"," << arr[1]<<"," << arr[2]<<"," << arr[3]<<"," << arr[4] << "\n";
    cout << "Sum:" << sum_positive(arr) << "\n";

    //-=-Problem 3-=-
    int primes[1000];
    primes[1] = true;
    primes[2] = true;
    for(int i = 0; i < 1000; i++){
        primes[i] = true;
        for (int j = 2; j <= i/2; j++){
            if (i % j == 0){
                primes[i] = false;
                break;
            }
        }
        cout << i << (primes[i] ? ": true" : ": false") << "\n"; 
    }

    //-=-Problem 4-=-
    string str = "vroomin and zoomin";
    cout<<"Before: "<<str<<"\n";
    revString(str);
    cout<<"After: "<<str<<"\n";


    do{
        cout << "Just to keep CMD open";
        cin >> input; 
    }while(floor(sqrt(input)) != sqrt(input));
}
