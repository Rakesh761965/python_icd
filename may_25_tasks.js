// ================= TASK 1 =================

let studentFullName = "Rahul";
let studentAge = 20;
let studentCourse = "JavaScript";
let studentStatus = true;
let undefinedValue;
let nullValue = null;

console.log(studentFullName, typeof studentFullName);
console.log(studentAge, typeof studentAge);
console.log(studentCourse, typeof studentCourse);
console.log(studentStatus, typeof studentStatus);
console.log(undefinedValue, typeof undefinedValue);
console.log(nullValue, typeof nullValue);


// ================= TASK 2 =================

let studentInfo = {
    studentName: "Rahul",
    studentAgeValue: 20,
    studentCourseName: "JavaScript",
    studentCity: "Mumbai",
    studentScore: 85
};

console.log("Complete object:", studentInfo);
console.log("Name:", studentInfo.studentName);
console.log("Age:", studentInfo.studentAgeValue);
console.log("Course:", studentInfo.studentCourseName);
console.log("City:", studentInfo.studentCity);
console.log("Marks:", studentInfo.studentScore);


// ================= TASK 3 =================

let fruitsArray = ["Apple", "Banana", "Mango"];
let subjectsArray = ["Math", "Science", "English"];
let marksArray = [80, 90, 75];

console.log("First fruit:", fruitsArray[0]);

fruitsArray.push("Orange");
console.log("After adding:", fruitsArray);

fruitsArray.pop();
console.log("After removing:", fruitsArray);

console.log("Array length:", fruitsArray.length);

for (let fruitIndex = 0; fruitIndex < fruitsArray.length; fruitIndex++) {
    console.log(fruitsArray[fruitIndex]);
}


// ================= TASK 4 =================

let personAge = 20;

if (personAge >= 18) {
    console.log("Adult");
} else {
    console.log("Minor");
}

let studentMarksValue = 85;

if (studentMarksValue > 90) {
    console.log("Excellent");
} else if (studentMarksValue > 70) {
    console.log("Good");
} else if (studentMarksValue > 50) {
    console.log("Average");
} else {
    console.log("Fail");
}


// ================= TASK 5 =================

let selectedDay = 3;

