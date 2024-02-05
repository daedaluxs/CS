
var y = 100;

const states = [];

function myFunction(){
    console.log("Hello World")
}

function demoscript(){
    document.getElementById('demo').innerHTML = 'Javascript';
}

function checkAge(name,age){
    if(age < 21){
        console.log(`Sorry ${name} but you aren't old enough.`);
    }
}

//Javascript does not have 'classes'. They are all prototypes.

let person = function(firstname, lastname){
    this.firstname = firstname;
    this.lastname = lastname;
}

person.prototype.getName = function(){
    console.log(`Hello, ${this.firstname} ${this.lastname}`);
}

let john = new person('John', 'Doe');

john.getName();

let people =[];

people[0]={
    name: 'Harry',
    age: 2
};
people[1]={
    name: 'Jerry',
    age: 23
};
people[2]={
    name: 'Tom',
    age: 12
};
people[3]={
    name: 'Larry',
    age: 521
};
people[4]={
    name: 'Gary',
    age: 42
};

people.forEach(function (human){
    if(human.age %2 == 0){
        console.log('The world is nice and even!');
    }
    else{
        console.log('The world is nice and odd!');
    }
});

const filtered = people.filter(entry => entry.age >=25);

console.log(filtered);

const sum = people.reduce((total, curr) => total + curr.age,0);
console.log(sum);