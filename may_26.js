// Task 1 - Color Buttons
// ======================

// Create container
let colorDiv = document.createElement("div");
document.body.appendChild(colorDiv);

// Colors array
let colors = ["Red", "Green", "Blue", "Yellow"];

// forEach
colors.forEach(function(color){

let btn = document.createElement("button");

btn.innerHTML = color;

btn.style.margin = "10px";

btn.addEventListener("click", function(){

document.body.style.backgroundColor =
color.toLowerCase();

alert(color);
});

colorDiv.appendChild(btn);
});


// ======================
// Task 2 - Student List
// ======================

let title2 = document.createElement("h2");
title2.innerHTML = "Student List";
document.body.appendChild(title2);

let ul = document.createElement("ul");
document.body.appendChild(ul);

let students = ["Rahul", "Aman", "Priya", "Neha"];

students.forEach(function(student){

let li = document.createElement("li");

li.innerHTML = student;

li.style.cursor = "pointer";

li.addEventListener("click", function(){

alert("You selected " + student);

li.style.color = "blue";
});

ul.appendChild(li);
});


// ======================
// Task 3 - Product Cards
// ======================

let title3 = document.createElement("h2");
title3.innerHTML = "Product Cards";
document.body.appendChild(title3);

let products = [

{name:"Laptop", price:50000},

{name:"Phone", price:20000},

{name:"Watch", price:3000}
];

products.forEach(function(product){

let card = document.createElement("div");

card.style.border = "1px solid black";

card.style.width = "200px";

card.style.padding = "10px";

card.style.margin = "10px";

card.style.display = "inline-block";

let name = document.createElement("h3");
name.innerHTML = product.name;

let price = document.createElement("p");
price.innerHTML = "₹" + product.price;

let btn = document.createElement("button");
btn.innerHTML = "Buy";

btn.addEventListener("click", function(){

alert(product.name + " Added to Cart");

btn.innerHTML = "Added";
});

card.appendChild(name);

card.appendChild(price);

card.appendChild(btn);

document.body.appendChild(card);
});


// ======================
// Task 4 - Image Gallery
// ======================

let title4 = document.createElement("h2");
title4.innerHTML = "Image Gallery";
document.body.appendChild(title4);

let text = document.createElement("p");
document.body.appendChild(text);

let images = [

"https://picsum.photos/200?1",

"https://picsum.photos/200?2",

"https://picsum.photos/200?3"
];

images.forEach(function(image,index){

let img = document.createElement("img");

img.src = image;

img.style.width = "150px";

img.style.height = "150px";

img.style.margin = "10px";

img.addEventListener("click", function(){

img.style.width = "220px";

img.style.border = "4px solid red";

text.innerHTML =
"Image " + (index+1) + " clicked";
});

document.body.appendChild(img);
});


// ======================
// Task 5 - Todo List
// ======================

let title5 = document.createElement("h2");

title5.innerHTML = "Todo List";

document.body.appendChild(title5);

let input = document.createElement("input");

document.body.appendChild(input);

let addBtn = document.createElement("button");

addBtn.innerHTML = "Add Task";

document.body.appendChild(addBtn);

let todoList = document.createElement("ul");

document.body.appendChild(todoList);

let tasks = [];

addBtn.addEventListener("click", function(){

tasks.push(input.value);

displayTasks();

input.value = "";
});

function displayTasks(){

todoList.innerHTML = "";

tasks.forEach(function(task){

let li = document.createElement("li");

li.innerHTML = task;

li.style.cursor = "pointer";

li.addEventListener("click", function(){

li.style.textDecoration = "line-through";

li.style.color = "gray";
});

todoList.appendChild(li);
});
}
