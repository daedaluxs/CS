#include <string>
#include <iostream>
#include <cstring>
using namespace std;

class Seminar
{
    int time;

public:
    Seminar() // Function 1
    {
        time = 30;
        cout << "Seminar starts now" << endl;
    }
    void lecture() // Function 2
    {
        cout << "Lectures in the seminar on" << endl;
    }
    Seminar(int duration) // Function 3
    {
        time = duration;
        cout << "Seminar starts now" << endl;
    }
    ~Seminar() // Function 4
    {
        cout << "Thanks" << endl;
    }
};


int problem1(int value)
{
    std::cout << "Start:" << value << endl;
    switch (value)
    {
    case 1:
    case 2:
        return (2 * value - 1);
        break;
    case 3:

    case 5:
        return (3 * value + 1);
        break;
    case 4:
        return (4 * value - 1);
    case 6:
    case 7:
    case 8:
        return (value - 2);
        break;
    default:
        return value;
        break;
    }
}

class Test
{
    char paper[20];
    int marks;

public:
    Test() // Function 1
    {
        strcpy(paper, "Computer");
        marks = 0;
    }
    Test(char p[]) // Function 2
    {
        strcpy(paper, p);
        marks = 0;
    }

    Test(int m) // Function 3
    {
        strcpy(paper, "Computer");
        marks = m;
    }
    Test(char p[], int m) // Function 4
    {
        strcpy(paper, p);
        marks = m;
    }
    void printer(){
        std::cout<<paper<<" "<<marks<<endl;
    }
};

int main(int argc, char const *argv[])
{
    std::cout << problem1(1) << endl;
    std::cout << problem1(2) << endl;
    std::cout << problem1(3) << endl;
    std::cout << problem1(4) << endl;
    std::cout << problem1(5) << endl;
    std::cout << problem1(6) << endl;
    std::cout <<  problem1(7) << endl;
    std::cout <<  problem1(8) << endl;
    std::cout <<  problem1(9) << endl;

    Seminar *obj = new Seminar();
    delete obj;
    obj = new Seminar(60);
    obj->lecture();

    Test t1;
    Test t2('p');
    t2.printer;


    char *teststring = "random letters";
    Test *obj = new Test();
    obj->printer();
    delete obj;
    obj = new Test(teststring);
    obj->printer();
    delete obj;
    obj = new Test(8);
    obj->printer();
    delete obj;
    obj = new Test(teststring,12);
    obj->printer();
    delete obj;
    return 0;
}