switch (selectedDay) {
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


// ================= TASK 6 =================

console.log("FOR LOOP");

for (let numberValue = 1; numberValue <= 10; numberValue++) {
    console.log(numberValue);
}

console.log("WHILE LOOP");

let evenNumber = 2;

while (evenNumber <= 20) {
    console.log(evenNumber);
    evenNumber += 2;
}

console.log("DO WHILE LOOP");

let countdownValue = 5;

do {
    console.log(countdownValue);
    countdownValue--;
} while (countdownValue >= 1);


// ================= TASK 7 =================

function showGreeting() {
    console.log("Hello! Welcome to Student App");
}

function sumNumbers(firstNumber, secondNumber) {
    return firstNumber + secondNumber;
}

function findPercentage(obtainedMarks, totalMarks) {
    return (obtainedMarks / totalMarks) * 100;
}

function checkResult(scoreValue) {
    if (scoreValue >= 40) {
        return "Pass";
    } else {
        return "Fail";
    }
}

showGreeting();

console.log(sumNumbers(10, 5));
console.log(findPercentage(75, 100) + "%");
console.log(checkResult(35));


// ================= TASK 8 =================

let multiplyNumbers = (num1, num2) => num1 * num2;

let divideNumbers = (num1, num2) => num1 / num2;

let welcomeMessage = () => console.log("Welcome to Student App!");

console.log(multiplyNumbers(6, 7));
console.log(divideNumbers(20, 4));

welcomeMessage();


// ================= TASK 9 =================

let marksList = [88, 76, 92, 65, 81];

let totalMarksValue = 0;

for (let markIndex = 0; markIndex < marksList.length; markIndex++) {
    totalMarksValue += marksList[markIndex];
}

let averageMarks = totalMarksValue / marksList.length;

let finalGrade;

if (averageMarks > 90) {
    finalGrade = "A";
} else if (averageMarks > 75) {
    finalGrade = "B";
} else if (averageMarks > 60) {
    finalGrade = "C";
} else if (averageMarks > 40) {
    finalGrade = "D";
} else {
    finalGrade = "F";
}

console.log("Total:", totalMarksValue);
console.log("Average:", averageMarks);
console.log("Grade:", finalGrade);



// ================= 2nd TASKS =================
////////////////////////////////
///////////////////////////////
// TASK 1

// ========== TASK 1: Click Event ==========
let clickButton = document.createElement("button");
clickButton.textContent = "Click Me";
clickButton.onclick = () => alert("Button Clicked!");
document.body.appendChild(clickButton);

// ========== TASK 2: Mouseover ==========
let hoverBox = document.createElement("div");
hoverBox.textContent = "Hover Me";
hoverBox.style.cssText =
  "width:100px;height:100px;background:blue;color:white;margin:10px";

hoverBox.onmouseover = () => {
  hoverBox.style.background = "red";
};

hoverBox.onmouseout = () => {
  hoverBox.style.background = "blue";
};

document.body.appendChild(hoverBox);

// ========== TASK 3: Input Event ==========
let textInputField = document.createElement("input");
textInputField.placeholder = "Type here";

let inputDisplayText = document.createElement("p");

textInputField.oninput = () => {
  inputDisplayText.textContent =
    "You typed: " + textInputField.value;
};

document.body.appendChild(textInputField);
document.body.appendChild(inputDisplayText);

// ========== TASK 4: Submit Event ==========
let formElement = document.createElement("form");

let submitButtonElement = document.createElement("button");
submitButtonElement.textContent = "Submit";
submitButtonElement.type = "submit";

formElement.onsubmit = (event) => {
  event.preventDefault();
  alert("Form Submitted!");
};

formElement.appendChild(submitButtonElement);
document.body.appendChild(formElement);

// ========== TASK 5: Load Event ==========
window.onload = () => {
  console.log("Page loaded!");
};

// ========== TASK 6: Keypress ==========
let keyboardInput = document.createElement("input");
keyboardInput.placeholder = "Press a key";

let keyboardDisplay = document.createElement("p");

keyboardInput.onkeyup = (event) => {
  keyboardDisplay.textContent =
    "Last key: " + event.key;
};

document.body.appendChild(keyboardInput);
document.body.appendChild(keyboardDisplay);

// ========== TASK 7: Character Count ==========
let messageTextarea = document.createElement("textarea");
messageTextarea.placeholder = "Type something";

let characterCounter = document.createElement("p");

messageTextarea.onkeyup = () => {
  characterCounter.textContent =
    "Characters: " + messageTextarea.value.length;
};

document.body.appendChild(messageTextarea);
document.body.appendChild(characterCounter);

// ========== TASK 8: Password Show/Hide ==========
let passwordInputField = document.createElement("input");
passwordInputField.type = "password";

let passwordToggleButton = document.createElement("button");
passwordToggleButton.textContent = "Show";

passwordToggleButton.onclick = () => {
  if (passwordInputField.type === "password") {
    passwordInputField.type = "text";
    passwordToggleButton.textContent = "Hide";
  } else {
    passwordInputField.type = "password";
    passwordToggleButton.textContent = "Show";
  }
};

document.body.appendChild(passwordInputField);
document.body.appendChild(passwordToggleButton);

// ========== TASK 9: Double Click ==========
let doubleClickButton = document.createElement("button");
doubleClickButton.textContent = "Double Click Me";

doubleClickButton.ondblclick = () => {
  doubleClickButton.style.background = "green";
  doubleClickButton.textContent = "Clicked!";

  setTimeout(() => {
    doubleClickButton.style.background = "";
    doubleClickButton.textContent = "Double Click Me";
  }, 500);
};

document.body.appendChild(doubleClickButton);

// ========== TASK 10: Image Hover ==========
let hoverImage = document.createElement("img");

hoverImage.src = "https://picsum.photos/id/1/100/100";
hoverImage.style.width = "100px";

hoverImage.onmouseover = () => {
  hoverImage.src = "https://picsum.photos/id/20/100/100";
};

hoverImage.onmouseout = () => {
  hoverImage.src = "https://picsum.photos/id/1/100/100";
};

document.body.appendChild(hoverImage);

// ========== TASK 11: Focus & Blur ==========
let focusInputField = document.createElement("input");
focusInputField.placeholder = "Click me";

let focusMessage = document.createElement("p");

focusInputField.onfocus = () => {
  focusMessage.textContent = "Input focused";
};

focusInputField.onblur = () => {
  focusMessage.textContent = "Input blurred";
};

document.body.appendChild(focusInputField);
document.body.appendChild(focusMessage);

// ========== TASK 12: Mouse Events ==========
let mouseHoverBox = document.createElement("div");

mouseHoverBox.textContent = "Hover";
mouseHoverBox.style.cssText =
  "width:100px;height:100px;background:yellow;margin:10px";

mouseHoverBox.onmouseenter = () => {
  mouseHoverBox.style.background = "orange";
};

mouseHoverBox.onmouseleave = () => {
  mouseHoverBox.style.background = "yellow";
};

document.body.appendChild(mouseHoverBox);

// ========== TASK 13: Key Detector ==========
let keyDetectorInput = document.createElement("input");
keyDetectorInput.placeholder = "Press any key";

let pressedKeyDisplay = document.createElement("p");

keyDetectorInput.onkeydown = (event) => {
  pressedKeyDisplay.textContent =
    "You pressed: " + event.key;
};

document.body.appendChild(keyDetectorInput);
document.body.appendChild(pressedKeyDisplay);

// ========== TASK 14: Counter ==========
let counterValue = 0;

let counterHeading = document.createElement("h2");
counterHeading.textContent = "Count: 0";

let increaseButton = document.createElement("button");
increaseButton.textContent = "+";

let decreaseButton = document.createElement("button");
decreaseButton.textContent = "-";

let resetCounterButton = document.createElement("button");
resetCounterButton.textContent = "Reset";

increaseButton.onclick = () => {
  counterValue++;
  counterHeading.textContent =
    "Count: " + counterValue;
};

decreaseButton.onclick = () => {
  counterValue--;
  counterHeading.textContent =
    "Count: " + counterValue;
};

resetCounterButton.onclick = () => {
  counterValue = 0;
  counterHeading.textContent = "Count: 0";
};

document.body.appendChild(counterHeading);
document.body.appendChild(increaseButton);
document.body.appendChild(decreaseButton);
document.body.appendChild(resetCounterButton);

// ========== TASK 15: Simple To-Do List ==========
let todoInputField = document.createElement("input");
todoInputField.placeholder = "Add task";

let addTaskButton = document.createElement("button");
addTaskButton.textContent = "Add";

let todoUnorderedList = document.createElement("ul");

addTaskButton.onclick = () => {
  if (todoInputField.value.trim() !== "") {

    let todoListItem = document.createElement("li");
    todoListItem.textContent = todoInputField.value;

    let removeTaskButton = document.createElement("button");
    removeTaskButton.textContent = "X";

    removeTaskButton.onclick = () => {
      todoListItem.remove();
    };

    todoListItem.appendChild(removeTaskButton);
    todoUnorderedList.appendChild(todoListItem);

    todoInputField.value = "";
  }
};

document.body.appendChild(todoInputField);
document.body.appendChild(addTaskButton);
document.body.appendChild(todoUnorderedList);