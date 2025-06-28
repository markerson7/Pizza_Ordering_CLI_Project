# Pizza Ordering CLI App

This is a Dart command-line application that implements a pizza ordering system with full input validation, order persistence to JSON, and customizable pizza options.  

**Advanced Mobile Application Development Group Assignment**

## Group Members ##
## Names                                    RegNum

# Markerson D Flomo                        20724/2022
# Israel K Slewion                         20340/2022
# James H Dugulu                           20908/2023

---

## Features

✅ User-friendly command-line interface  
✅ Multiple pizzas per order  
✅ Custom slices, crust, meat, veggie, toppings, size  
✅ Delivery or pickup option  
✅ Discounts (5% for >1 pizza)  
✅ Customer details  
✅ Order summary with price breakdown  
✅ Saves orders in JSON file  
✅ Loads past orders on startup  

---

## Project Structure

PIZZA_ORDERING
├── bin/
│   └── pizza_ordering.dart
├── lib/
│   ├── enums/
│   │   ├── crust_type.dart
│   │   ├── meat_type.dart
│   │   ├── size.dart
│   │   ├── topping.dart
│   │   └── veggie_type.dart
│   ├── models/
│   │   ├── customer.dart
│   │   ├── invalid_pizza_exception.dart
│   │   ├── order.dart
│   │   └── pizza.dart
│   └── utils/
│       └── file_handler.dart
├── pizza_orders.json
├── pubspec.yaml
├── README.md


---

## ✅ Prerequisites

- Dart SDK installed.  
  
  check with:  dart --version


- VS Code or any code editor.

---

## 🚀 How to Run

### 1️⃣ Clone /  or download the project

git clone <your-repo-url>
cd pizza_ordering_project


Or just unzip it if you downloaded as a ZIP.

---

### 2️⃣ Get Dependencies

Most Dart CLI apps don't need extra packages, but always do:

dart pug get

---

### 3️⃣ Run the App

```bash
dart run bin/pizze_ordering.dart



#🧭 Notes
If user input is invalid (e.g. wrong index, letters instead of numbers), the app will re-prompt until a valid choice is entered.
Multiple toppings can be selected by entering indices separated by commas (e.g. 0,2,5).


#👥 Author Info
Group project for Advanced Mobile Application Development

Designed to meet assignment requirements including:

Constructors (default and named)

Getters/setters

toString

Private instance variables

Exception handling

Enums

File I/O

JSON storage


#📜 License 
Free for educational use. Modify as needed for your project submission.
