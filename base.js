// function jk(){
//     console.log('hello')
// }


// console.log(name)
// var name='hey'
// console.log(name)
// let nam='kl'
// console.log(nam)
// let nam='lk'
// console.log(nam)

let name='rr'
console.log(name,typeof(name))
let age=20
console.log(age,typeof(age))
let x
console.log(x,typeof(x))
let data=null
console.log(data)
let student={
    name:'rr',
    age:20

}
console.log(student,typeof(student))

let fruits=['apple','mango']
console.log(fruits[0])

let ages=20
if (age>=10){
    console.log('adult')

}
else{
    console.log('minor')
}

let day=1
switch(day){
case 1:
    console.log('monday')
    break 
}

for(let i=1;i<6;i++){
    console.log(i)

}

i=1
while (i<=5){
    console.log(i)
    i++
}

do{
    console.log(i)
    i++
}
while(i<=5)



function greet(){
    console.log('hello')

}

greet()
function add(a,b){
    return a+b
}
a=add(3,4)

// task1

let studentName = "Rahul";
let agess = 20;
let course = "JavaScript";
let isEnrolled = true;
let emptyVariable;
let nullVariable = null;

console.log(studentName, typeof studentName);
console.log(age, typeof age);
console.log(course, typeof course);
console.log(isEnrolled, typeof isEnrolled);
console.log(emptyVariable, typeof emptyVariable);
console.log(nullVariable, typeof nullVariable);

//task2

let students = {
name: "Rahul",
age: 20,
course: "JavaScript",
city: "Mumbai",
marks: 85
};
console.log("Complete object:", student);
console.log("Name:", student.name);
console.log("Age:", student.age);
console.log("Course:", student.course);
console.log("City:", student.city);
console.log("Marks:", student.marks);


//task3

let fruitss = ["Apple", "Banana", "Mango"];
let subjects = ["Math", "Science", "English"];
let studentMarks = [80, 90, 75];

console.log("First fruit:", fruits[0]);
fruits.push("Orange");
console.log("After adding:", fruits);
fruits.pop();
console.log("After removing:", fruits);
console.log("Array length:", fruits.length);
console.log("Looping through fruits:");
for(let i = 0; i < fruits.length; i++) {
console.log(fruits[i]);
}

///////////task4

if(age >= 18) {
console.log("Adult");
} else {
console.log("Minor");
}

let marks = 85;
if(marks > 90) {
console.log("Excellent");
} else if(marks > 70) {
console.log("Good");
} else if(marks > 50) {
console.log("Average");
} else {
console.log("Fail");
}


//task5

let days = 3;
switch(day) {
case 1:
console.log("Monday");
break;
case 2:
console.log("Tuesday");
break;
case 3:
console.log("Wednesday");
break;
case 4:
console.log("Thursday");
break;
case 5:
console.log("Friday");
break;
default:
console.log("Invalid Day");
}


///task6

console.log("FOR LOOP (1 to 10):");
for(let i = 1; i <= 10; i++) {
console.log(i);
}

console.log("WHILE LOOP (Even numbers 2 to 20):");
let num = 2;
while(num <= 20) {
console.log(num);
num += 2;
}

console.log("DO-WHILE LOOP (Countdown 5 to 1):");
let count = 5;
do {
console.log(count);
count--;
} while(count >= 1);


//task7

function greetUser() {
console.log("Hello! Welcome to Student App");
}

function addNumbers(a, b) {
return a + b;
}

function calculatePercentage(obtained, total) {
return (obtained / total) * 100;
}

function checkPassFail(score) {
if(score >= 40) {
return "Pass";
} else {
return "Fail";
}
}
greetUser();
console.log("Addition (10 + 5):", addNumbers(10, 5));
console.log("Percentage (75 out of 100):", calculatePercentage(75, 100) + "%");
console.log("Pass/Fail status for 35 marks:", checkPassFail(35));


///task8

let multiply = (x, y) => x * y;
let division = (x, y) => x / y;
let displayWelcome = () => console.log("Welcome to Student App!");

console.log("Multiplication (6 x 7):", multiply(6, 7));
console.log("Division (20 / 4):", division(20, 4));
displayWelcome();


//task9

let subjectMarks = [88, 76, 92, 65, 81];
let total = 0;

for(let i = 0; i < subjectMarks.length; i++) {
total += subjectMarks[i];
}

let average = total / subjectMarks.length;
let grade;

if(average > 90) {
grade = "A";
} else if(average > 75) {
grade = "B";
} else if(average > 60) {
grade = "C";
} else if(average > 40) {
grade = "D";
} else {
grade = "F";
}

console.log("Subject Marks:", subjectMarks);
console.log("Total Marks:", total);
console.log("Average:", average);
console.log("Grade:", grade);
